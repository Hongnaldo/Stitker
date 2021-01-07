--■■■ 프로시저(PROCEDURE) 생성 ■■■--

CREATE OR REPLACE PROCEDURE 프로시저명(
-- 선언부

)
IS
BEGIN

END;

-- 시퀀스 조회
select * from user_sequences;

SET SERVEROUTPUT ON;
--=============================================== 여기서 부터 복붙해주세요~~


--○ 스터디 진행에 인스트됐을 때 -> 출석부 + 일정관리(리더 출석부코드만)에 미리 데이터 인서트
CREATE OR REPLACE PROCEDURE PRC_AC_INSERT(
 -- 선언부
 
)
IS



BEGIN



END;


--○ 스터디 시작날짜에 진행에 인서트 되지 않은 사람들 -> 취소 테이블에 인서트
-- 조건
-- 1. 현재 날짜가 스터디 시작 날짜이다.
-- 2. TBL_STUDY_APPLY에는 APPLY_CODE가 있는데 TBL_STUDY_PARTICIPANT에 APPLY_CODE가 없다.


CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
IS
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;     -- 스터디 시작일
    V_APPLY_CODE TBL_STUDY_APPLY.APPLY_CODE%TYPE;    -- 스터디 참가 코드
    V_CALCEL_DATE TBL_STUDY_CALCEL.CANCEL_DATE%TYPE; -- 취소 처리된 날짜
    V_CANCEL_CODE TBL_STUDY_CALCEL.CANCEL_CODE%TYPE; -- 스터디 취소 코드
    V_STUDY_CODE TBL_STUDY_OPEN.STUDY_CODE%TYPE;     -- 해당 스터디 코드
    V_TODAY DATE;                                    -- 오늘 날짜 

BEGIN

    SELECT START_DATE     -- 스터디 시작일
        INTO V_START_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = (SELECT STUDY_CODE FROM TBL_STUDY_APPLY);
    
    SELECT APPLY_CODE     -- 스터디 참가 코드
        INTO V_APPLY_CODE    
    FROM TBL_STUDY_APPLY
    WHERE STUDY_CODE = V_STUDY_CODE; 

    V_TODAY := CURRENT_DATE(); -- 오늘 날짜
    
    LOOP
    IF (V_START_DATE = V_TODAY) AND (SELECT COUNT(*)
                                  FROM TBL_STUDY_PARTICIPANT
                                  WHERE APPLY_CODE = V_APPLY_CODE)=0   
        THEN INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE,APPLY_CODE,CANCEL_DATE) 
             VALUES(SC||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
    END IF;  
        EXIT WHEN V_APPLY_CODE = MAX(V_APPLY_CODE);
    END LOOP;
END;


--○ 회원가입시 회원코드생성 + 회원등록 
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

/*-- TEST
SELECT *
FROM TAB;

SELECT COUNT(*)
FROM TBL_CURSE;

SELECT *
FROM TBL_CURSE;
*/

SELECT *
FROM USER_SEQUENCES;