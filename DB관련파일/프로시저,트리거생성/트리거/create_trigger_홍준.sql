--○ 게시물 추천 인서트 -> 10개이상, 1000개 이하인지 체크 -> 1점 부여

--○ 해당게시글의 추천수 카운트
SELECT COUNT(*)
FROM TBL_REC_INFORM R, TBL_BOARD_INFORM B
WHERE R.POST_CODE = B.POST_CODE AND R.POST_CODE='1' AND R.REC_CHECK = 1
GROUP BY R.POST_CODE;

--○ 해당게시글의 사용자 아이디
SELECT B.USER_CODE
FROM TBL_REC_INFORM R, TBL_BOARD_INFORM B
WHERE R.POST_CODE = B.POST_CODE AND R.POST_CODE='1';

--○ 추천 수 10개당 1점 부여
CREATE OR REPLACE TRIGGER TRG_REC_CHK
    AFTER
    INSERT OR UPDATE ON TBL_REC_INFORM
    FOR EACH ROW
DECLARE
    NPOST_CODE  VARCHAR2(15);
    REC_COUNT VARCHAR2(5);
    REC_USER VARCHAR2(10);
BEGIN
    NPOST_CODE := :NEW.POST_CODE;
    
    SELECT COUNT(*) INTO REC_COUNT
    FROM TBL_REC_INFORM R, TBL_BOARD_INFORM B
    WHERE R.POST_CODE = B.POST_CODE AND R.POST_CODE= :NEW.POST_CODE AND R.REC_CHECK = 1
    GROUP BY R.POST_CODE;
    
    SELECT B.USER_CODE INTO REC_USER
    FROM TBL_REC_INFORM R, TBL_BOARD_INFORM B
    WHERE R.POST_CODE = B.POST_CODE AND R.POST_CODE= :NEW.POST_CODE;
    
    IF( TO_NUMBER(REC_COUNT) <= 1000)
    THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
        VALUES(STUDY_SCOR_SEQ.NEXTVAL,REC_USER,TRUNC(TO_NUMBER(REC_COUNT) / 10));
    END IF;
END;

DESC TBL_SCORE;


--○ 리더 제외한 스터디원 모두 신청날짜 null로 업데이트(함수/프로시저 호출)
CREATE OR REPLACE PROCEDURE PR_MEM_NULL
(OSTUDY_CODE   IN   TBL_STUDY_OPEN.STUDY_CODE%TYPE
)
IS
BEGIN
    UPDATE TBL_STUDY_APPLY
    SET APPLY_DATE = NULL
    WHERE STUDY_CODE= OSTUDY_CODE AND POSITION_CODE ='스터디원';
    
    EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;



--○ 매일체크: 스터디 종료날짜로부터 2주 후인지 체크 -> (스터디원평가등록에 데이터 있는 사람만 + 스터디원평가결과 점수가 음수인 사람) 에게 점수 적용. + 리더는 100점 추가적용
-- 스터디 총인원수
-- 평가를 총인원-1를 했느냐

