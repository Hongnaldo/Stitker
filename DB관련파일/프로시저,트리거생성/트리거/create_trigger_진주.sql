--■■■ 트리거(TRIGGER) 생성 ■■■--

--○ 스터디 진행 테이블 INSERT -> 모집마감일 이전에 INSERT됐는지 체크
-- -> 맞으면 스터디개설 테이블의 모집마감일을 UPDATE
CREATE OR REPLACE TRIGGER TRG_STD_PARTI_INSERT
    AFTER
    INSERT ON TBL_STUDY_PARTICIPANT
    FOR EACH ROW
DECLARE
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE; -- 시작한 스터디 코드
    V_CLOSE_DATE    TBL_STUDY_OPEN.CLOSE_DATE%TYPE; -- 이 스터디의 원래 모집 마감일
BEGIN
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = :NEW.APPLY_CODE
      AND POSITION_CODE = 'SP1'; 
      
    SELECT CLOSE_DATE INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    IF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') < TO_DATE(V_CLOSE_DATE, 'YYYY-MM-DD') )
        THEN UPDATE TBL_STUDY_OPEN
             SET CLOSE_DATE = SYSDATE
             WHERE STUDY_CODE = V_STUDY_CODE;
             
    END IF;
    
END;



--○ 스터디 개설 테이블에 INSERT 수행 전 -> 
--  MAX_MEM이 MIN_MEM 이상인지 체크 -> MIN_MEM보다 작으면 에러 발생시킴(미완)
CREATE OR REPLACE TRIGGER TRG_STD_OPEN_INSERT
    BEFORE
    INSERT ON TBL_STUDY_OPEN
    FOR EACH ROW
DECLARE
    V_MIN_MEM TBL_MEMNUM.MEMNUM%TYPE;
    V_MAX_MEM TBL_MEMNUM.MEMNUM%TYPE;    
BEGIN 

    SELECT MEMNUM AS MIN_MEM INTO V_MIN_MEM
    FROM TBL_MEMNUM 
    WHERE MEMNUM_CODE = :NEW.MIN_MEM_CODE;

    SELECT MEMNUM AS MAX_MEM INTO V_MAX_MEM
    FROM TBL_MEMNUM
    WHERE MEMNUM_CODE = :NEW.MAX_MEM_CODE;  

    IF ( V_MAX_MEM < V_MIN_MEM )
        THEN RAISE_APPLICATION_ERROR(-20003, '최대 인원수는 최소 인원수 이상이어야 합니다.');
    END IF;
END;
--==>> Trigger TRG_STD_OPEN_INSERT이(가) 컴파일되었습니다.



--○ 탈퇴 테이블에 INSERT 수행 후 -> 회원 등록 테이블에서 정보 삭제
CREATE OR REPLACE TRIGGER TRG_WDL_INSERT
    AFTER
    INSERT ON TBL_WITHDRAWAL_INFO
    FOR EACH ROW
DECLARE
BEGIN
    DELETE
    FROM TBL_USER_REGISTER
    WHERE USER_CODE = :NEW.USER_CODE;
END;
--==>> Trigger TRG_WDL_INSERT이(가) 컴파일되었습니다.




--○ 취소테이블에 INSERT 후
-- -> 진행중인지(START_DATE 이전인지 이후인지)체크
-- -> 리더(작성자)인지 체크 
-- -> 리더면 진행테이블에 남아있는 사람들 중 점수가 가장 높은 사람의 직책을 리더로 업데이트

-- 실행 예 : EXEC PRC_STD_CANC_INSERT(신청코드)
-- 실행 예 : EXEC PRC_STD_CANC_INSERT(신청코드, 오토캔슬값)

CREATE OR REPLACE PROCEDURE PRC_STD_CANC_INSERT
( V_APPLY_CODE    IN TBL_STUDY_APPLY.APPLY_CODE%TYPE
--, V_AUTO_CANCEL   IN TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE
)
IS
    V_POSITION_CODE TBL_STUDY_POSITION.POSITION_CODE%TYPE;  -- 취소한 사용자의 POSITION_CODE
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- 취소한 사용자의 USER_CODE
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;         -- 취소한 STUDY_CODE
    V_WRITER_CODE   TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- 취소한 스터디 작성자 USER_CODE
    V_START_DATE    TBL_STUDY_OPEN.START_DATE%TYPE;         -- 스터디 시작일
    V_NEW_LEADER    TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- 모집중, 가장 높은 점수인 사용자의 USER_CODE
    P_NEW_LEADER    TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- 진행중, 가장 높은 점수인 사용자의 USER_CODE   
    

