--■■■ 트리거(TRIGGER) 생성 ■■■--
/*
"경고3회 -> 계정정지에 데이터없음 :  계정정지에 인서트
            계정정지에 데이터 있음 : 가장 최근 계정정지코드의 계정정지날짜가 1년이 지났음 -> 계정정지에 인서트
                                     가장 최근 계정정지코드의 계정정지날짜 sysdate로 업데이트"
"취소처리에 인서트 -> 최소인원미만 -> 스터디종료날짜를 오늘로 지정(업데이트) : 종료만 수정가능함. / 출석부 삭제..
                                                          -> (진행중인 스터디) 스터디종료된 상태가 됨. 
                                                               (진행전) 취소처리-자동으로됨.
                                   (진행중인스터디,자발적) 패널티 -100(개설자아님), -200(개설자)
                                   (확정기간 4,5일차,자발적) 패널티 -30점(개설자아님), -100(개설자)
                                   (진행중/진행전, 자발적아님) 패널티없음.
                                   (진행전, 자발적) 리더 제외한 나머지 사람 신청날짜 null로 업데이트(함수/프로시저 호출)"
"스터디업데이트 -> (sysdate 스터디시작날짜보다 미래)  출석부,일정관리 지우기(종료시점보다 미래의 데이터들만 모두 삭제)
                               (아직시작안됨) -> 리더 제외한 스터디원 모두 신청날짜 null로 업데이트(함수/프로시저 호출)"
*/


-- 경고 받을 때 마다 경고 수 세서 3개 이상이면 계정정지 / 유효기간 늘리기
CREATE OR REPLACE TRIGGER TRG_AFTER_INSERT_WARNING
AFTER
INSERT ON TBL_WARNING
FOR EACH ROW 
DECLARE
    -- 총 경고 개수 / 계정정지 이후 받은 경고 개수
    V_WARNING_COUNT   NUMBER;
    -- 가장 최근 계정정지 받은 경고 코드
    V_WARNING_CODE    VARCHAR2(15);
    -- 가장 최근 계정정지 받은 경고 날짜
    V_WARNING_DATE    DATE;
    -- 계정정지 개수
    V_SUSPEND_COUNT   NUMBER;
    -- 가장 최근 계정정지 코드
    V_SUSPEND_CODE    VARCHAR2(10);
    -- 가장 최근 계정정지 날짜
    V_SUSPEND_DATE    DATE;
    
BEGIN  
    -- 경고 개수 저장하기
    SELECT COUNT(*) INTO V_WARNING_COUNT
    FROM TBL_WARNING 
    WHERE USER_CODE = :NEW.USER_CODE;
    
    -- 경고가 3회 이상이면
    IF(V_WARNING_COUNT >= 3)
    
    THEN
        -- 계정정지 개수 저장하기
        SELECT COUNT(*) INTO V_SUSPEND_COUNT
        FROM TBL_WARNING W LEFT JOIN TBL_ACCOUNT_SUSPEND S
            ON W.WARNING_CODE = S.WARNING_CODE
        WHERE W.USER_CODE = :NEW.USER_CODE AND S.ACCT_SUS_CODE IS NOT NULL;
        
        -- 계정정지 이력이 존재하면 최근 계정정지 이후 경고수 세기
        IF (V_SUSPEND_COUNT > 0)
        THEN
            -- 가장 최근 계정정지 코드 저장
            SELECT MAX(S.ACCT_SUS_CODE) INTO V_SUSPEND_CODE
            FROM TBL_WARNING W LEFT JOIN TBL_ACCOUNT_SUSPEND S
                ON W.WARNING_CODE = S.WARNING_CODE
            WHERE W.USER_CODE = :NEW.USER_CODE;
            
            -- 가장 최근 계정정지와 이어진 경고코드 저장, 해당 경고코드 날짜 저장
            SELECT S.WARNING_CODE, W.WARNING_DATE INTO V_WARNING_CODE, V_WARNING_DATE
            FROM TBL_ACCOUNT_SUSPEND S JOIN TBL_WARNING W
                ON W.WARNING_CODE = S.WARNING_CODE
            WHERE S.ACCT_SUS_CODE = V_SUSPEND_CODE;
            
            -- 최근 계정정지 이후의 경고수 세기
            SELECT COUNT(*) INTO V_WARNING_COUNT
            FROM TBL_WARNING
            WHERE USER_CODE=:NEW.USER_CODE AND WARNING_DATE > V_WARNING_DATE;
            
            -- 현재 유효한 경고수가 3개 이상이면
            IF (V_WARNING_COUNT >= 3)
            THEN 
                -- 해당 계정정지 코드의 날짜 저장
                SELECT ACCT_SUS_DATE INTO V_SUSPEND_DATE
                FROM TBL_ACCOUNT_SUSPEND
                WHERE ACCT_SUS_CODE = V_SUSPEND_CODE;
                
                -- 종료됐으면 새로 계정정지 시키기
                IF (ADD_MONTHS(V_SUSPEND_DATE, 12) < SYSDATE)
                THEN
                    INSERT INTO TBL_ACCOUNT_SUSPEND(ACCT_SUS_CODE, ACCT_SUS_DATE, WARNING_CODE)
                    VALUES ('AS'||ACCT_SUS_SEQ.NEXTVAL, SYSDATE, :NEW.WARNING_CODE);
                    
                --종료안됐으면 업데이트 시키기    
                ELSE
                    UPDATE TBL_ACCOUNT_SUSPEND
                    SET ACCT_SUS_DATE = SYSDATE
                    WHERE ACCT_SUS_CODE = V_SUSPEND_CODE;
                END IF;
            END IF;    
        
        -- 계정정지 이력이 존재하지 않으면 새로 계정 정지에 등록
        ELSE
            INSERT INTO TBL_ACCOUNT_SUSPEND(ACCT_SUS_CODE, ACCT_SUS_DATE, WARNING_CODE)
            VALUES ('AS'||ACCT_SUS_SEQ.NEXTVAL, SYSDATE, :NEW.WARNING_CODE);
        END IF;
        
    END IF;        
