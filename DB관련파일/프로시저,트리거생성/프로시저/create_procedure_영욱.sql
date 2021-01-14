
기술정보공유 신고 등록 여기서 갯수를 세고 5회미만이면 각각의 날짜를 세서 삭제
--○ it, 기술정보 공유 신고 삭제 

EXEC PRC_REPORT_REG_INFORM('GI58',5);


SELECT * 
FROM TBL_BOARD_INFORM;

SELECT * 
FROM TBL_REPORT_REG_INFORM;


TBL_REPORT_REG_INFORM
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
(V_POST_CODE IN VARCHAR2
,V_KICK_NUM      NUMBER)
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

--------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM TBL_STUDY_APPLY
ORDER BY STUDY_CODE
;
CREATE OR REPLACE PROCEDURE PRG_KICK_HANDLE_STUDY_CANCEL
( V_PARTI_KICKED_CODE   IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
, V_PARTI_KICK_CODE     IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
)
IS
    V_MEM_KICK_REG_CODE VARCHAR(15);
    V_TOT_APPLY_NUM NUMBER;             -- 총 신청자 수
    V_CANCEL_NUM     NUMBER;             -- 취소한 사람 수
    V_APPLY_NUM    NUMBER;                --  (총 신청자 수 - 취소한 사람 수)
    V_KICK_NUM      NUMBER;
    V_STUDY_CODE   VARCHAR2(15);
    V_APPLY_CODE    VARCHAR2(15);
BEGIN

    V_MEM_KICK_REG_CODE := 'KR'||MEM_KR_SEQ.NEXTVAL;
    
    -- ○ 내보내기 등록
    INSERT INTO TBL_MEM_KICK_REG
    (MEM_KICK_REG_CODE, PARTI_KICKED_CODE, PARTI_KICK_CODE, MEM_KICK_REG_DATE)
    VALUES(V_MEM_KICK_REG_CODE, V_PARTI_KICKED_CODE, V_PARTI_KICK_CODE, SYSDATE);
    
    -- 스터디 코드 받아오기
    SELECT T.STUDY_CODE, T.APPLY_CODE INTO V_STUDY_CODE, V_APPLY_CODE
    FROM
    (
    SELECT A.STUDY_CODE, A.APPLY_CODE, K.PARTI_KICKED_CODE, K.MEM_KICK_REG_CODE
    FROM TBL_MEM_KICK_REG K JOIN TBL_STUDY_PARTICIPANT P
     ON K.PARTI_KICKED_CODE = P.PARTI_CODE
        JOIN TBL_STUDY_APPLY A
        ON A.APPLY_CODE = P.APPLY_CODE
    ) T
    WHERE T.PARTI_KICKED_CODE = V_PARTI_KICKED_CODE AND T.MEM_KICK_REG_CODE = V_MEM_KICK_REG_CODE;
    
    -- 총 인원, 내보내기 한 인원
    SELECT T.TOT_APPLY_NUM, T.CANCEL_NUM INTO V_TOT_APPLY_NUM, V_CANCEL_NUM
    FROM
    (
    SELECT COUNT(A.APPLY_CODE) TOT_APPLY_NUM, COUNT(C.CANCEL_CODE) CANCEL_NUM, A.STUDY_CODE STUDY_CODE
    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
       ON A.APPLY_CODE = C.APPLY_CODE
    GROUP BY A.STUDY_CODE
    ) T
    WHERE T.STUDY_CODE = V_STUDY_CODE;
    
    -- ○ (총 스터디 사람 - 취소한 사람 )현재 스터디 참가자 수 확인
    V_APPLY_NUM := V_TOT_APPLY_NUM - V_CANCEL_NUM;
    
    -- ○ 내보내기 누른 수 확인
    SELECT COUNT(*) INTO V_KICK_NUM
    FROM TBL_MEM_KICK_REG
    WHERE PARTI_KICKED_CODE = V_PARTI_KICKED_CODE;
       
    
    IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- 내보내기 처리
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('KH'||MEM_KH_SEQ.NEXTVAL, V_MEM_KICK_REG_CODE, SYSDATE);
        
        -- 스터디 취소 처리
        PRC_INSERT_CANCEL(V_APPLY_CODE, SYSDATE, 1);
        
        ELSE
        dbms_output.put_line('예외이다');
    END IF;
    

END;










