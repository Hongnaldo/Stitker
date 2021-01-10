--■■■ 트리거(TRIGGER) 생성 ■■■--

-- 스터디 시작 전 업데이트된 경우 리더제외 모든 스터디원 참여날짜 NULL로 업데이트
CREATE OR REPLACE TRIGGER TRG_AFTER_UPDATE_STUDY
AFTER 
UPDATE ON TBL_STUDY_OPEN
FOR EACH ROW
DECLARE    
BEGIN
--
--    --종료 날짜가 현재이하로 업데이트됐다면 출석부/일정관리 남은것 지우기
--    IF (:OLD.END_DATE != :NEW.END_DATE AND :NEW.END_DATE <= SYSDATE)
--    THEN
--        -- 일정관리 지우기
--        DELETE
--        FROM TBL_STUDY_SCHEDULE S 
--        WHERE EXISTS(
--            SELECT *
--            FROM TBL_STUDY_ATTEND A
--            WHERE A.ATTEND_CODE = S.ATTEND_CODE
--             AND A.ATTEND_DATE > :NEW.END_DATE
--        );
--        -- 출석부 지우기
--        DELETE
--        FROM TBL_STUDY_ATTEND
--        WHERE ATTEND_DATE > :NEW.END_DATE;
        
    -- 시작날짜가 현재보다 미래면(아직 시작 안함) 리더 제외한 스터디원 모두 신청날짜 NULL로 업데이트
    IF (:NEW.START_DATE > SYSDATE AND :NEW.HITCOUNT = :OLD.HITCOUNT)
        THEN PRC_UPDATE_DATE_NULL(:NEW.STUDY_CODE); 
    END IF;
END;
--==>> Trigger TRG_AFTER_UPDATE_STUDY이(가) 컴파일되었습니다.



-- 뷰 생성
CREATE OR REPLACE VIEW STUDY_CANCEL_VIEW
AS
SELECT O.STUDY_CODE 스터디코드, A.APPLY_CODE 참가코드, A.USER_CODE 참여자, C.CANCEL_CODE 취소코드, C.CANCEL_DATE 취소날짜, C.AUTO_CANCEL 자동취소여부, P.POSITION_CODE 직책, O.USER_CODE AS 개설자 
     , O.START_DATE 시작일, O.END_DATE 종료일, M.MEMNUM AS 최소인원, O.WRITE_DATE 작성일
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        JOIN TBL_MEMNUM M
        ON M.MEMNUM_CODE = O.MIN_MEM_CODE
            LEFT JOIN TBL_STUDY_CANCEL C
            ON C.APPLY_CODE = A.APPLY_CODE
                JOIN TBL_MEMNUM M2
                ON M2.MEMNUM_CODE = O.MAX_MEM_CODE
                    JOIN TBL_STUDY_POSITION P
                    ON A.POSITION_CODE = P.POSITION_CODE;
--==>> View STUDY_CANCEL_VIEW이(가) 생성되었습니다.


---- 스터디취소처리 인서트 트리거
--CREATE OR REPLACE TRIGGER TRG_AFTER_INSERT_CANCEL
--AFTER 
--INSERT ON TBL_STUDY_CANCEL
--FOR EACH ROW
--DECLARE
--    V_STUDY TBL_STUDY_OPEN.STUDY_CODE%TYPE;
--    V_LEFT  NUMBER;
--    V_MIN   TBL_MEMNUM.MEMNUM%TYPE;
--    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;
--    V_END_DATE   TBL_STUDY_OPEN.END_DATE%TYPE;
--    V_AUTO_CANCEL   TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE;
--    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
--    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
--BEGIN
--    -- 스터디 코드 가져오기
--    SELECT STUDY_CODE INTO V_STUDY
--    FROM STUDY_CANCEL_VIEW
--    WHERE CANCEL_CODE = :NEW.CANCEL_CODE;
--    
--    -- 해당 스터디에 남은 사람 세기
--    SELECT COUNT(*) INTO V_LEFT
--    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
--        ON A.APPLY_CODE = C.APPLY_CODE
--    WHERE CANCEL_CODE IS NULL;
--    
--    -- 최소인원, 시작날짜, 종료날짜, 자동취소처리여부, 사용자코드 가져오기
--    SELECT MINNUM, START_DATE, AUTO_CANCEL, USER_CODE, FIRSTLEADER
--        INTO V_MIN, V_START_DATE, V_AUTO_CANCEL, V_USER_CODE, V_FIRSTLEADER
--    FROM STUDY_CANCEL_VIEW
--    WHERE APPLY_CODE = :NEW.APPLY_CODE;
--        
--    -- 최소인원보다 적게 남은 경우
--    IF (V_LEFT < V_MIN)
--    THEN 
--        -- 스터디가 진행중인지 확인
--        IF (V_START_DATE < SYSDATE)
--        THEN
--            -- ▶최소인원미만, 진행중 : 스터디 종료시킴.(종료날짜 오늘로.)
--            UPDATE TBL_STUDY_OPEN
--            SET END_DATE = SYSDATE
--            WHERE STUDY_CODE = V_STUDY;
--        END IF;
--    
--    -- 최소인원보다 많이 남은 경우 자발적인 것인지 확인(자발적이면 NULL, 자동취소면 1)
--    ELSIF (V_AUTO_CANCEL IS NULL)
--    THEN
--        -- 스터디가 진행중인지 확인
--        IF (V_START_DATE < SYSDATE)
--        THEN 
--            -- ▶진행중, 개설자, 자발적 : -200
--            IF (V_FIRSTLEADER = V_USER_CODE)
--            THEN
--            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, SYSDATE);
--            
--            -- ▶진행중, 개설자X, 자발적 : -100
--            ELSE
--            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
--            
--            END IF;
--        ELSE
--            -- ▶최소인원이상, 진행중X : 리더제외 NULL로 만듦
--            PRC_UPDATE_DATE_NULL(V_STUDY); 
--            
--            -- 확정기간 마지막 2일인지 확인
--            IF (SYSDATE BETWEEN V_START_DATE-1 AND V_START_DATE-2)
--            THEN
--                -- ▶확정기간 마지막2일, 개설자, 자발적 : -100
--                IF (V_FIRSTLEADER = V_USER_CODE)
--                THEN
--                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
--                    
--                -- ▶확정기간 마지막2일, 개설자X, 자발적 : -30    
--                ELSE
--                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, SYSDATE);
--                END IF;
--            END IF;            
--        END IF;
--    END IF;  
--    
--END;
----==>> Trigger TRG_AFTER_INSERT_CANCEL이(가) 컴파일되었습니다.
--
--DROP TRIGGER TRG_AFTER_INSERT_CANCEL;