BEGIN

    
    -- 오토 캔슬 값도 입력받아야 하면 입력 쿼리문 이거 쓰기
    --INSERT INTO TBL_STUDY_CANCEL (CANCEL_CODE, APPLY_CODE, AUTO_CANCEL)
    --VALUES ('SC'|| STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, V_AUTO_CANCEL);
    
    -- 스터디 취소
    INSERT INTO TBL_STUDY_CANCEL (CANCEL_CODE, APPLY_CODE)
    VALUES ('SC'|| STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE);
    
    
    -- V_POSITION_CODE, V_USER_CODE 
    SELECT POSITION_CODE, USER_CODE INTO V_POSITION_CODE, V_USER_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = V_APPLY_CODE;  
    
    -- V_STUDY_CODE 
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = V_APPLY_CODE;
    
    -- V_WRITER_CODE
    SELECT USER_CODE INTO V_WRITER_CODE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    -- V_START_DATE
    SELECT START_DATE INTO V_START_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
   -- V_NEW_LEADER 
    SELECT USER_CODE INTO V_NEW_LEADER  
    FROM ( SELECT A.USER_CODE, SUM(S.SCORE) AS SCORESUM
           FROM TBL_STUDY_APPLY A, TBL_SCORE S
           WHERE STUDY_CODE = V_STUDY_CODE
             AND A.USER_CODE = S.USER_CODE
             AND A.USER_CODE NOT IN (   -- 신청테이블에 있지만 취소한 사람들의 USER_CODE
                                        SELECT USER_CODE
                                        FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
                                        WHERE A.STUDY_CODE =V_STUDY_CODE
                                          AND A.APPLY_CODE IN ( SELECT APPLY_CODE
                                                                FROM TBL_STUDY_CANCEL)
                                          AND C.APPLY_CODE IN (SELECT APPLY_CODE
                                                                FROM TBL_STUDY_APPLY
                                                                WHERE STUDY_CODE =V_STUDY_CODE)
                                        GROUP BY USER_CODE) 
           GROUP BY A.USER_CODE
           ORDER BY SCORESUM DESC )
    WHERE ROWNUM=1;
    
    -- P_NEW_LEADER
    SELECT USER_CODE INTO P_NEW_LEADER
    FROM 
    (   SELECT T.USER_CODE, SUM(S.SCORE) AS MAX_SCORE
        FROM 
        ( SELECT A.APPLY_CODE, A.STUDY_CODE, A.USER_CODE, A.POSITION_CODE
          FROM TBL_STUDY_APPLY A, TBL_STUDY_PARTICIPANT P
          WHERE A.APPLY_CODE = P.APPLY_CODE
            AND A.USER_CODE NOT IN (    -- 신청테이블에 있지만 취소한 사람들의 USER_CODE
                                        SELECT USER_CODE
                                        FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
                                        WHERE A.STUDY_CODE =V_STUDY_CODE
                                          AND A.APPLY_CODE IN ( SELECT APPLY_CODE
                                                                FROM TBL_STUDY_CANCEL)
                                          AND C.APPLY_CODE IN (SELECT APPLY_CODE
                                                                FROM TBL_STUDY_APPLY
                                                                WHERE STUDY_CODE =V_STUDY_CODE)
                                        GROUP BY USER_CODE)   
        ) T, TBL_SCORE S
        WHERE T.USER_CODE = S.USER_CODE
        GROUP BY T.USER_CODE
        ORDER BY MAX_SCORE DESC
    )
    WHERE ROWNUM=1;
    
    -- 모집중
    IF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') < TO_DATE(V_START_DATE, 'YYYY-MM-DD') )
        THEN            
        -- 신청 테이블에 있는 사람들 중에 가장 높은 점수를 가진 사람이 뉴리더
        IF ( V_POSITION_CODE = 'SP1' ) -- 취소한 사람이 리더이면
            THEN UPDATE TBL_STUDY_APPLY
                 SET POSITION_CODE = 'SP1'
                 WHERE USER_CODE = V_NEW_LEADER
                 AND STUDY_CODE = V_STUDY_CODE;
        END IF;
    
    -- 진행중  
    ELSIF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') > TO_DATE(V_START_DATE, 'YYYY-MM-DD') ) -- 진행중
            THEN 
            -- 진행 테이블에 있는 사람들 중에 가장 높은 점수를 가진 사람이 뉴리더
            IF ( V_POSITION_CODE = 'SP1' ) -- 취소한 사람이 리더이면
            THEN UPDATE TBL_STUDY_APPLY
                 SET POSITION_CODE = 'SP1'
                 WHERE USER_CODE = P_NEW_LEADER
                 AND STUDY_CODE = V_STUDY_CODE;
            END IF;   
            
    END IF;
    
    -- 커밋
    COMMIT;
    
END;