--------------------------------------
원본
CREATE OR REPLACE PROCEDURE PRG_KICK_HANDLE_STUDY_CANCEL
( V_MEM_KICK_REG_CODE IN TBL_MEM_KICK_REG.MEM_KICK_REG_CODE%TYPE
, V_PARTI_KICKED_CODE   IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
)
IS
    V_APPLY_NUM    NUMBER;
    V_KICK_NUM      NUMBER;
    V_APPLY_CODE   VARCHAR2(15);
BEGIN
    -- ○ 스터디 참가자 수 확인
    SELECT COUNT(*) INTO V_APPLY_NUM
    FROM TBL_STUDY_PARTICIPANT
    WHERE PARTI_CODE = V_PARTI_KICKED_CODE;
    
    -- ○ 내보내기 누른 수 확인
    SELECT COUNT(*) INTO V_KICK_NUM
    FROM TBL_MEM_KICK_REG
    WHERE PARTI_KICKED_CODE = V_PARTI_KICKED_CODE;
    
    -- ○ 스터디 참가자 코드 확인
    SELECT APPLY_CODE INTO V_APPLY_CODE
    FROM TBL_STUDY_PARTICIPANT
    WHERE PARTI_CODE = V_PARTI_KICKED_CODE;
    
    
    IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- 내보내기 처리
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('KH'||MEM_KH_SEQ.NEXTVAL, V_MEM_KICK_REG_CODE, SYSDATE);
        
        -- 스터디 취소 처리
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('CC'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
        
        ELSE
        dbms_output.put_line('예외이다');
    END IF;


END;
/*
--○ 내보내기 등록할때 체크해서 50% 넘었으면 내보내기처리 인서트+취소처리에 인서트
CREATE OR REPLACE PROCEDURE PRG_KICK_HANDLE_STUDY_CANCEL
( V_MEM_KICK_REG_CODE IN TBL_MEM_KICK_REG.MEM_KICK_REG_CODE%TYPE
, V_PARTI_KICKED_CODE   IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
)
IS
    V_APPLY_NUM    NUMBER;
    V_KICK_NUM      NUMBER;
    V_APPLY_CODE   VARCHAR2(15);
BEGIN
    PRG_V_APPLY_NUM(V_PARTI_KICKED_CODE, V_APPLY_NUM);
    PRG_V_KICK_NUM(V_PARTI_KICKED_CODE, V_KICK_NUM);
    PRG_V_APPLY_CODE(V_PARTI_KICKED_CODE, V_APPLY_CODE);
    
    IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- 내보내기 처리
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('KH'||MEM_KH_SEQ.NEXTVAL, V_MEM_KICK_REG_CODE, SYSDATE);
        
        -- 스터디 취소 처리
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('CC'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
        
        ELSE
        dbms_output.put_line('예외이다');
    END IF;


END;
*/






















/*
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--○ 내보내기 등록할때 체크해서 50% 넘었으면 내보내기처리 인서트+취소처리에 인서트
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_MEM_KICK_REG
        FOR EACH ROW
    
DECLARE
        -- 스터디 참가자 수 담을 변수 
        V_APPLY_NUM   NUMBER;
        -- 내보내기 누른 수 담을 변수
        V_KICK_NUM      NUMBER;
        -- 스터디 참가자 코드를 담을 변수
        V_APPLY_CODE   TBL_STUDY_PARTICIPANT.APPLY_CODE%TYPE;
        
BEGIN
     -- 스터디 참가자 수 확인
     SELECT COUNT(*) INTO V_APPLY_NUM
     FROM TBL_STUDY_PARTICIPANT
     WHERE PARTI_CODE = :NEW.PARTI_KICKED_CODE;
     
     -- 내보내기 누른 수 확인
     SELECT COUNT(*) INTO V_KICK_NUM
     FROM TBL_MEM_KICK_REG
     WHERE MEM_KICK_REG_CODE = :NEW.MEM_KICK_REG_CODE;
     
     -- 스터디 참가자 코드 확인
     SELECT APPLY_CODE INTO V_APPLY_CODE
     FROM TBL_STUDY_PARTICIPANT
     WHERE APPLY_CODE = :NEW.APPLY_CODE;
     
     -- 내보내기 누른 수가 50% 이상인 경우 내보내기 처리 및 스터디 취소 처리 
     IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- 내보내기 처리
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('??'||MEM_KH_SEQ.NEXTVAL, :NEW.MEM_KICK_REG_CODE, SYSDATE);
        
        -- 스터디 취소 처리
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('??'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
    END IF;
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