--■■■ 프로시저(PROCEDURE) 생성 ■■■--

CREATE OR REPLACE PROCEDURE 프로시저명(
-- 선언부

)
IS
BEGIN

END;


--○ 스터디 시작날짜에 진행테이블에 인서트 되지 않은 사람들 -> 취소 테이블에 인서트

-- 조건
-- 1. 현재 날짜 = 스터디 시작 날짜
-- 2. TBL_STUDY_APPLY에는 APPLY_CODE가 있는데 TBL_STUDY_PARTICIPANT 에 APPLY_CODE가 없다.

CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
IS
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;            -- 스터디 시작일
    V_PARTI_CODE TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE;     -- 스터디 진행코드 담을 변수
    V_APPLY_CODE TBL_STUDY_APPLY.APPLY_CODE%TYPE;           -- 스터디 진행 코드
    V_CANCEL_CODE TBL_STUDY_CANCEL.CANCEL_CODE%TYPE;        -- 스터디 취소 코드
    V_STUDY_CODE TBL_STUDY_OPEN.STUDY_CODE%TYPE;            -- 해당 스터디 코드
    V_TODAY DATE;                                           -- 오늘 날짜 
    V_I  NUMBER;                                            -- FOR 카운터
    V_MEMCNT NUMBER;                                        -- 스터디 참가신청 인원수  
    

BEGIN
    
  
    SELECT COUNT(*) INTO V_MEMCNT     -- 스터디 참가 신청한 총 인원 수
    FROM TBL_STUDY_APPLY
    WHERE STUDY_CODE = (SELECT STUDY_CODE FROM TBL_STUDY_OPEN);
    
    
    SELECT START_DATE     -- 스터디 시작일
        INTO V_START_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = (SELECT STUDY_CODE FROM TBL_STUDY_APPLY);
     
                     
    V_TODAY := CURRENT_DATE(); -- 오늘 날짜
    
    FOR V_I IN 1.. V_MEMCNT LOOP
        SELECT PPC , AAC INTO V_PARTI_CODE, V_APPLY_CODE
        FROM (SELECT ROWNUM, A.APPLY_CODE AAC, A.USER_CODE AUC,P.PARTI_CODE PPC   
              FROM TBL_STUDY_APPLY A, TBL_STUDY_PARTICIPANT P
              WHERE A.APPLY_CODE = P.APPLY_CODE(+) 
              AND P.APPLY_CODE IS NULL)   
        WHERE ROWNUM = V_I;
        
        IF V_PARTI_CODE IS NULL AND (V_START_DATE = V_TODAY)
            THEN INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
                        VALUES('CC'||STUDY_CANC_SEQ.NEXTVAL,V_APPLY_CODE,SYSDATE,1);
        END IF;
        
    END LOOP;
    
END;
--==>>Procedure PRC_SC_INSERT이(가) 컴파일되었습니다.




--○ 회원가입시 회원 코드 생성 + 회원 등록 
CREATE OR REPLACE PROCEDURE PRC_UC_REG_INSERT(                      -- 사용자한테 받아오는 값
  V_ID IN TBL_USER_REGISTER.ID%TYPE                                 -- ID
 ,V_PW IN TBL_USER_REGISTER.PW%TYPE                                 -- PW
 ,V_SSN IN TBL_USER_REGISTER.SSN%TYPE                               -- SSN    
 ,V_PW_SRCH_QUE_CODE IN TBL_USER_REGISTER.PW_SRCH_QUE_CODE%TYPE     -- 비밀번호 찾기 질문코드
 ,V_PW_SRCH_QUE_ANS IN TBL_USER_REGISTER.PW_SRCH_QUE_ANS%TYPE       -- 비밀번호 찾기 질문
 ,V_INTEREST_MC_CODE IN TBL_USER_REGISTER.INTEREST_MC_CODE%TYPE     -- 관심분야 중분류 코드
 ,V_LOC_MC_CODE IN TBL_USER_REGISTER.LOC_MC_CODE%TYPE               -- 지역 중분류 코드
 ,V_JOB_MC_CODE IN TBL_USER_REGISTER.JOB_MC_CODE%TYPE               -- 직업 중분류 코드
 ,V_EMAIL IN TBL_USER_REGISTER.EMAIL%TYPE                           -- 이메일
 ,V_NAME IN TBL_USER_REGISTER.NAME%TYPE                             -- 이름
 ,V_STUDY_TYPE_CODE IN TBL_USER_REGISTER.STUDY_TYPE_CODE%TYPE       -- 관심 스터디 유형
)
IS
    V_USER_CODE TBL_USER_CODE_CREATE.USER_CODE%TYPE;                -- 사용자 코드
    
