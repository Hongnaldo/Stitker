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
