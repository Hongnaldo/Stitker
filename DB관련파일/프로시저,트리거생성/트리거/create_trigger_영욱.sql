

-- 시퀀스 앞에 영어 두 글자 수정하기

--○ it, 기술정보 공유 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_INFORM
        FOR EACH ROW    
BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----


--○ 면접,코딩테스트 후기 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_INTERVIEW
        FOR EACH ROW
BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----


--○ 세미나,공모전 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_SEMINAR
        FOR EACH ROW

BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;



--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----


--○ 스터디 후기 게시판 글 작성 점수 추가TRIGGER(트리거) 생성
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_STUDYREVIEW
        FOR EACH ROW
BEGIN
    
    -- 게시물을 등록한 사용자 점수 추가
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 10, SYSDATE);

   -- COMMIT;
   -- ※ TRIGGER 내에서는 COMMT/ ROLLBACK 구문 사용 불가~!!!
END;


-- 2021-01-13 스터디 개설 비포 트리거
CREATE OR REPLACE TRIGGER TRG_BEFORE_INSERT_STUDY_OPEN
BEFORE 
INSERT ON TBL_STUDY_OPEN
FOR EACH ROW
DECLARE  
V_SUSPEND_CHECK NUMBER;
V_STUDY_NUM      NUMBER;
V_SCORE_NUM      NUMBER;

-- 예외 처리 변수 선언
SUSPEND_CHECK_ERROR   EXCEPTION;
STUDY_NUM_ERROR         EXCEPTION;
SCORE_NUM_ERROR         EXCEPTION;
        
BEGIN
        
        --○ 계정정지 확인
        SELECT COUNT(*) INTO V_SUSPEND_CHECK
        FROM  ACCOUNT_SUSPEND_VIEW 
        WHERE ID = :NEW.USER_CODE;
        
        IF(V_SUSPEND_CHECK = 1 )
        THEN    RAISE SUSPEND_CHECK_ERROR;
        
        ELSE
            --○ 등급 확인
            SELECT SUM(SCORE) INTO V_SCORE_NUM
            FROM TBL_SCORE
            WHERE USER_CODE = :NEW.USER_CODE;
            
            IF(V_SCORE_NUM < 1800)    
            THEN    RAISE STUDY_NUM_ERROR;
            
            ELSE
                --○ 참여중인 스터디 갯수 확인
                SELECT COUNT(*) INTO V_STUDY_NUM
                FROM MY_NOW_STUDY_VIEW;                
            
                IF(V_STUDY_NUM >2)
                THEN    RAISE SCORE_NUM_ERROR;

                END IF;
            END IF;
        END IF;
        
        -- 커밋
        COMMIT;
        
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

---------------------------------------------------------------------------------------------------------------------------------------

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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,'신고 접수된 상태라 수정불가~!!!');
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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' 신고 접수된 상태라 수정불가~!!!');
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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' 신고 접수된 상태라 수정불가~!!!');
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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' 신고 접수된 상태라 수정불가~!!!');
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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' 신고 접수된 상태라 수정불가~!!!');
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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' 신고 접수된 상태라 수정불가~!!!');
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
        
        -- 커밋
        COMMIT;
        
        -- 예외처리
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' 신고 접수된 상태라 수정불가~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

----------------------------END----------------------------------------






















--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--○ 경고소멸 : 경고 인서트될 때 마지막 경고 날짜 체크해서 1년 지났으면 그 전 경고 소멸.
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


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--○ 내보내기 등록할때 체크해서 50% 넘었으면 내보내기처리 인서트+취소처리에 인서트
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_MEM_KICK_REG
        FOR EACH ROW
    
DECLARE
        -- 스터디 참가자 수 담을 변수 
        V_APPLY_NUM   NUMBER;
        -- 내보내기 누른 수 담을 변수
        V_KICK_NUM      NUMBER;
        -- 스터디 참가자 코드를 담을 변수
        V_APPLY_CODE   TBL_STUDY_PARTICIPANT.APPLY_CODE%TYPE;
        
BEGIN
     -- 스터디 참가자 수 확인
     SELECT COUNT(*) INTO V_APPLY_NUM
     FROM TBL_STUDY_PARTICIPANT
     WHERE PARTI_CODE = :NEW.PARTI_KICKED_CODE;
     
     -- 내보내기 누른 수 확인
     SELECT COUNT(*) INTO V_KICK_NUM
     FROM TBL_MEM_KICK_REG
     WHERE MEM_KICK_REG_CODE = :NEW.MEM_KICK_REG_CODE;
     
     -- 스터디 참가자 코드 확인
     SELECT APPLY_CODE INTO V_APPLY_CODE
     FROM TBL_STUDY_PARTICIPANT
     WHERE APPLY_CODE = :NEW.APPLY_CODE;
     
     -- 내보내기 누른 수가 50% 이상인 경우 내보내기 처리 및 스터디 취소 처리 
     IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- 내보내기 처리
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('??'||MEM_KH_SEQ.NEXTVAL, :NEW.MEM_KICK_REG_CODE, SYSDATE);
        
        -- 스터디 취소 처리
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('??'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
    END IF;
END;