END;      
--==>> Trigger TRG_AFTER_INSERT_WARNING이(가) 컴파일되었습니다.
    
    

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
        
    -- 시작날짜가 현재보다 이전이면(아직 시작 안함) 리더 제외한 스터디원 모두 신청날짜 NULL로 업데이트
    IF (:NEW.START_DATE < SYSDATE)
        THEN PRC_UPDATE_DATE_NULL(:NEW.STUDY_CODE); 
    END IF;
END;
--==>> Trigger TRG_AFTER_UPDATE_STUDY이(가) 컴파일되었습니다.


-- 뷰 생성
CREATE OR REPLACE VIEW STUDY_CANCEL_VIEW
AS
SELECT C.CANCEL_CODE, C.AUTO_CANCEL, A.APPLY_CODE, O.USER_CODE AS FIRSTLEADER, A.USER_CODE, P.POSITION_CODE
     , O.START_DATE, O.STUDY_CODE, O.END_DATE, M.MEMNUM AS MINNUM, O.WRITE_DATE
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        JOIN TBL_MEMNUM M
        ON M.MEMNUM_CODE = O.MIN_MEM_CODE
            JOIN TBL_STUDY_CANCEL C
            ON C.APPLY_CODE = A.APPLY_CODE
                JOIN TBL_MEMNUM M2
                ON M2.MEMNUM_CODE = O.MAX_MEM_CODE
                    JOIN TBL_STUDY_POSITION P
                    ON A.POSITION_CODE = P.POSITION_CODE;
--==>> View STUDY_CANCEL_VIEW이(가) 생성되었습니다.

SELECT *
FROM STUDY_CANCEL_VIEW;

-- 스터디취소처리 인서트 트리거
CREATE OR REPLACE TRIGGER TRG_AFTER_INSERT_CANCEL
AFTER 
INSERT ON TBL_STUDY_CANCEL
FOR EACH ROW
DECLARE
    V_STUDY TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_LEFT  NUMBER;
    V_MIN   TBL_MEMNUM.MEMNUM%TYPE;
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;
    V_END_DATE   TBL_STUDY_OPEN.END_DATE%TYPE;
    V_AUTO_CANCEL   TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE;
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
BEGIN
    -- 스터디 코드 가져오기
    SELECT STUDY_CODE INTO V_STUDY
    FROM STUDY_CANCEL_VIEW
    WHERE CANCEL_CODE = :NEW.CANCEL_CODE;
    
    -- 해당 스터디에 남은 사람 세기
    SELECT COUNT(*) INTO V_LEFT
    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
        ON A.APPLY_CODE = C.APPLY_CODE
    WHERE CANCEL_CODE IS NULL;
    
    -- 최소인원, 시작날짜, 종료날짜, 자동취소처리여부, 사용자코드 가져오기
    SELECT MINNUM, START_DATE, AUTO_CANCEL, USER_CODE, FIRSTLEADER
        INTO V_MIN, V_START_DATE, V_AUTO_CANCEL, V_USER_CODE, V_FIRSTLEADER
    FROM STUDY_CANCEL_VIEW
    WHERE APPLY_CODE = :NEW.APPLY_CODE;
        
    -- 최소인원보다 적게 남은 경우
    IF (V_LEFT < V_MIN)
    THEN 
        -- 스터디가 진행중인지 확인
        IF (V_START_DATE < SYSDATE)
        THEN
            -- ▶최소인원미만, 진행중 : 스터디 종료시킴.(종료날짜 오늘로.)
            UPDATE TBL_STUDY_OPEN
            SET END_DATE = SYSDATE
            WHERE STUDY_CODE = V_STUDY;
        END IF;
    
    -- 최소인원보다 많이 남은 경우 자발적인 것인지 확인(자발적이면 NULL, 자동취소면 1)
    ELSIF (V_AUTO_CANCEL IS NULL)
    THEN
        -- 스터디가 진행중인지 확인
        IF (V_START_DATE < SYSDATE)
        THEN 
            -- ▶진행중, 개설자, 자발적 : -200
            IF (V_FIRSTLEADER = V_USER_CODE)
            THEN
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, SYSDATE);
            
            -- ▶진행중, 개설자X, 자발적 : -100
            ELSE
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
            
            END IF;
        ELSE
            -- ▶최소인원이상, 진행중X : 리더제외 NULL로 만듦
            PRC_UPDATE_DATE_NULL(V_STUDY); 
            
            -- 확정기간 마지막 2일인지 확인
            IF (SYSDATE BETWEEN V_START_DATE-1 AND V_START_DATE-2)
            THEN
                -- ▶확정기간 마지막2일, 개설자, 자발적 : -100
                IF (V_FIRSTLEADER = V_USER_CODE)
                THEN
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
                    
                -- ▶확정기간 마지막2일, 개설자X, 자발적 : -30    
                ELSE
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, SYSDATE);
                END IF;
            END IF;            
        END IF;
    END IF;   
