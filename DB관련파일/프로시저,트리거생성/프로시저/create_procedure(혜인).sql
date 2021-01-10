--■■■ 프로시저(PROCEDURE) 생성 ■■■--


DESC TBL_STUDY_OPEN;
DESC TBL_STUDY_MEETDAY;


    --스터디개설/진행요일 인서트 프로시저 
/*---------------------------------------------------------------
 각각 인서트 프로시저를 만들려고 했는데, 그렇게 하니까 진행요일
 인서트 할 때 스터디개설의 스터디 코드를 받아올 방법을 모르겠음..
 그래서 실행부에서 V_STUDY_CODE에 시퀀스를 사용해 스터디 코드를
 담고, 그 V_STUDY_CODE를 스터디개설과 진행요일에 각각 인서트 시킴
 
 이렇게 해야 할 것 같아서 해 봤는데.. 한번 검토해 보고 수정해야
 할 사항 있으면 알려 주세요!
 
 -----------수정사항----------------------------------------------
 - 스터디 오픈에 인서트되는 프로시저1
 - 밋데이에 인서트되는 프로시저2(스터디코드 매개변수로 받아서 처리)
 ※ 트리거에 점수 기준 바뀐 것으로 수정하기.
---------------------------------------------------------------*/

-- 스터디 오픈 테이블에 인서트
CREATE OR REPLACE PROCEDURE STD_OPEN_INSERT
( V_STUDY_NAME              IN TBL_STUDY_OPEN.STUDY_NAME%TYPE       -- 스터디 이름
, V_STUDY_DESC              IN TBL_STUDY_OPEN.STUDY_DESC%TYPE       -- 스터디 목적
, V_INTEREST_MC_CODE        IN TBL_STUDY_OPEN.INTEREST_MC_CODE%TYPE -- 스터디 카테고리
, V_STUDY_TYPE_CODE         IN TBL_STUDY_OPEN.STUDY_TYPE_CODE%TYPE  -- 스터디 유형
, V_START_DATE              IN TBL_STUDY_OPEN.START_DATE%TYPE       -- 스터디 시작 날짜
, V_END_DATE                IN TBL_STUDY_OPEN.END_DATE%TYPE         -- 스터디 종료 날짜
, V_LOC_MC_CODE             IN TBL_STUDY_OPEN.LOC_MC_CODE%TYPE      -- 지역
, V_MIN_MEM_CODE            IN TBL_STUDY_OPEN.MIN_MEM_CODE%TYPE     -- 최소 인원
, V_MAX_MEM_CODE            IN TBL_STUDY_OPEN.MAX_MEM_CODE%TYPE     -- 최대 인원
, V_MIN_RANK                IN TBL_STUDY_OPEN.MIN_RANK%TYPE         -- 참여최소등급
, V_USER_CODE               IN TBL_USER_REGISTER.USER_CODE%TYPE     -- 사용자 코드
)
IS
    --변수 선언
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;    
    V_CLOSE_DATE    TBL_STUDY_OPEN.CLOSE_DATE%TYPE;
    V_WRITE_DATE    TBL_STUDY_OPEN.WRITE_DATE%TYPE := SYSDATE;
    V_HITCOUNT      TBL_STUDY_OPEN.HITCOUNT%TYPE := 0;

    
BEGIN

    -- 모집 마감일은 스터디 시작 날짜 이틀 전
    V_CLOSE_DATE := TRUNC(V_START_DATE - 2, 'DD');

    
    
    INSERT INTO TBL_STUDY_OPEN(STUDY_CODE, USER_CODE, WRITE_DATE, HITCOUNT, STUDY_TYPE_CODE
                             , INTEREST_MC_CODE, START_DATE, END_DATE, MIN_MEM_CODE, MAX_MEM_CODE
                             , STUDY_NAME, MIN_RANK, CLOSE_DATE, STUDY_DESC, LOC_MC_CODE)
    VALUES('SO'||STD_OPEN_SEQ.NEXTVAL, V_USER_CODE, V_WRITE_DATE, V_HITCOUNT, V_STUDY_TYPE_CODE, V_INTEREST_MC_CODE
         , V_START_DATE, V_END_DATE, V_MIN_MEM_CODE, V_MAX_MEM_CODE, V_STUDY_NAME, V_MIN_RANK
         , V_CLOSE_DATE, V_STUDY_DESC, V_LOC_MC_CODE);

    --커밋
    COMMIT;
    
        
END;



-- 진행요일에 인서트
CREATE OR REPLACE PROCEDURE STD_MEETDAY_INSERT
( V_STUDY_CODE              IN TBL_STUDY_OPEN.STUDY_CODE%TYPE       -- 스터디 개설의 스터디 코드
, V_WEEKDAY_CODE            IN TBL_STUDY_MEETDAY.WEEKDAY_CODE%TYPE  -- 요일 코드
, V_START_TIME              IN TBL_STUDY_MEETDAY.START_TIME%TYPE    -- 시작 시간
, V_END_TIME                IN TBL_STUDY_MEETDAY.END_TIME%TYPE      -- 종료 시간
)
IS
    --변수 선언
    V_MEETDAY_CODE  TBL_STUDY_MEETDAY.MEETDAY_CODE%TYPE;


    
BEGIN

      
    INSERT INTO TBL_STUDY_MEETDAY(MEETDAY_CODE, WEEKDAY_CODE, STUDY_CODE, START_TIME, END_TIME)
    VALUES('MD'||STD_MEETDAY_SEQ.NEXTVAL, V_WEEKDAY_CODE, V_STUDY_CODE, V_START_TIME, V_END_TIME);

    --커밋
    COMMIT;
    
        
END;


-- 점수 인서트 -> 결과가 0 이하이면 0까지만 인서트 -> 계정정지에 인서트 
--                                       18600 초과면 18600까지만 인서트
-- 테스트 완료

CREATE OR REPLACE PROCEDURE STD_SCORE_INSERT
( V_USER_CODE   IN TBL_USER_REGISTER.USER_CODE%TYPE     -- 사용자 코드
, V_SCORE       IN TBL_SCORE.SCORE%TYPE                 -- 점수
)
IS
     V_SCORE_CODE   TBL_SCORE.SCORE_CODE%TYPE;
     V_SCORE_DATE   TBL_SCORE.SCORE_DATE%TYPE := SYSDATE;
     V_SUM_SCORE    NUMBER;
       
     
BEGIN

    SELECT SUM(SCORE) INTO V_SUM_SCORE
    FROM TBL_SCORE
    WHERE USER_CODE = V_USER_CODE;
   
    IF V_SUM_SCORE + V_SCORE <= 0 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, -(V_SUM_SCORE), SYSDATE);
        PRG_INSERT_WARNING(V_USER_CODE, SYSDATE);
    ELSIF V_SUM_SCORE + V_SCORE  <= 18600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, V_SCORE, SYSDATE);
    ELSIF V_SUM_SCORE IS NULL THEN 
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, V_SCORE, SYSDATE);
    ELSIF V_SUM_SCORE + V_SCORE - 18600 > 0 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, V_SCORE - (V_SUM_SCORE + V_SCORE - 18600), SYSDATE);
    ELSIF V_SUM_SCORE = 18600 THEN
        RAISE_APPLICATION_ERROR(-20001, '입력할 수 있는 최대 점수를 초과했습니다.');  

    END IF;
  
END;

SELECT *
FROM TBL_WARNING;

