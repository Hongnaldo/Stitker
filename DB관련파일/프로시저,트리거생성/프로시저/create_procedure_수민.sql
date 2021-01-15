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

DROP PROCEDURE PRG_INSERT_WARNING;

-- 경고 받을 때 경고 소멸, 경고 인서트, 경고 수 세서 3개 이상이면 계정정지 / 유효기간 늘리기
CREATE OR REPLACE PROCEDURE PRC_INSERT_WARNING
( V_USER_CODE   IN TBL_USER_CODE_CREATE.USER_CODE%TYPE
, V_WARNING_DATE    IN TBL_WARNING.WARNING_DATE%TYPE
)
IS
    -- 총 경고 개수 
    V_WARNING_COUNT_TOT   NUMBER;
    -- 유효한 경고 개수
    V_WARNING_COUNT       NUMBER;
    -- 경고 코드
    V_WARNING_CODE      VARCHAR2(15);
    -- 가장 최근 계정정지 받은 경고 코드
    V_WARNING_CODE_RECENT    VARCHAR2(15);
    -- 가장 최근 계정정지 받은 경고 날짜
    V_WARNING_DATE_RECENT    DATE;
    -- 계정정지 개수
    V_SUSPEND_COUNT   NUMBER;
    -- 가장 최근 계정정지 코드
    V_SUSPEND_CODE    VARCHAR2(10);
    -- 가장 최근 계정정지 날짜
    V_SUSPEND_DATE    DATE;
    
BEGIN 

    -- 계정정지 개수 세기
    SELECT COUNT(계정정지코드) 계정정지개수 INTO V_SUSPEND_COUNT
    FROM WARNING_SUSPEND_VIEW
    WHERE 사용자=V_USER_CODE;  
    
    --있으면
    IF (V_SUSPEND_COUNT > 0)
    THEN
        -- 이어진 경고코드, 경고날짜 가져오기
        SELECT 경고코드, 경고날짜, 계정정지코드, 계정정지날짜
          INTO V_WARNING_CODE_RECENT, V_WARNING_DATE_RECENT, V_SUSPEND_CODE, V_SUSPEND_DATE
        FROM WARNING_SUSPEND_VIEW
        WHERE 사용자=V_USER_CODE AND 계정정지코드 IS NOT NULL;
            
        -- ▶그 이어진경고날짜로부터 1년이 지났으면 경고 모두 지우기
        IF( TRUNC(ADD_MONTHS(V_WARNING_DATE_RECENT, 12), 'DD') <= TRUNC(V_WARNING_DATE, 'DD') )
        THEN
            DELETE
            FROM TBL_WARNING
            WHERE USER_CODE = V_USER_CODE AND WARNING_DATE > V_WARNING_DATE_RECENT;
        END IF;    
        
    --▶없으면 가장최근 경고날짜 가져와서 1년 지났으면 몽땅 지우기
    ELSE
        SELECT MAX(WARNING_DATE) INTO V_WARNING_DATE_RECENT
        FROM TBL_WARNING
        WHERE USER_CODE = V_USER_CODE;
        
        IF(TRUNC(ADD_MONTHS(V_WARNING_DATE_RECENT, 12), 'DD') <= TRUNC(V_WARNING_DATE, 'DD'))
        THEN
            DELETE
            FROM TBL_WARNING
            WHERE USER_CODE = V_USER_CODE;
        END IF;    
    END IF;

------------------------------------------------------------------------------------------------------------------------
    V_WARNING_CODE := 'WR'|| STUDY_WARN_SEQ.NEXTVAL;
    INSERT INTO TBL_WARNING(WARNING_CODE, USER_CODE, WARNING_DATE) VALUES(V_WARNING_CODE, V_USER_CODE, V_WARNING_DATE);
    
------------------------------------------------------------------------------------------------------------------------    
    
   -- 경고개수, 계정정지개수
    SELECT COUNT(경고코드) 경고개수
      INTO V_WARNING_COUNT_TOT
    FROM WARNING_SUSPEND_VIEW
    WHERE 사용자=V_USER_CODE;   
  
    -- 경고가 3회 이상이면
    IF(V_WARNING_COUNT_TOT >= 3)
    
    THEN 
        -- 계정정지 이력이 존재하면 최근 계정정지 이후 경고수 세기
        IF (V_SUSPEND_COUNT > 0)
        THEN            
            -- 유효 경고개수
            SELECT COUNT(*) INTO V_WARNING_COUNT
            FROM WARNING_SUSPEND_VIEW
            WHERE 사용자=V_USER_CODE AND 경고날짜 > V_SUSPEND_DATE;
            
            -- 종료됐는지 확인
            IF (ADD_MONTHS(V_SUSPEND_DATE, 12) <= V_WARNING_DATE)
            THEN
                -- ▶ 종료 + 현재 유효한 경고수가 3개 이상이면 인서트
                IF (V_WARNING_COUNT >= 3)
                THEN
                    PRC_INSERT_SUSPEND(V_WARNING_DATE, V_WARNING_CODE);
                END IF;
                
                -- ▶종료안됐으면 업데이트 시키기    
             ELSE
                UPDATE TBL_ACCOUNT_SUSPEND
                SET ACCT_SUS_DATE = V_WARNING_DATE, WARNING_CODE = V_WARNING_CODE
                WHERE ACCT_SUS_CODE = V_SUSPEND_CODE;

            END IF;    
        
        -- ▶계정정지 이력이 존재하지 않으면 새로 계정 정지에 등록
        ELSE
            PRC_INSERT_SUSPEND(V_WARNING_DATE, V_WARNING_CODE);
        END IF;
        
    END IF;    
       
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
    
    COMMIT;
    
