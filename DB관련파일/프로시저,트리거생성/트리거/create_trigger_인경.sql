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

--○ 출석부 업데이트 -> 퇴실시간 존재하는지 체크 -> 지각 체크해서 지각이면 5점 감점.
--                                                조퇴 체크해서 조퇴면 5점 감점.
--                                                결석하면 10점 감점....
-- USER_CODE  

-- 출석버튼 누르면 출석 / 퇴실버튼 누르면 퇴실 
-- 출석만하고 퇴실 안 하면 결석처리. 

CREATE OR REPLACE TRIGGER TRG_STD_ATND_INSERT
    AFTER
    INSERT ON TBL_STUDY_ATTEND
DECLARE
      V_CLOCK_IN TBL_STUDY_ATTEND.CLOCK_IN%TYPE;       -- 출석시간
      V_CLOCK_OUT TBL_STUDY_ATTEND.CLOCK_OUT%TYPE;     -- 퇴실시간
      V_APPLY_CODE TBL_STUDY_APPLY.USER_CODE%TYPE;     -- 사용자 코드 
      V_SCORE TBL_SCORE.SCORE%TYPE;                    -- 사용자 점수
      V_START_TIME TBL_STUDY_MEETDAY.START_TIME%TYPE;  -- 스터디 시작 시간
      V_END_TIME TBL_STUDY_MEETDAY.END_TIME%TYPE;      -- 스터디 종료 시간
      
BEGIN
  
     SELECT AP.USER_CODE INTO V_USER_CODE              -- 사용자 코드
     FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
     ON A.PARTI_CODE = P.PARTI_CODE
        JOIN TBL_STUDY_APPLY AP 
        ON P.APPLY_CODE = AP.APPLY_CODE;

-- 뷰 생성 
 CREATE OR REPLACE VIEW STUDY_TIME_VIEW
 AS
 SELECT M.START_TIME, M.END_TIME 
 FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
     ON A.PARTI_CODE = P.PARTI_CODE
        JOIN TBL_STUDY_APPLY AP 
        ON P.APPLY_CODE = AP.APPLY_CODE
            JOIN TBL_STUDY_OPEN O
            ON AP.STUDY_CODE = O.STUDY_CODE
                JOIN TBL_STUDY_MEETDAY M
                ON O.STUDY_CODE = M.STUDY_CODE 
 WHERE M.WEEKDAY_CODE = (SELECT 'WD'||TO_CHAR(SYSDATE, 'D') FROM DUAL);
 --==>>View STUDY_TIME_VIEW이(가) 생성되었습니다.
 
-- 스터디 요일별 시작시간 , 종료시간    
 SELECT START_TIME INTO V_START_TIME
 FROM STUDY_TIME_VIEW;
 
 SELECT END_TIME INTO V_END_TIME
 FROM STUDY_TIME_VIEW;
  
--SELECT * FROM TBL_WEEKDAY; --> 월요일이 1로 들어가있음... ㅜㅜ
-- 오늘의 요일(1:일, 2:월, 3:화, 4:수, 5:목, 6:금, 7:토) : SELECT TO_CHAR(SYSDATE, 'D')FROM DUAL;
 
 
    SELECT CLOCK_IN INTO V_CLOCK_IN     -- 출석 시간
    FROM TBL_STUDY_ATTEND 
    WHERE V_PARTI_CODE = :NEW.PARTI_CODE;
    
    SELECT CLOCK_OUT INTO V_CLOCK_OUT   -- 퇴실시간
    FROM TBL_STUDY_ATTEND
    WHERE V_PARTI_CODE = :NEW.PARTI_CODE;

     IF
       퇴실시간 IS NULL 
            THEN  IF(V_CLOCK_IN > 스터디시작시간)    -- 지각체크
                    THEN UPDATE TBL_SCORE
                    SET SCORE = :OLD.USER_SCORE -5;
                    WHERE USER_CODE = V_USER_CODE;
                  END IF;
     ELSE 
        V_CLOCK_OUT < 스터디 종료시간                   -- 조퇴
        THEN UPDATE TBL_SCORE
             SET SCORE =:OLD.USER_SCORE -5;
             WHERE USER_CODE = V_USER_CODE;
    END IF;  
    
    
END;

