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

-- 스터디 참가에 인서트 -> 리더 제외(+새로들어온사람도 제외)한 나머지 사람 신청날짜 null로 업데이트(함수/프로시저 호출)



-- 경고 인서트 -> 점수 (현재등급-1)등급의 최저점수로 업데이트

CREATE OR REPLACE TRIGGER TRG_WARN_GRADE
    AFTER
    INSERT ON TBL_WARNING
    FOR EACH ROW
    
DECLARE
    -- 선언 구문;
     V_SCORE NUMBER; 
BEGIN
    -- 실행구문;
    SELECT SUM(SCORE) INTO V_SCORE
    FROM TBL_SCORE
    WHERE USER_CODE = :OLD.USER_CODE;
    
    IF V_SCORE >= 14400 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES(STUDY_SCOR_SEQ.NEXTVAL, :OLD.USER_CODE, -(V_SCORE - 8400), SYSDATE);
    ELSE IF V_SCORE >= 8400 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES(STUDY_SCOR_SEQ.NEXTVAL, :OLD.USER_CODE, -(V_SCORE - 3600), SYSDATE);
    ELSE IF V_SCORE >= 3600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES(STUDY_SCOR_SEQ.NEXTVAL, :OLD.USER_CODE, -(V_SCORE), SYSDATE);
    ELSE IF V_SCORE >= 0 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES(STUDY_SCOR_SEQ.NEXTVAL, :OLD.USER_CODE, -(V_SCORE + 2400), SYSDATE);
    ELSE IF V_SCORE >= -2400 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES(STUDY_SCOR_SEQ.NEXTVAL, :OLD.USER_CODE, -(V_SCORE + 3600), SYSDATE);
    ELSE IF V_SCORE >= -3600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES(STUDY_SCOR_SEQ.NEXTVAL, :OLD.USER_CODE, -(V_SCORE + 4200), SYSDATE);
    END IF;
    END IF;
    END IF;
    END IF;
    END IF;
    END IF;
    
    
END;




-- 점수 인서트 -> 결과가 -4200 이하이면 -4200까지만 인서트 -> 계정정지에 인서트 
--                                       1600 초과면 21600까지만 인서트












                                                 
                                                 