END;      
--==>> Procedure PRG_INSERT_WARNING이(가) 컴파일되었습니다.

CREATE OR REPLACE PROCEDURE PRC_INSERT_CANCEL
(
  V_APPLY_CODE    IN TBL_STUDY_APPLY.APPLY_CODE%TYPE
, V_CANCEL_DATE   IN TBL_STUDY_CANCEL.CANCEL_DATE%TYPE
, V_AUTO_CANCEL   IN TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE
)
IS
    V_CANCEL_CODE   TBL_STUDY_CANCEL.CANCEL_CODE%TYPE;
    V_STUDY         TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_LEFT          NUMBER;
    V_MIN           TBL_MEMNUM.MEMNUM%TYPE;
    V_START_DATE    TBL_STUDY_OPEN.START_DATE%TYPE;
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
BEGIN

    V_CANCEL_CODE := 'SC'|| STUDY_CANC_SEQ.NEXTVAL;
    
    INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
    VALUES(V_CANCEL_CODE, V_APPLY_CODE, V_CANCEL_DATE, V_AUTO_CANCEL);
    
    -- 스터디코드, 최소인원, 시작일, 참여자, 개설자 가져오기
    SELECT 스터디코드, 최소인원, 시작일, 참여자, 개설자 
        INTO V_STUDY, V_MIN, V_START_DATE, V_USER_CODE, V_FIRSTLEADER
    FROM STUDY_CANCEL_VIEW
    WHERE 취소코드 = V_CANCEL_CODE;
    
    -- 해당 스터디에 남은 사람 세기
    SELECT COUNT(*) INTO V_LEFT
    FROM STUDY_CANCEL_VIEW
    WHERE 취소코드 IS NULL AND 스터디코드 = V_STUDY;
 
    -- 최소인원보다 적게 남음 + 스터디 진행중인 경우
    IF (V_LEFT < V_MIN AND V_START_DATE <= V_CANCEL_DATE)
    THEN 
        -- ▶최소인원미만, 진행중 : 스터디 종료시킴.(종료날짜 오늘로.)
        UPDATE TBL_STUDY_OPEN
        SET END_DATE = V_CANCEL_DATE
        WHERE STUDY_CODE = V_STUDY;
        
    -- 최소인원보다 많이 남은 경우 자발적인 것인지 확인(자발적이면 NULL, 자동취소면 1)
    ELSIF (V_AUTO_CANCEL IS NULL)
    THEN
        -- 스터디가 진행중인지 확인
        IF (TRUNC(V_START_DATE, 'DD') <= TRUNC(V_CANCEL_DATE, 'DD'))
        THEN 
            -- ▶진행중, 개설자, 자발적 : -200
            IF (V_FIRSTLEADER = V_USER_CODE)
            THEN
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, V_CANCEL_DATE);
            
            -- ▶진행중, 개설자X, 자발적 : -100
            ELSE
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, V_CANCEL_DATE);
            
            END IF;
        ELSE
            -- ▶최소인원이상, 진행중X : 리더제외 NULL로 만듦
            PRC_UPDATE_DATE_NULL(V_STUDY); 
            
            -- 확정기간 마지막 2일인지 확인
            IF (TRUNC(V_CANCEL_DATE, 'DD') BETWEEN TRUNC(V_START_DATE-2, 'DD') AND TRUNC(V_START_DATE-1, 'DD'))
            THEN
                -- ▶확정기간 마지막2일, 개설자, 자발적 : -100
                IF (V_FIRSTLEADER = V_USER_CODE)
                THEN
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, V_CANCEL_DATE);
                    
                -- ▶확정기간 마지막2일, 개설자X, 자발적 : -30    
                ELSE
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, V_CANCEL_DATE);
                END IF;
            END IF;            
        END IF;
        
    END IF;
    
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
    
    COMMIT;
    
END;