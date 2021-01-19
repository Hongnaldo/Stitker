

-- 시퀀스 앞에 영어 두 글자 수정하기

--○ it, 기술정보 공유 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BI_SCORE
        AFTER
        INSERT  ON TBL_BOARD_INFORM
        FOR EACH ROW    
BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;



--○ 면접,코딩테스트 후기 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BV_SCORE
        AFTER
        INSERT  ON TBL_BOARD_INTERVIEW
        FOR EACH ROW
BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;



--○ 세미나,공모전 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BS_SCORE
        AFTER
        INSERT  ON TBL_BOARD_SEMINAR
        FOR EACH ROW

BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;


--○ 스터디 후기 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BSR_SCORE
        AFTER
        INSERT  ON TBL_BOARD_STUDYREVIEW
        FOR EACH ROW
DECLARE  
V_USER_CODE VARCHAR2(10);

BEGIN
    
    -- 유저 코드 받아오기
    SELECT A.USER_CODE INTO V_USER_CODE
    FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
    ON P.APPLY_CODE = A.APPLY_CODE
    WHERE PARTI_CODE = :NEW.PARTI_CODE ;
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, 10, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;


commit;
---------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO TBL_BOARD_STUDYREVIEW
VALUES('SR1','PT3',SYSDATE,0,'ASDF','ASFSG','IM1');
ROLLBACK;
DROP TRIGGER TRG_SR_SCORE;
SELECT * FROM TBL_INTEREST_MC;
SELECT * FROM TBL_BOARD_STUDYREVIEW;
SELECT * FROM TBL_SCORE;
SELECT * FROM TBL_WARNING;
SELECT * FROM TBL_ACCOUNT_SUSPEND;
update TBL_BOARD_INFORM
SET CONTENT='수정확인'
WHERE POST_CODE = 'BI1';

-- it, 기술정보 공유 게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_INFORM
BEFORE 
UPDATE ON TBL_BOARD_INFORM
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN

        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_INFORM 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,'신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

--○ 면접,코딩테스트 후기 게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_INTERVIEW
BEFORE 
UPDATE ON TBL_BOARD_INTERVIEW
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_INTERVIEW 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--○ 세미나,공모전  게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_SEMINAR
BEFORE 
UPDATE ON TBL_BOARD_SEMINAR
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_SEMINAR 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--○ 자유게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_FREE
BEFORE 
UPDATE ON TBL_BOARD_FREE
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_FREE 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--○ Q&A질문  게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_QUESTION
BEFORE 
UPDATE ON TBL_BOARD_QUESTION
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_QUESTION 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--○ Q&A답변 게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_ANSWER
BEFORE 
UPDATE ON TBL_BOARD_ANSWER
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_ANSWER 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--○ 스터디 후기 게시판 수정 BEFORE 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_STUDYREVIEW
BEFORE 
UPDATE ON TBL_BOARD_STUDYREVIEW
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- 예외 처리 변수 선언
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --○ 신고 갯수 확인
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_STUDYREVIEW 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

---------------------------------------------
SELECT * FROM TBL_USER_RANK;
SELECT * FROM VIEW_STUDY_NOW;
SELECT * FROM TBL_STUDY_OPEN ORDER BY USER_CODE;
SELECT * FROM TBL_USER_REGISTER WHERE ID ='khj77'; --uc1,uc7
SELECT * FROM  ACCOUNT_SUSPEND_VIEW;
INSERT INTO TBL_STUDY_OPEN
(study_code, user_code, write_date, hitcount , study_type_code, interest_mc_code, start_date, end_date, min_mem_code, max_mem_code, study_name, min_rank, close_date, study_desc , loc_mc_code) 
VALUES('SO'||STD_OPEN_SEQ.NEXTVAL, 'UC4', SYSDATE, 0, 'ST3', 'IM7', '2021-01-22', '2021-02-10', 'MN1', 'MN6', '뉴테스트', 'UR4', '2021-01-20', '뉴테스트', 'LM1');


-- 스터디 개설 비포 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_INSERT_STUDY_OPEN
BEFORE 
INSERT ON TBL_STUDY_OPEN
FOR EACH ROW

DECLARE  
V_ID                      VARCHAR2(30);
V_SUSPEND_CHECK NUMBER;
V_STUDY_NUM      NUMBER;
V_SCORE_NUM      NUMBER;

