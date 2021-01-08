--■■■ 트리거(TRIGGER) 생성 ■■■--

--○ 스터디 진행 테이블 INSERT -> 모집마감일 이전에 INSERT됐는지 체크
-- -> 맞으면 스터디개설 테이블의 모집마감일을 UPDATE

CREATE OR REPLACE TRIGGER TRG_STD_PARTI_INSERT
    AFTER
    INSERT ON TBL_STUDY_PARTICIPANT
DECLARE
    V_STUDY_CODE TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_CLOSE_DATE TBL_STUDY_OPEN.CLOSE_DATE%TYPE;
BEGIN
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_PARTICIPANT P, TBL_STUDY_APPLY A
    WHERE P.APPLY_CODE = A.APPLY_CODE
      AND A.POSITION_CODE = 1;
      
    SELECT CLOSE_DATE INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    IF ( SYSDATE < V_CLOSE_DATE )
        THEN UPDATE TBL_STUDY_OPEN
             SET CLOSE_DATE = SYSDATE
             WHERE STUDY_CODE = V_STUDY_CODE;
             
    END IF;
END;

--==>> Trigger TRG_STD_PARTI_INSERT이(가) 컴파일되었습니다.



--○ 스터디 개설 테이블에 INSERT 수행 전 -> MAX_MEM이 MIN_MEM 이상인지 체크 -> MIN_MEM보다 작으면 에러 발생시킴(미완)
CREATE OR REPLACE TRIGGER TRG_STD_OPEN_INSERT
    BEFORE
    INSERT ON TBL_STUDY_OPEN
    FOR EACH ROW
DECLARE
    V_MIN_MEM TBL_MEMNUM.MEMNUM%TYPE;
    V_MAX_MEM TBL_MEMNUM.MEMNUM%TYPE;    
BEGIN 
    SELECT M.MEMNUM AS MIN_MEM INTO V_MIN_MEM
    FROM TBL_STUDY_OPEN O, TBL_MEMNUM M
    WHERE STUDY_CODE = INSERT될 스터디코드
      AND O.MIN_MEM_CODE = M.MEMNUM_CODE;
      
    SELECT M.MEMNUM AS MAX_MEM INTO V_MAX_MEM
    FROM TBL_STUDY_OPEN O, TBL_MEMNUM M
    WHERE STUDY_CODE = INSERT될 스터디코드 -- :NEW.STUDY_CODE 안됨.
      AND O.MAX_MEM_CODE = M.MEMNUM_CODE;  
      
    IF ( V_MAX_MEM < V_MIN_MEM )
        THEN RAISE_APPLICATION_ERROR(-20003, '최대 인원수는 최소 인원수 이상이어야 합니다.');
    END IF;
END;



























--○ 정보공유게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_INFOM_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_INFORM
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_INFORM
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0) -- 그냥 V_REG_CNT = 0 라고만??
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_INFORM (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); -- 처리결과는 '처리전'같은 의미로 넣어야할거같음
    END IF;
END;


--○ 면접,코딩테스트 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_INTEV_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_INTERVIEW
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_INTERVIEW
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_INTERVIEW (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;


--○ 공모전/세미나 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_SEMIN_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_SEMINAR
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_SEMINAR
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_SEMINAR (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;


--○ 자유 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_FREE_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_FREE
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_FREE
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_FREE (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;


--○ 답변 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_QUE_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_QUESTION
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_QUESTION
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_QUESTIONE (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;


--○ 질문 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_ANS_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_ANSWER
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_ANSWER
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_ANSWER (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;


--○ 스터디 후기 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_RPT_REG_STDREV_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_STUDYREVIEW
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_STUDYREVIEW
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_STUDYREVIEW (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;


--○ 스터디 개설 게시판 신고 등록 테이블에 INSERT 후 -> 5회 쌓였는지 체크 -> 맞으면 신고처리에 인서트
CREATE OR REPLACE TRIGGER TRG_STD_ACCU_INSERT
    AFTER
    INSERT ON TBL_STUDY_ACCUSE
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- 특정 게시물의 신고를 세는 변수 
BEGIN
    -- V_REG_CNT 초기화
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_STUDY_ACCUSE
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- 신고가 5회 쌓였는지(5의 배수) 체크후 처리
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_STUDY_ACCUSE_HANDLE (신고처리코드, 신고등록코드, 처리결과) 
                    VALUES (신고처리코드SEQ, 신고등록코드, 처리결과); 
    END IF;
END;