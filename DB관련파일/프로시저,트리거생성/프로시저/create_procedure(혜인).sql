--■■■ 프로시저(PROCEDURE) 생성 ■■■--


DESC TBL_STUDY_OPEN;
DESC TBL_STUDY_MEETDAY;


--레코드가 진행요일 갯수만큼
--진행요일에 인서트는 트리거

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
CREATE OR REPLACE PROCEDURE STD_MEETDAY_INSERT
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
, V_WEEKDAY_CODE            IN TBL_STUDY_MEETDAY.WEEKDAY_CODE%TYPE  -- 요일 코드
, V_START_TIME              IN TBL_STUDY_MEETDAY.START_TIME%TYPE    -- 시작 시간
, V_END_TIME                IN TBL_STUDY_MEETDAY.END_TIME%TYPE      -- 종료 시간
)
IS
    --변수 선언
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;    
    V_USER_CODE     TBL_STUDY_OPEN.USER_CODE%TYPE;
    V_HITCOUNT      TBL_STUDY_OPEN.HITCOUNT%TYPE;
    V_CLOSE_DATE    TBL_STUDY_OPEN.CLOSE_DATE%TYPE;
    V_MEETDAY_CODE  TBL_STUDY_MEETDAY.MEETDAY_CODE%TYPE;

    
BEGIN

    V_STUDY_CODE := 'SC'||STD_OPEN_SEQ.NEXTVAL;
    
    SELECT USER_CODE INTO V_USER_CODE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    SELECT (START_DATE - 2) INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;

    
    INSERT INTO TBL_STUDY_OPEN(STUDY_CODE, USER_CODE, WRITE_DATE, HITCOUNT, STUDY_TYPE_CODE
                             , INTEREST_MC_CODE, START_DATE, END_DATE, MIN_MEM_CODE, MAX_MEM_CODE
                             , STUDY_NAME, MIN_RANK, CLOSE_DATE, STUDY_DESC, LOC_MC_CODE)
    VALUES(V_STUDY_CODE, V_USER_CODE, SYSDATE, DEFAULT, V_STUDY_TYPE_CODE, V_INTEREST_MC_CODE
         , V_START_DATE, V_END_DATE, V_MIN_MEM_CODE, V_MAX_MEM_CODE, V_STUDY_NAME, V_MIN_RANK
         , V_CLOSE_DATE, V_STUDY_DESC, V_LOC_MC_CODE);
         
    INSERT INTO TBL_STUDY_MEETDAY(MEETDAY_CODE, WEEKDAY_CODE, STUDY_CODE, START_TIME, END_TIME)
    VALUES('SM'||STD_MEETDAY_SEQ.NEXTVAL, V_WEEKDAY_CODE, V_STUDY_CODE, V_START_TIME, V_END_TIME);

    --커밋
    COMMIT;
    
        
END;





