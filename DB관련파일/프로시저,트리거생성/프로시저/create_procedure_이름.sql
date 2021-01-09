--■■■ 프로시저(PROCEDURE) 생성 ■■■--

-- 환경이 바뀌었을 때, 리더를 제외한 모든 스터디원의 참여날짜 NULL로 업데이트
CREATE OR REPLACE PROCEDURE PRC_UPDATE_DATE_NULL
(   -- 스터디코드 받아오기
    V_STUDY_CODE IN TBL_STUDY_OPEN.STUDY_CODE%TYPE
)
IS
BEGIN
    -- 스터디코드가 받아온 코드와 같으면서, 직책이 2(스터디원)인 모든 데이터 
    -- 참여날짜 NULL로 업데이트하기
    UPDATE TBL_STUDY_APPLY
    SET APPLY_DATE = NULL
    WHERE STUDY_CODE = V_STUDY_CODE AND POSITION_CODE = 2;
    
    -- 예외발생시 롤백
    EXCEPTION
    WHEN OTHERS THEN ROLLBACK; 
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_UPDATE_DATE_NULL이(가) 컴파일되었습니다.


--탈퇴 한 달 후 주번 지우기 프로시저
CREATE OR REPLACE PROCEDURE PRC_DELETE_SSN
(
    -- 탈퇴코드 받아오기
    V_WDL_CODE  IN TBL_WITHDRAWAL_INFO.SSN%TYPE
)
IS
    V_WDL_DATE  DATE;
BEGIN

    -- 탈퇴날짜 가져오기
    SELECT WDL_DATE INTO V_WDL_DATE
    FROM TBL_WITHDRAWAL_INFO
    WHERE WDL_CODE = V_WDL_CODE;
    
     -- 한달이 지났으면 주번 지우기
    IF(ADD_MONTHS(V_WDL_DATE, 1) <= SYSDATE)
    THEN
        UPDATE TBL_WITHDRAWAL_INFO
        SET SSN = NULL
        WHERE WDL_CODE = V_WDL_CODE;
    END IF;  
END;
