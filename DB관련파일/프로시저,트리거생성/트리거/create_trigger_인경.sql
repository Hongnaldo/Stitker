--■■■ 트리거(TRIGGER) 생성 ■■■--

CREATE[OR REPLACE] TRIGGER 트리거명
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명(장착 대상 테이블)
    [FOR EACH ROW [WHEN TRIGGER 조건]] --> 이 구문 붙어있으면 ROW, 없으면 STATEMENT 트리거.
    [DECLARE]
        -- 선언 구문;
    BEGIN
        -- 실행구문;
    END;    
    
    
--스터디 수정 BEFORE 트리거 : 신고가 1개라도 있으면 못함, 마감일 지난 스터디면 수정 못함.
CREATE OR REPLACE TRIGGER TRG_STUDY_OPEN
    BEFORE
    UPDATE ON TBL_STUDY_OPEN 
    FOR EACH ROW 
DECLARE
 V_CLOSE_DATE TBL_STUDY_OPEN.CLOSE_DATE%TYPE;  -- 마감일 
 V_REG_NUM    NUMBER;                          -- 신고수
 V_ERROR_MSG  VARCHAR2(50);                    -- 에러MSG
BEGIN
    
    SELECT COUNT(*) INTO V_REG_NUM         -- 스터디 신고수 
    FROM TBL_STUDY_ACCUSE
    WHERE STUDY_CODE = :NEW.STUDY_CODE;
    
    SELECT CLOSE_DATE INTO V_CLOSE_DATE                     -- 스터디 마감일
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = :NEW.STUDY_CODE;

    IF V_REG_NUM >1
        THEN DBMS_OUTPUT.PUT_LINE('신고된 게시글은 수정할 수 없습니다.');
    ELSIF SYSDATE > V_CLOSE_DATE 
          THEN DBMS_OUTPUT.PUT_LINE('마감일이 지난 게시글은 수정할 수 없습니다.');
   /*        
    ELSE 
         UPDATE TBL_STUDY_OPEN
         SET STUDY_TYPE_CODE = :NEW.STUDY_TYPE_CODE , INTEREST_MC_CODE = :NEW.INTEREST_MC_CODE
            ,END_DATE = :NEW.END_DATE , MAX_MEM_CODE = :NEW.MAX_MEM_CODE , STUDY_NAME = :NEW.STUDY_NAME
            ,STUDY_DESC = :NEW.STUDY_DESC, LOC_MC_CODE = :NEW.LOC_MC_CODE
         WHERE STUDY_CODE = :NEW.STUDY_CODE;
    */ 
    ELSE 
        DBMS_OUTPUT.PUT_LINE('수정 가능');
    END IF;  
    
END;    


--DESC TBL_STUDY_ACCUSE;
--==>>Trigger TRG_STUDY_OPEN이(가) 컴파일되었습니다.


UPDATE TBL_STUDY_OPEN
SET STUDY_NAME ='고구마 팔아요'
WHERE STUDY_CODE = 'SO9';


SELECT *
FROM TBL_STUDY_OPEN;

SELECT COUNT(*) AS COUNT
FROM TBL_STUDY_ACCUSE
WHERE STUDY_CODE = 'SO27';