-- 예외 처리 변수 선언
SUSPEND_CHECK_ERROR   EXCEPTION;
STUDY_NUM_ERROR         EXCEPTION;
SCORE_NUM_ERROR         EXCEPTION;
        
BEGIN
        --○ 계정정지 확인을 위한 ID 값 가져오기
        SELECT ID INTO V_ID
        FROM TBL_USER_REGISTER
        WHERE USER_CODE = :NEW.USER_CODE;
        
        --○ 계정정지 확인
        SELECT COUNT(*) INTO V_SUSPEND_CHECK
        FROM  ACCOUNT_SUSPEND_VIEW 
        WHERE ID = V_ID;
        
        IF(V_SUSPEND_CHECK = 1 )
        THEN    RAISE SUSPEND_CHECK_ERROR;
        
        ELSE
            --○ 등급 확인
            SELECT SUM(SCORE) INTO V_SCORE_NUM
            FROM TBL_SCORE
            WHERE USER_CODE = :NEW.USER_CODE;
            
            
            IF(V_SCORE_NUM < 1800)    
            THEN    RAISE SCORE_NUM_ERROR;
            
            ELSE
                --○ 참여중인 스터디 갯수 확인
                SELECT COUNT(*) INTO V_STUDY_NUM
                FROM VIEW_STUDY_NOW;                
            
                IF(V_STUDY_NUM >2)
                THEN    RAISE STUDY_NUM_ERROR;

                END IF;
            END IF;
        END IF;
        
        
        -- 예외처리
        EXCEPTION
                WHEN SUSPEND_CHECK_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70021,'계정정지상태라 개설불가~!!!');
                WHEN STUDY_NUM_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70022,'4등급 이하라 개설불가~!!!');
                WHEN SCORE_NUM_ERROR 
                    THEN    RAISE_APPLICATION_ERROR(-70023,'진행중인 스터디가 2개이상이라 개설불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

----------------------------END----------------------------------------






















--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--○ 경고소멸 : 경고 인서트될 때 마지막 경고 날짜 체크해서 1년 지났으면 그 전 경고 소멸.
-- 프로시저로 변경해서 함
/*
CREATE OR REPLACE TRIGGER TRG_BIA
        BEFORE
        INSERT  ON TBL_WARNING
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
            
            -- 최근 경고날짜로부터 1년이 지났으면 그 전의 경고 삭제해주기
            IF (ADD_MONTHS(V_WARNING_DATE, 12) <= SYSDATE) -- 마지막 계정정지 경고 날짜 
            THEN 
               DELETE 
               FROM TBL_WARNING W
               WHERE W.USER_CODE = :NEW.USER_CODE AND W.WARNING_DATE > V_WARNING_DATE;
            END IF;
            
            ------------------------------------------------    
        
        -- 계정정지 이력이 존재하지 않으면 최근 경고날짜로부터 1년이 지났으면 그 전의 경고 삭제해주기
        ELSE
            -- 가장 최근 경고 날짜
            SELECT MAX(WARNING_DATE) INTO V_WARNING_DATE
            FROM TBL_WARNING
            WHERE USER_CODE = :NEW.USER_CODE;
            
            IF (ADD_MONTHS(V_WARNING_DATE, 12) <= SYSDATE)
            THEN 
               DELETE 
               FROM TBL_WARNING W
               WHERE W.USER_CODE = :NEW.USER_CODE AND W.WARNING_DATE <= V_WARNING_DATE;
            END IF;
        END IF;
        
    END IF;        
    
    /*
     -- 가장 최근 경고 날짜
    SELECT MAX(WARNING_DATE) INTO V_WARNING_DATE
    FROM TBL_WARNING
    WHERE USER_CODE = :NEW.USER_CODE;
    -- 최근경고날짜로부터 1년이 지났으면 그 전의 경고 삭제해주기
    IF (ADD_MONTHS(V_WARNING_DATE, 12) <= SYSDATE)
    THEN 
       DELETE 
       FROM TBL_WARNING W
       WHERE W.USER_CODE = :NEW.USER_CODE AND W.WARNING_DATE <= V_WARNING_DATE;
    END IF;  
    */
END;


*/