END;
--==>> Trigger TRG_AFTER_INSERT_CANCEL이(가) 컴파일되었습니다.

SELECT *
FROM TBL_STUDY_CANCEL;

CREATE OR REPLACE PROCEDURE PRC_INSERT_CANCEL
( V_APPLY_CODE    IN TBL_STUDY_APPLY.APPLY_CODE%TYPE
, V_CANCEL_DATE   IN TBL_STUDY_CANCEL.CANCEL_DATE%TYPE
, V_AUTO_CANCEL   IN TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE
)
IS
    V_CANCEL_CODE   TBL_STUDY_CANCEL.CANCEL_CODE%TYPE;
    V_STUDY TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_LEFT  NUMBER;
    V_MIN   TBL_MEMNUM.MEMNUM%TYPE;
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;
    V_END_DATE   TBL_STUDY_OPEN.END_DATE%TYPE;
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
BEGIN
    V_CANCEL_CODE := 'SC'|| STUDY_CANC_SEQ.NEXTVAL;
    INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
    VALUES(V_CANCEL_CODE, V_APPLY_CODE, TO_DATE('2020-12-14', 'YYYY-MM-DD'), V_AUTO_CANCEL);
    
    -- 스터디 코드 가져오기
    SELECT STUDY_CODE INTO V_STUDY
    FROM STUDY_CANCEL_VIEW
    WHERE CANCEL_CODE = V_CANCEL_CODE;
    
    -- 해당 스터디에 남은 사람 세기
    SELECT COUNT(*) INTO V_LEFT
    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
        ON A.APPLY_CODE = C.APPLY_CODE
    WHERE CANCEL_CODE IS NULL;
    
    -- 최소인원, 시작날짜, 종료날짜, 자동취소처리여부, 사용자코드 가져오기
    SELECT MINNUM, START_DATE, USER_CODE, FIRSTLEADER
        INTO V_MIN, V_START_DATE, V_USER_CODE, V_FIRSTLEADER
    FROM STUDY_CANCEL_VIEW
    WHERE APPLY_CODE = V_APPLY_CODE;
        
    -- 최소인원보다 적게 남은 경우
    IF (V_LEFT < V_MIN)
    THEN 
        -- 스터디가 진행중인지 확인
        IF (V_START_DATE < SYSDATE)
        THEN
            -- ▶최소인원미만, 진행중 : 스터디 종료시킴.(종료날짜 오늘로.)
            UPDATE TBL_STUDY_OPEN
            SET END_DATE = SYSDATE
            WHERE STUDY_CODE = V_STUDY;
        END IF;
    
    -- 최소인원보다 많이 남은 경우 자발적인 것인지 확인(자발적이면 NULL, 자동취소면 1)
    ELSIF (V_AUTO_CANCEL IS NULL)
    THEN
        -- 스터디가 진행중인지 확인
        IF (V_START_DATE < SYSDATE)
        THEN 
            -- ▶진행중, 개설자, 자발적 : -200
            IF (V_FIRSTLEADER = V_USER_CODE)
            THEN
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, SYSDATE);
            
            -- ▶진행중, 개설자X, 자발적 : -100
            ELSE
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
            
            END IF;
        ELSE
            -- ▶최소인원이상, 진행중X : 리더제외 NULL로 만듦
            PRC_UPDATE_DATE_NULL(V_STUDY); 
            
            -- 확정기간 마지막 2일인지 확인
            IF (SYSDATE BETWEEN V_START_DATE-1 AND V_START_DATE-2)
            THEN
                -- ▶확정기간 마지막2일, 개설자, 자발적 : -100
                IF (V_FIRSTLEADER = V_USER_CODE)
                THEN
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
                    
                -- ▶확정기간 마지막2일, 개설자X, 자발적 : -30    
                ELSE
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, SYSDATE);
                END IF;
            END IF;            
        END IF;
    END IF;   
END;