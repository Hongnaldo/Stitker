
기술정보공유 신고 등록 여기서 갯수를 세고 5회미만이면 각각의 날짜를 세서 삭제
--○ it, 기술정보 공유 신고 삭제 

--○ 미리 해당 게시물의 신고 갯수가 5회미만인지 판단
CREATE OR REPLACE PROCEDURE PRC_REPORT_REG_INFORM 
(  POST_CODE IN TBL_BOARD_INFORM.POST_CODE%TYPE )
IS

-- 신고 갯수 확인용 
V_POST_COUNT    NUMBER;
BEGIN
        -- 개수 확인
        SELECT COUNT(*) AS T INTO V_POST_COUNT
        FROM TBL_REPORT_REG_INFORM R
        WHERE R.POST_CODE = POST_CODE;
        
        -- 신고 개수 5개미만이면
        IF(V_POST_COUNT <5)
        THEN
        CUR_REPORT_REG_INFORM(POST_CODE);
        END IF;
END;

--○ 커서를 이용한 신고 삭제
CREATE OR REPLACE PROCEDURE CUR_REPORT_REG_INFORM
(V_POST_CODE IN VARCHAR2 )
IS
    V_REPORT_DATE       DATE;
    
    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의)
    -- CURSOR 커서명
    
    CURSOR CUR_REPORT_REG_INFORM
    IS
    SELECT REPORT_DATE
    FROM TBL_REPORT_REG_INFORM
    WHERE POST_CODE = V_POST_CODE;
    
BEGIN
    -- 커서 오픈
    OPEN CUR_REPORT_REG_INFORM;
    
    -- 커서 오픈 시 쏟아져나오는 데이터들 처리(잡아내기)
    LOOP
            -- 한 행 한 행 받아다가 처리하는 행위 → 『FETCH』
            FETCH CUR_REPORT_REG_INFORM INTO V_REPORT_DATE;
            
            -- 신고날짜가 3년이 지났으면 삭제
            IF (ADD_MONTHS(V_REPORT_DATE, 36) <= SYSDATE)
            THEN 
                DELETE 
                FROM TBL_REPORT_REG_INFORM R
                WHERE R.POST_CODE = V_POST_CODE AND R.REPORT_DATE = V_REPORT_DATE;
            END IF;  
            
            
            -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태... NOTFOUND
            EXIT WHEN CUR_REPORT_REG_INFORM%NOTFOUND;
            
            
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_REPORT_REG_INFORM;
    
END;











-- ○ 2안 이였는데 1안으로 함
/*
기술정보공유 신고 등록 여기서 갯수를 세고 5회미만이면 각각의 날짜를 세서 삭제
--○ it, 기술정보 공유 신고 삭제 커서 생성
--○ 커서 이용 후 상황
DECLARE
    V_REPORT_DATE       DATE;
    V_POST_CODE         VARCHAR2(10);
    V_POST_COUNT        NUMBER;
    
    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의)
    -- CURSOR 커서명
    
    -- 게시물 코드 커서
    CURSOR CUR_POST_CODE
    IS
    SELECT POST_CODE
    FROM TBL_REPORT_REG_INFORM;
    
    -- 날짜 커서
    CURSOR CUR_REPORT_DATE
    IS
    SELECT REPORT_DATE
    FROM TBL_REPORT_REG_INFORM
    WHERE POST_CODE = V_POST_CODE;
    
    
BEGIN
        --  게시물 커서 오픈
        OPEN CUR_POST_CODE;
        
        -- 1번째 커서 오픈 시 쏟아져나오는 데이터들 처리(잡아내기)
        LOOP
               -- 한 행 한 행 받아다가 처리하는 행위 → 『FETCH』
                FETCH CUR_POST_CODE INTO V_POST_CODE; 
                
                -- 신고 개수가 5개 미만인지 확인
                SELECT COUNT(*) INTO V_POST_COUNT
                FROM TBL_REPORT_REG_INFORM
                WHERE POST_CODE = V_POST_CODE;
                
                IF( V_POST_COUNT <5)
                THEN
                
                
                        -- 날짜 커서 오픈
                        OPEN CUR_REPORT_DATE;
                        
                        -- 2번째 커서 오픈 시 쏟아져나오는 데이터들 처리(잡아내기)
                        LOOP
                                -- 한 행 한 행 받아다가 처리하는 행위 → 『FETCH』
                                FETCH CUR_REPORT_DATE INTO V_REPORT_DATE;
                                
                                -- 신고날짜가 3년이 지났으면 삭제
                                IF (ADD_MONTHS(V_REPORT_DATE, 36) <= SYSDATE)
                                THEN 
                                    DELETE 
                                    FROM TBL_REPORT_REG_INFORM R
                                    WHERE R.POST_CODE = V_POST_CODE AND R.REPORT_DATE = V_REPORT_DATE;
                                END IF;  
                                
                                
                                -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태... NOTFOUND
                                EXIT WHEN CUR_REPORT_DATE%NOTFOUND;
                                
                                
                        END LOOP; -- END 2번째 반복문
                        
                        -- 커서 클로즈
                        CLOSE CUR_REPORT_DATE;
                
                END IF; -- END IF문
        
         -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태... NOTFOUND
        EXIT WHEN CUR_POST_CODE%NOTFOUND;        
                
        END LOOP -- END 1번째 반복문 
    
END;
*/