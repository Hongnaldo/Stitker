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
    
    IF V_SCORE >= 14400 THEN   
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE - 8400), SYSDATE);
    ELSIF V_SCORE >= 8400 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE - 3600), SYSDATE);
    ELSIF V_SCORE >= 3600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE), SYSDATE);
    ELSIF V_SCORE >= 0 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE + 2400), SYSDATE);
    ELSIF V_SCORE >= -2400 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE + 3600), SYSDATE);
    ELSIF V_SCORE >= -3600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, -(V_SCORE + 4200), SYSDATE);

    END IF;

    
END;




-- 점수 인서트 -> 결과가 -4200 이하이면 -4200까지만 인서트 -> 계정정지에 인서트 
--                                       21600 초과면 21600까지만 인서트

CREATE OR REPLACE TRIGGER TRG_SCORE_INSERT
    BEFORE
    INSERT ON TBL_SCORE
    FOR EACH ROW
DECLARE
    -- 선언 구문;
     V_SCORE NUMBER; 
BEGIN
    -- 실행구문;
    SELECT SUM(SCORE) INTO V_SCORE
    FROM TBL_SCORE
    WHERE USER_CODE = :NEW.USER_CODE;
    
    IF V_SCORE + (V_SCORE + :NEW.SCORE - 21600) <= 21600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SS'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, (V_SCORE + :NEW.SCORE - 21600), SYSDATE);
    ELSIF V_SCORE + (V_SCORE + :NEW.SCORE - 21600) > 21600 THEN
        RAISE_APPLICATION_ERROR(-20001, '입력할 수 있는 최대 점수를 초과했습니다.');  
    ELSIF V_SCORE + :NEW.SCORE < -4200 THEN
        INSERT INTO TBL_ACCOUNT_SUSPEND(ACCT_SUS_CODE, ACCT_SUS_DATE, WARNING_CODE)
        VALUES('AS'||ACCT_SUS_SEQ.NEXTVAL, SYSDATE, 'SW'||STUDY_WARN_SEQ.NEXTVAL);

    END IF;
    
END;

--> 최소점수 미달로 계정 정지 당할 경우 경고 코드가 없음











                                                 
                                                 