BEGIN
    
    V_USER_CODE := 'UC'||USER_CODE_CRE_SEQ.NEXTVAL; 
    
    INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)                     -- 회원 코드 생성 테이블에 인서트
    VALUES(V_USER_CODE);
    
    INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN               -- 회원 등록 테이블에 인서트
    ,PW_SRCH_QUE_CODE, PW_SRCH_QUE_ANS,INTEREST_MC_CODE
    ,LOC_MC_CODE,JOB_MC_CODE,EMAIL,NAME, REGDATE, STUDY_TYPE_CODE)
    VALUES(V_USER_CODE, V_ID,V_PW,V_SSN
    ,V_PW_SRCH_QUE_CODE,V_PW_SRCH_QUE_ANS,V_INTEREST_MC_CODE
    ,V_LOC_MC_CODE, V_JOB_MC_CODE, V_EMAIL, V_NAME, SYSDATE, V_STUDY_TYPE_CODE);
    
    COMMIT;    -- 커밋
    
END;
--==>> Procedure PRC_UC_REG_INSERT이(가) 컴파일되었습니다.





--======================일정관리 인서트 프로시저 보류 ==========================

--○ 스터디 진행에 인스트됐을 때 -> 일정관리 테이블에 미리 데이터 인서트
-- 출석 버튼, 퇴실 버튼 따로.

/*

 
CREATE OR REPLACE PROCEDURE PRC_SP_INSERT
IS
    V_SCHEDUE_DATE TBL_STUDY_SCHEDULE.DATE%TYPE;
    V_PARTI_CODE TBL_STUDY_PARTICEPANT.PARTI_CODE%TYPE;  -- 스터디 진행 코드
    V_APPLY_CODE TBL_STUDY_PARTICIPANT.APPLY_CODE%TYPE;  -- 스터디 참자가 코드
    V_ATTEND_CODE TBL_STUDY_ATTEND.ATTEND_CODE%TYPE;     -- 출석부 코드
    CLOCK_IN TBL_STUDY_ATTEND.CLOCK_IN%TYPE;             -- 입실 시간
    CLOCK_OUT TBL_STUDY_ATTEND.CLOCK_OUT%TYPE;           -- 퇴실 시간
    SCHEDULE TBL_STUDY_SCHEDULE.SCHEDULE%TYPE;           -- 스터디 일정관리 
    V_STUDY_CODE TBL_STUDY_APPLY.STUDY_CODE%TYPE;        -- 스터디 코드
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;        -- 스터디 시작날짜
    V_END_DATE TBL_STUDY_OPEN.END_DATE%TYPE;             -- 스터디 종료날짜

BEGIN
    
    -- 해당 스터디의 날짜, 종료 구해오기 
     SELECT O.START_DATE , D.END_DATE INTO V_START_DATE , V_END_DATE
     FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
         ON A.PARTI_CODE = P.PARTI_CODE
            JOIN TBL_STUDY_APPLY AP 
            ON P.APPLY_CODE = AP.APPLY_CODE
                JOIN TBL_STUDY_OPEN O
                ON AP.STUDY_CODE = O.STUDY_CODE;
 
  
    SELECT STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = (SELECT APPLY_CODE
                        FROM TBL_STUDY_PARTICIPANT);
                        
    
    V_ATTEND_CODE
    
    -- 스터디 일정관리 테이블에 데이터 입력
    INSERT INTO TBL_STUDY_SCHEDULE(ATTEND_CODE, SCHEDULE)
    VALUES();
    
    -- 출석부 테이블에 데이터 입력
    FOR V_I 1..스터디총날짜
        INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE,CLOCK_IN,CLOCK_OUT)
        VALUES('SA'||STUDY_ATT_SEQ.NEXTVAL,리더코드,첫째날,NULL,NULL);
    END LOOP;
    
END;
*/

SELECT *
FROM TAB;

SELECT *
FROM USER_SEQUENCES;