CREATE OR REPLACE PROCEDURE PR_2WEEKS_CHK
(NSTUDY_CODE IN  TBL_STUDY_OPEN.STUDY_CODE%TYPE                 -- 현재 스터디 코드
,NDATE IN DATE                                                  -- 현재 시간의 코드
,NASSESS IN TBL_STUDY_INTERASSESS.PARTI_ASSESSED_CODE%TYPE      -- 평가 받을 사람의 코드
)
IS
FDATE DATE;
MEM_CNT VARCHAR2(2);
ASS_CNT VARCHAR2(2);
AVG_ASS VARCHAR2(3);
AUSER_CODE TBL_STUDY_APPLY.USER_CODE%TYPE;
APOSITION TBL_STUDY_POSITION.POSITION%TYPE;
BEGIN
    SELECT END_DATE INTO FDATE          --스터디 종료날짜 받아옴
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = NSTUDY_CODE;
    
    SELECT COUNT(*) INTO MEM_CNT        --스터디 총 인원 받아옴
    FROM TBL_STUDY_APPLY A, TBL_STUDY_OPEN O
    WHERE A.STUDY_CODE = O.STUDY_CODE AND O.STUDY_CODE = NSTUDY_CODE
    GROUP BY A.STUDY_CODE;
    
    SELECT COUNT(*)/3 INTO ASS_CNT        --내가 평가한 인원 받아옴
    FROM TBL_STUDY_INTERASSESS
    WHERE PARTI_ASSESS_CODE = NASSESS
    GROUP BY PARTI_ASSESS_CODE;
    
    SELECT AVG(R.SCORE) INTO AVG_ASS        --평가를 받는 사람의 평균점수
    FROM TBL_STUDY_ASSESS_RESP R, TBL_STUDY_INTERASSESS I
    WHERE R.RESP_CODE = I.RESP_CODE AND I.PARTI_ASSESSED_CODE = NASSESS
    GROUP BY(I.PARTI_ASSESSED_CODE);
    
    SELECT A.USER_CODE INTO AUSER_CODE        -- 점수를 획득할 사람의 유저코드를 받아옴
    FROM TBL_STUDY_INTERASSESS I, TBL_STUDY_PARTICIPANT P, TBL_STUDY_APPLY A
    WHERE A.APPLY_CODE = P.APPLY_CODE AND P.PARTI_CODE = I.PARTI_ASSESSED_CODE AND I.PARTI_ASSESSED_CODE = NASSESS;
    
    SELECT P.POSITION INTO APOSITION        -- 점수를 획득할 사람의 역할(직위)를 받아옴
    FROM TBL_STUDY_POSITION P, TBL_STUDY_APPLY A, TBL_STUDY_PARTICIPANT S, TBL_STUDY_INTERASSESS I
    WHERE P.POSITION_CODE = A.POSITION_CODE AND A.APPLY_CODE = S.APPLY_CODE AND S.PARTI_CODE = I.PARTI_ASSESSED_CODE AND I.PARTI_ASSESSED_CODE = NASSESS;
    
    
    IF(NDATE > FDATE+14)        -- 2주가 지났을때
    THEN
        IF(APOSITION = '스터디리더')                     --스터디리더일경우 100점 추가(평가를 하든 하지않든 상관없음)
        THEN
            INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
            VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, 100);
        END IF;
        IF(TO_NUMBER(MEM_CNT) = TO_NUMBER(ASS_CNT)+1)   -- 나를 제외한 모든 스터디원평가를 완료하였을때
        THEN
            IF(TO_NUMBER(AVG_ASS)>=90)
            THEN
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, 100);
            ELSIF(TO_NUMBER(AVG_ASS)>=80)
            THEN
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, 50);
            ELSIF(TO_NUMBER(AVG_ASS)>=70)
            THEN
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, 0);
            ELSIF(TO_NUMBER(AVG_ASS)>=60)
            THEN
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, -50);
            ELSE
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, -100);
            END IF;
        ELSE                                                        -- 평가를 하진않았지만 내점수가 음수
            IF(TO_NUMBER(AVG_ASS)<60)
            THEN
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, -100);
            ELSIF(TO_NUMBER(AVG_ASS)<70)
            THEN
                INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE)
                VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER_CODE, -50);
            END IF;
        END IF;
    
    END IF;
    
    EXCEPTION
    WHEN OTHERS THEN ROLLBACK;    
    
END;





--○ 매일체크: 계정정지 1년 후 점수 +300점으로 업데이트
CREATE OR REPLACE PROCEDURE PR_YEAR_CHK
( NDATE DATE
)
IS

BEGIN
    
END;

DECLARE
    C_ACCT_SUS_DATE  TBL_ACCOUNT_SUSPEND.ACCT_SUS_DATE%TYPE;
    AUSER   TBL_WARNING.USER_CODE%TYPE;
    TOT_SCORE TBL_SCORE.SCORE%TYPE;
    
    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의)
    CURSOR CUR_YEAR_CHK
    IS
    SELECT S.ACCT_SUS_DATE, W.USER_CODE
    FROM TBL_ACCOUNT_SUSPEND S, TBL_WARNING W
    WHERE S.WARNING_CODE = W.WARNING_CODE;
    
BEGIN
    -- 커서 오픈
    OPEN CUR_YEAR_CHK;
    
    -- 커서 오픈 시 쏟아져나오는 데이터들 처리(잡아내기)
    LOOP
        -- 한 행 한 행 받아다가 처리하는 행위 → 『FETCH』
        FETCH CUR_YEAR_CHK INTO C_ACCT_SUS_DATE, AUSER;
        
        SELECT SUM(SCORE) INTO TOT_SCORE
        FROM TBL_SCORE
        WHERE USER_CODE = AUSER
        GROUP BY USER_CODE;
        
        -- 커서에서 더이상 데이터가 쏟아져 나오지 않는 상태...NOTFOUND
        EXIT WHEN CUR_YEAR_CHK%NOTFOUND;
        
        IF(SYSDATE < C_ACCT_SUS_DATE)
        THEN
            INSERT INTO TBL_SCORE(SCORE_CODE,USER_CODE,SCORE)
            VALUES(STUDY_SCOR_SEQ.NEXTVAL, AUSER, -TOT_SCORE+300);     --원래 점수를 빼고난뒤 300점을 더하면 300점이된다.
        END IF;
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_YEAR_CHK;
END;















