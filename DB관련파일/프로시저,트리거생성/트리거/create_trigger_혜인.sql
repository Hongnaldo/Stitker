--■■■ 트리거(TRIGGER) 생성 ■■■--

CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명(장착 대상 테이블)
    [FOR EACH ROW [WHEN TRIGGER 조건]] --> 이 구문 붙어있으면 ROW, 없으면 STATEMENT 트리거.
    [DECLARE]
        -- 선언 구문;
    BEGIN
        -- 실행구문;
    END;    
DESC TBL_STUDY_APPLY;

-- 스터디 참가에 인서트 -> 리더 제외(+새로들어온사람도 제외)한 나머지 사람 신청날짜 null로 업데이트(함수/프로시저 호출)
CREATE OR REPLACE TRIGGER TRG_STD_APL_UPDATE
    BEFORE
    INSERT ON TBL_STUDY_APPLY
    FOR EACH ROW
DECLARE
BEGIN
    -- 실행구문;
    IF (INSERTING) 
        THEN PRC_UPDATE_DATE_NULL(:NEW.STUDY_CODE); 
    END IF;
  
END;


-- 경고 인서트 -> 점수 (현재등급-1)등급의 최저점수로 인서트

CREATE OR REPLACE TRIGGER TRG_WARN_GRADE
    AFTER
    INSERT ON TBL_WARNING
    FOR EACH ROW
    
DECLARE
    -- 선언 구문;
     V_SCORE NUMBER;  -- 점수 누적합 담을 변수
BEGIN
    -- 실행구문;
    SELECT SUM(SCORE) INTO V_SCORE
    FROM TBL_SCORE
    WHERE USER_CODE = :NEW.USER_CODE;
    
    IF V_SCORE >= 12600 THEN   
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE - 7800), SYSDATE);
    ELSIF V_SCORE >= 7800 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE - 4200), SYSDATE);
    ELSIF V_SCORE >= 4200 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE - 1800), SYSDATE);
    ELSIF V_SCORE >= 1800 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE - 600), SYSDATE);
    ELSIF V_SCORE >= 600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE), SYSDATE);

    END IF;

    
END;












                                                 
                                                 
