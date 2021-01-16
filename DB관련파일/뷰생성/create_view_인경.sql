--■■■ 뷰(VIEW) 생성 ■■■--
--※SELECT로 먼저 조회한 후 CREATE VIEW 하기
-- 조회
SELECT *
FROM VIEW_STUDY_NOW
WHERE STUDY_CODE ='SO5';

-- ○ MYPAGE_STUDY.jsp(마이페이지 - 첫 화면은 진행중인 스터디 목록이 뜬다.) + MYPAGE_NOW_STUDY.jsp
-- ○ 뷰 이름 : MY_NOW_STUDY_VIEW  
-- 진행중인 스터디 정보 조회

-- 조건 
-- 1. 시작일 <= SYSDATE <= 종료일
-- 2. 진행테이블에 있는 apply_code가 취소테이블에 다 들어가 있으면 안 됨--> ②에서 추출된 인원 수가 3이상이면 됨.     
CREATE OR REPLACE VIEW VIEW_STUDY_NOW
AS
SELECT ROWNUM "RNUM", O.STUDY_NAME "STUDY_NAME" , TO_CHAR(O.CLOSE_DATE,'YYYY/MM/DD') "CLOSE_DATE",
       TO_CHAR(O.START_DATE,'YYYY/MM/DD') ||' ~ ' || TO_CHAR(O.END_DATE,'YYYY/MM/DD') "PERIOD",
    A.STUDY_CODE "STUDY_CODE" ,P.PARTI_CODE "PARTI_CODE", A.USER_CODE "USER_CODE",
    W.WEEKDAY "WEEKDAY", M.START_TIME "START_TIME", M.END_TIME "END_TIME", TRUNC(END_DATE - START_DATE)+1  "PROGRESS",  TRUNC(SYSDATE -START_DATE)+1 "NOWPGS"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        LEFT OUTER JOIN TBL_STUDY_MEETDAY M
        ON O.STUDY_CODE = M.STUDY_CODE
            LEFT OUTER JOIN TBL_WEEKDAY W
            ON M.WEEKDAY_CODE = W.WEEKDAY_CODE           
WHERE (SYSDATE >= O.START_DATE AND SYSDATE <=O.END_DATE); 


-- ②. 진행 테이블에 있는 인원 수(취소 테이블에는 없는 사람) --> 진짜 진행중인 사람
SELECT COUNT(P.APPLY_CODE) "MEM"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
WHERE A.STUDY_CODE = 'SO4' AND A.APPLY_CODE NOT IN (SELECT C.APPLY_CODE
                                                    FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
                                                    ON P.APPLY_CODE = A.APPLY_CODE 
                                                    JOIN TBL_STUDY_CANCEL C
                                                    ON A.APPLY_CODE = C.APPLY_CODE
                                                    WHERE STUDY_CODE ='SO4');
                                                    


-- 취소 테이블에 없고 진행테이블에 있는 인원
SELECT P.APPLY_CODE "MEMBER"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
WHERE A.STUDY_CODE = 'SO4' AND A.APPLY_CODE NOT IN (SELECT C.APPLY_CODE
                                                    FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
                                                    ON P.APPLY_CODE = A.APPLY_CODE 
                                                    JOIN TBL_STUDY_CANCEL C
                                                    ON A.APPLY_CODE = C.APPLY_CODE
                                                    WHERE STUDY_CODE ='SO4');
                                                    


                                       
-- 진행에 있는 인원 아이디
SELECT P.APPLY_CODE "MEMBER", R.ID "ID", A.STUDY_CODE "STUDY_CODE"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_USER_REGISTER R
    ON A.USER_CODE = R.USER_CODE
WHERE A.STUDY_CODE ='SO24' AND A.APPLY_CODE NOT IN (SELECT C.APPLY_CODE
                                                    FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
                                                    ON P.APPLY_CODE = A.APPLY_CODE 
                                                    JOIN TBL_STUDY_CANCEL C
                                                    ON A.APPLY_CODE = C.APPLY_CODE
                                                    WHERE STUDY_CODE ='SO24');
                                                    
/*
SA51 	ljj33	SO24
SA56	    ljj33	SO25
SA5	    ljj33	SO4
*/                                                    
--1명.

-- 참가 테이블에 있는 사람 확인
SELECT APPLY_CODE, USER_CODE
FROM TBL_STUDY_APPLY
WHERE STUDY_CODE ='SO20';
/*
SA178	UC2
SA180	UC4
SA181	UC5
SA51	    UC3 -진행
SA52	    UC1 -진행
SA54	    UC6 -진행
*/

DROP TRIGGER TRG_STD_PARTI_INSERT;
-- SO24 스터디 신청 6명 완료. 
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 'SO24', 'UC1', TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'SP1');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 'SO24', 'UC2', TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'SP2');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 'SO24', 'UC3', TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'SP2');   
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 'SO24', 'UC4', TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'SP2');    
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 'SO24', 'UC5', TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'SP2');   
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 'SO24', 'UC6', TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'SP2');   
    
-- 진행
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA178');    
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA180'); 
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA181'); 
    
    
-- 취소
INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
    VALUES('SC'|| STUDY_CANC_SEQ.NEXTVAL, 'SA178', TO_DATE('2021-01-15', 'YYYY-MM-DD')); 
INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
    VALUES('SC'|| STUDY_CANC_SEQ.NEXTVAL, 'SA181', TO_DATE('2021-01-19', 'YYYY-MM-DD'));    

SELECT *
FROM TBL_STUDY_ACCUSE;
-- SO4, SO5, SO6 신고됨 


-- 취소 테이블에 없고 진행에 있는 사람
SELECT P.APPLY_CODE
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
WHERE A.STUDY_CODE = 'SO4' AND A.APPLY_CODE NOT IN (SELECT C.APPLY_CODE
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE 
    JOIN TBL_STUDY_CANCEL C
    ON C.APPLY_CODE = A.APPLY_CODE
WHERE STUDY_CODE ='SO4');
/*
SA52
SA51  --리더
SA54
*/ 


-- 취소 테이블에 들어간 사람 
SELECT C.APPLY_CODE
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE 
    JOIN TBL_STUDY_CANCEL C
    ON C.APPLY_CODE = A.APPLY_CODE
WHERE STUDY_CODE ='SO20';



-- 진행테이블에 있는 인원 확인     
SELECT P.APPLY_CODE 
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
WHERE STUDY_CODE = 'SO20'; 
/*
SO20 : 없음
SO24 : 

*/
/*
SA8
SA10
*/


-- 취소 테이블 
SELECT C.APPLY_CODE 
FROM TBL_STUDY_CANCEL C JOIN TBL_STUDY_APPLY A
ON C.APPLY_CODE = A.APPLY_CODE
WHERE A.STUDY_CODE = 'SO9';
--SO5에서 취소한 사라 : SA8
--SO9에서 취소한 사람 : SA15


UPDATE TBL_STUDY_OPEN
SET END_DATE = TO_DATE('2021-01-21','YYYY-MM-DD')
WHERE STUDY_CODE='SO24';

SELECT *
FROM TBL_STUDY_OPEN;
 
SELECT *
FROM TBL_STUDY_OPEN  
WHERE (SYSDATE >= START_DATE AND SYSDATE <=END_DATE);



SELECT COUNT(A.APPLY_CODE) "MEM"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
WHERE A.STUDY_CODE = 'SO20' AND A.APPLY_CODE NOT IN (SELECT C.APPLY_CODE
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE 
    JOIN TBL_STUDY_CANCEL C
    ON A.APPLY_CODE = C.APPLY_CODE
WHERE STUDY_CODE ='SO20');


--3개. 
/*
SO9	UC3	2020-12-31	2	ST3	IM9	2021-01-10	2021-01-18	MN1	MN6	테스트	                        UR4	2021-01-18	신청취소테스트용
SO25	UC5	2020-12-27	0	ST2	IM2	2021-01-11	2021-01-30	MN1	MN3	테스트1	                        UR4	2021-01-04	성실하신분 환영
SO5	UC5	2020-12-20	0	ST2	IM2	2021-01-04	2021-01-18	MN1	MN3	정보처리기사 자격증 취득 스터디	UR4	2021-01-04	스터디로 정처기 박살내실분들!! 성실하신분 환영
*/    
    
SELECT *
FROM TBL_STUDY_APPLY;

SELECT *
FROM TBL_STUDY_CANCEL;

-- 취소한 사람 확인 
SELECT A.STUDY_CODE, A.USER_CODE, C.AUTO_CANCEL
FROM TBL_STUDY_CANCEL C JOIN TBL_STUDY_APPLY A
ON C.APPLY_CODE = A.APPLY_CODE;
/*
SO10    	UC13
SO10	    UC5
SO10    	UC6
SO13	    UC1
SO25    	UC1
SO26    	UC1
SO5	    UC1
SO9	    UC1
*/


SELECT *
FROM TBL_STUDY_PARTICIPANT
ORDER BY APPLY_CODE;
/*
SA7  -- X
SA8  -- O
SA9  -- X
SA10 -- O
*/
--스터디 번호 SO5
SELECT *
FROM VIEW_STUDY_NOW
WHERE USER_CODE = 'UC1';

SELECT *
FROM TBL_STUDY_APPLY
WHERE STUDY_CODE ='SO5';



--AND A.STUDY_CODE NOT IN (SELECT STUDY_CODE FROM TBL_STUDY_CANCEL)
SELECT *
FROM TBL_STUDY_CANCEL;

SELECT *
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE;


SELECT O.STUDY_NAME "STUDY_NAME", O.WRITE_DATE "WRITE_DATE", O.START_DATE "START_DATE", O.END_DATE "END_DATE" 
       ,O.LOC_MC_CODE "LOC_MC_CODE", O.USER_CODE
FROM TBL_STUDY_OPEN O
WHERE START_DATE <SYSDATE;



SELECT A.STUDY_CODE, A.APPLY_CODE
FROM TBL_STUDY_CANCEL C JOIN TBL_STUDY_APPLY A
ON C.APPLY_CODE = A.APPLY_CODE;

-- 취소된 스터디 == 참가신청인원이 전부 취소 테이블에 있다. 

--스터디 취소한 인원 수 
SELECT COUNT(*) "CANCEL_NUM"
FROM TBL_STUDY_APPLY 
WHERE APPLY_CODE IN (SELECT APPLY_CODE FROM TBL_STUDY_CANCEL) AND STUDY_CODE = 'SO25';

--스터디에 참가한 인원 수 
SELECT COUNT(*) "APPLY_NUM"
FROM TBL_STUDY_APPLY
WHERE STUDY_CODE ='SO25';


-- SO5 스터디에서 취소한 사람 
SELECT A.USER_CODE, A.STUDY_CODE
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_CANCEL C 
ON A.APPLY_CODE= C.APPLY_CODE AND A.STUDY_CODE ='SO5'





--조회 예시
SELECT *
FROM MY_NOW_STUDY_VIEW
WHERE USER_CODE ='UC3'; 

--
/*
스터디명                        모집마감일      스터디 시작일    스터디 종료일    스터디코드  진행코드   사용자 코드     직책   요일   시작시간  종료시간 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------- ---------- ---------- --------------- --------------- ---------- ---- ---------- ----- -----
정보처리기사 자격증 취득 스터디	2021-01-04	2021-01-04	    2021-01-18	        SO5	     PT11	    UC1	        스터디원	화	20:00	21:00
JS스터디	                        2021-01-04	2021-01-10	    2021-01-30	        SO24	     PT23	    UC1	        스터디원			
테스트1	                        2021-01-04	2021-01-11	    2021-01-30	        SO25	     PT31    	UC1	        스터디원			
*/


-- ○ MYPAGE_UPCOMING_STUDY.jsp(마이페이지 - 진행 예정 스터디.)
-- ○ 뷰 이름 : MY_NOW_STUDY_VIEW  
-- 진행예정인 스터디 정보 조회 
CREATE OR REPLACE VIEW VIEW_STUDY_UPCOMING
AS
SELECT O.STUDY_NAME "STUDY_NAME" , TO_CHAR(O.CLOSE_DATE,'YYYY/MM/DD') "CLOSE_DATE",
    TO_CHAR(O.START_DATE,'YYYY/MM/DD') ||' ~ ' || TO_CHAR(O.END_DATE,'YYYY/MM/DD') "PERIOD"
       ,O.STUDY_CODE "STUDY_CODE" ,P.PARTI_CODE "PARTI_CODE", A.USER_CODE "USER_CODE"
       ,W.WEEKDAY "WEEKDAY", M.START_TIME "START_TIME", M.END_TIME "END_TIME",
       TRUNC(END_DATE - START_DATE)+1  "PROGRESS", CASE WHEN (TRUNC(SYSDATE -START_DATE)+1)< 0 THEN 0 ELSE TRUNC(SYSDATE -START_DATE+1) END "NOWPGS"
FROM TBL_STUDY_PARTICIPANT P LEFT OUTER JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
    LEFT OUTER JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
       LEFT OUTER JOIN TBL_STUDY_MEETDAY M
        ON O.STUDY_CODE = M.STUDY_CODE
            LEFT OUTER JOIN TBL_WEEKDAY W
            ON M.WEEKDAY_CODE = W.WEEKDAY_CODE             
WHERE SYSDATE < O.START_DATE 
ORDER BY TO_NUMBER(SUBSTR(P.PARTI_CODE, 3)) ASC;
--==>>View MY_NOW_STUDY_VIEW이(가) 생성되었습니다.
-- WHERE USER_CODE = '유저코드'  추가하기 

DROP VIEW MY_NOW_STUDY_VIEW;


--   오늘 <= 시작일 <= 스터디 확인 
SELECT A.APPLY_CODE , A.STUDY_CODE, O.STUDY_NAME, O.START_DATE, O.END_DATE
FROM TBL_STUDY_APPLY A RIGHT OUTER JOIN TBL_STUDY_OPEN O
ON A.STUDY_CODE = O.STUDY_CODE
WHERE SYSDATE >= O.START_DATE ;

-- 시작일 <= 오늘 <= 종료일 스터디 확인 
SELECT A.APPLY_CODE , A.STUDY_CODE, O.STUDY_NAME, O.START_DATE, O.END_DATE
FROM TBL_STUDY_APPLY A RIGHT OUTER JOIN TBL_STUDY_OPEN O
ON A.STUDY_CODE = O.STUDY_CODE
WHERE  (SYSDATE > O.START_DATE AND SYSDATE <O.END_DATE);

-- 종료일 <= 오늘 
SELECT A.APPLY_CODE , A.STUDY_CODE, O.STUDY_NAME, O.START_DATE, O.END_DATE
FROM TBL_STUDY_APPLY A RIGHT OUTER JOIN TBL_STUDY_OPEN O
ON A.STUDY_CODE = O.STUDY_CODE
WHERE (SYSDATE > O.START_DATE AND SYSDATE >O.END_DATE);


SELECT *
FROM TBL_STUDY_OPEN;

/*
SELECT USER_CODE
FROM TBL_STUDY_APPLY 
WHERE POSITION_CODE = 'SP1' AND STUDY_CODE='SO13';

SELECT A.APPLY_CODE , A.USER_CODE , A.POSITION_CODE, A.STUDY_CODE, P.PARTI_CODE
FROM TBL_STUDY_PARTICIPANT P RIGHT OUTER JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
WHERE A.POSITION_CODE = 'SP1' AND A.STUDY_CODE ='SO10';
SA21	UC5	SP1	SO10	
DELETE
FROM TBL_STUDY_APPLY
WHERE APPLY_CODE = 'SA21';

SELECT *
FROM TBL_STUDY_PARTICIPANT;
DELETE 
FROM tbl_study_participant
WHERE PARTI_CODE = 'PT26';

SELECT *
FROM TBL_STUDY_OPEN;
*/

-- ○ MYPAGE_END_STUDY.jsp(마이페이지 - 종료된 스터디 확인)
-- ○ 뷰 이름 : MY_END_STUDY_VIEW
-- 종료된 스터디 
CREATE OR REPLACE VIEW VIEW_STUDY_END
AS
SELECT ROWNUM "RNUM", O.STUDY_NAME "STUDY_NAME" , TO_CHAR(O.CLOSE_DATE,'YYYY/MM/DD') "CLOSE_DATE",
      TO_CHAR(O.START_DATE,'YYYY/MM/DD') ||' ~ ' || TO_CHAR(O.END_DATE,'YYYY/MM/DD') "PERIOD"
    ,O.STUDY_CODE "STUDY_CODE" ,P.PARTI_CODE "PARTI_CODE", A.USER_CODE "USER_CODE"
    ,(SELECT USER_CODE FROM TBL_STUDY_APPLY WHERE POSITION_CODE ='SP1'AND STUDY_CODE =O.STUDY_CODE) "LEADER", 
    W.WEEKDAY "WEEKDAY", M.START_TIME || ' ~ '|| M.END_TIME "END_TIME"
    ,TRUNC(END_DATE - START_DATE)+1  "PROGRESS",  CASE WHEN TRUNC(SYSDATE -START_DATE)+1>TRUNC(END_DATE - START_DATE)+1 THEN (TRUNC(END_DATE - START_DATE)+1) ELSE 
    TRUNC(SYSDATE - START_DATE)+1 END "NOWPGS", R.ID "ID", L.LOC_MC "PLACE"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
       LEFT OUTER JOIN TBL_STUDY_MEETDAY M
        ON O.STUDY_CODE = M.STUDY_CODE
            LEFT OUTER JOIN TBL_WEEKDAY W
            ON M.WEEKDAY_CODE = W.WEEKDAY_CODE
                LEFT JOIN TBL_USER_REGISTER R
                ON A.USER_CODE = R.USER_CODE 
                    JOIN TBL_LOC_MC L
                    ON O.LOC_MC_CODE = L.LOC_MC_CODE 
WHERE  (SYSDATE > O.START_DATE AND SYSDATE >O.END_DATE)
ORDER BY TO_NUMBER(SUBSTR(P.PARTI_CODE, 3)) ASC;
--AND A.USER_CODE = 'UC1' -- 여기에 로그인 한 사람 USER_CODE 넣기.
-- 조회 예시
SELECT RNUM, STUDY_NAME,CLOSE_DATE,PERIOD,USER_CODE,STUDY_CODE,PARTI_CODE,LEADER,WEEKDAY,END_TIME,PROGRESS,NOWPGS,PLACE
FROM VIEW_STUDY_END
WHERE ID = 'phi11';


-- 종료된 스터디 요일, 시간 데이터 확인 
SELECT O.STUDY_CODE "STUDY_CODE" ,
    W.WEEKDAY "WEEKDAY", M.START_TIME || ' ~ '|| M.END_TIME "END_TIME", R.ID "ID"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
       LEFT OUTER JOIN TBL_STUDY_MEETDAY M
        ON O.STUDY_CODE = M.STUDY_CODE
            LEFT OUTER JOIN TBL_WEEKDAY W
            ON M.WEEKDAY_CODE = W.WEEKDAY_CODE
                LEFT OUTER JOIN TBL_USER_REGISTER R
                ON A.USER_CODE = R.USER_CODE 
                    JOIN TBL_LOC_MC L
                    ON O.LOC_MC_CODE = L.LOC_MC_CODE 
WHERE  (SYSDATE >O.END_DATE) AND A.STUDY_CODE = 'SO4'
ORDER BY TO_NUMBER(SUBSTR(P.PARTI_CODE, 3)) ASC;












-- 요일, 시간 확인 
SELECT W.WEEKDAY "WEEKDAY", M.START_TIME, M.END_TIME
FROM TBL_STUDY_MEETDAY M LEFT OUTER JOIN TBL_STUDY_OPEN O
    ON M.STUDY_CODE = O.STUDY_CODE 
        LEFT OUTER JOIN TBL_WEEKDAY W
        ON M.WEEKDAY_CODE = W.WEEKDAY_CODE
WHERE O.STUDY_CODE ='S04';        
            

SELECT *
FROM STD_APPLY_CHECK_VIEW;

-- 나의 참여 코드 얻오오기 



-- ○ MYPAGE_END_STUDY.jsp(마이페이지 - 종료된 스터디 - 내 점수 조회) 
-- ○ 뷰 이름 : ASSESS_SCORE_VIEW
DROP VIEW END_SCORE_VIEW;
CREATE OR REPLACE VIEW VIEW_END_SCORE
AS
SELECT TRUNC(AVG(A.SCORE)) AS SCORE , I.PARTI_ASSESSED_CODE "PARTI_CODE" 
FROM TBL_STUDY_INTERASSESS I, TBL_STUDY_ASSESS_RESP A, TBL_STUDY_PARTICIPANT P
, TBL_STUDY_APPLY S, TBL_STUDY_OPEN O
WHERE I.RESP_CODE = A.RESP_CODE AND I.PARTI_ASSESSED_CODE = P.PARTI_CODE AND P.APPLY_CODE = S.APPLY_CODE
AND S.STUDY_CODE = O.STUDY_CODE
GROUP BY I.PARTI_ASSESSED_CODE;
-- /* 뷰 조회 예시 */
SELECT *
FROM VIEW_END_SCORE
WHERE PARTI_CODE ='PT7';
/*
SCORE       PARTI_CODE     
---------- ---------------
33          PT7            
*/



SELECT *
FROM TBL_STUDY_PARTICIPANT;

/*
PT7 : 100 
PT8 : 300
PT9 : 100

PT7	100	PT8
PT7	100	PT8
PT7	100	PT8
PT8	20	PT9
PT8	40	PT9
PT8	40	PT9
PT8	20	PT7
PT8	40	PT7
PT8	40	PT7
*/

/* 데이터 입력 
SELECT *
FROM TBL_STUDY_INTERASSESS;
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT7', 'AR1', 'AI1', 'PT8', TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT7', 'AR1', 'AI2', 'PT8', TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT7', 'AR1', 'AI3', 'PT8', TO_DATE('2020-12-17','YYYY-MM-DD'));   
    
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT8', 'AR5', 'AI1', 'PT9', TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT8', 'AR4', 'AI2', 'PT9', TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT8', 'AR4', 'AI3', 'PT9', TO_DATE('2020-12-17','YYYY-MM-DD'));       

INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT8', 'AR5', 'AI1', 'PT7', TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT8', 'AR4', 'AI2', 'PT7', TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_ASSESS_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT8', 'AR4', 'AI3', 'PT7', TO_DATE('2020-12-17','YYYY-MM-DD'));             

INSERT INTO TBL_STUDY_ASSESS(ASSESS_CODE, PARTI_CODE, SCORE, ASSESS_DATE)
    VALUES('AS'|| STUDY_ASSE_SEQ.NEXTVAL, 'PT7', 5, TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_ASSESS(ASSESS_CODE, PARTI_CODE, SCORE, ASSESS_DATE)
    VALUES('AS'|| STUDY_ASSE_SEQ.NEXTVAL, 'PT8', 4.5, TO_DATE('2020-12-17','YYYY-MM-DD'));
INSERT INTO TBL_STUDY_ASSESS(ASSESS_CODE, PARTI_CODE, SCORE, ASSESS_DATE)
    VALUES('AS'|| STUDY_ASSE_SEQ.NEXTVAL, 'PT9', 4, TO_DATE('2020-12-17','YYYY-MM-DD'));    
COMMIT;

*/

-- ○ 아직 없음.jsp(스터디 컨텐츠)
-- ○ 뷰 이름 : STD_CONTENT_VIEW  
DROP VIEW STD_CONTENT_VIEW;
CREATE OR REPLACE VIEW VIEW_STD_CONTENT
AS
SELECT C.CONTENT_CODE "CONTENT_CODE", R.ID "ID" 
    , C.WRITE_DATE "WRITE_DATE" , C.HITCOUNT "HITCOUNT",C.TITLE "TITLE", C.CONTENT "CONTENT", A.STUDY_CODE "STUDY_CODE"
FROM TBL_STUDY_CONTENT C JOIN TBL_STUDY_PARTICIPANT P
ON C.PARTI_CODE = P.PARTI_CODE
    JOIN TBL_STUDY_APPLY A
    ON P.APPLY_CODE = A.APPLY_CODE
        JOIN TBL_USER_REGISTER R
        ON A.USER_CODE = R.USER_CODE;
-- WHERE A.STUDY_CODE = '스터디코드';  
-- SELECT * FROM STD_CONTENT_VIEW 로 조회할 때 WHERE절에 내가 누른 스터디의 STUDY_CODE를 넣으면 된다.
--조회 예시
SELECT *
FROM VIEW_STD_CONTENT
WHERE STUDY_CODE = 'SO25';
--==>>
/*
CT22	phi11	2021-01-11	0	오늘공부3423424한거요.	PR오라클공부.COM/오늘공부 ←이 링크로 오시면 됩니다.	SO25
CT18	phi11	2021-01-11	0	오늘공부한거정리해봤어요.	PROGRAMMER_A.TSTORY.COM/오늘공부 ←이 링크로 오시면 됩니다.	SO25
CT20	ljj33	2021-01-11	0	안343녕하세요	123 좋아요. 한 번 둘러보세요.ZKAKAO.COM	SO25
CT27	ljj33	2021-01-11	0	안녕하세요	여기 제가 발견한 사이트인데 너무 좋아요. 한 번 둘러보세요. WWW.STUDY_IT.COM	SO25
CT25	ljj33	2021-01-11	0	안녕하세요	여기 제가 발견한 사이트인데 너무 좋아요. 한 번 둘러보세요. WWW.STUDY_IT.COM	SO25
CT23	jik55	2021-01-11	0	처음올리네요	스터디리더인데 이제야 처음 올리네요..ㅠㅠ 다음시간까지 이거랑 저거랑 공부할테니 예습 해옵시다!	SO25
CT21	jik55	2021-01-11	0	처음 2342오실 때 준비하실 것	노트북챙겨오세요. 안녕하세요 각오해오면 좋겠습니다.	SO25
CT19	jik55	2021-01-11	0	2올리네요	스터디리더인데 이제야 처음 올리네요.다음시간까지 이거랑 저거랑 공부 해옵시다!	SO25
CT17	jik55	2021-01-11	0	처음 오실 때 준비하실 것	노트북챙겨오세요. 자기소개도 할거니까 미리 생각해오면 좋겠습니다.	SO25
*/

DESC TBL_STUDY_CANCEL;
-- ○ MYPAGE_MYSTUDY.jsp(마이페이지 - 취소된 스터디 정보 확인) -- 내가 취소했거나 리더가 안 뽑아줬을 때
-- ○ 뷰 이름 : STD_CANCEL_VIEW
-- 1이면 자동취소 / NULL이면 자발적
CREATE OR REPLACE VIEW VIEW_CANCEL_STD
AS
SELECT C.CANCEL_CODE "CANCEL_CODE" , (CASE WHEN C.AUTO_CANCEL =1 THEN '자동취소' ELSE '자발적 취소' END) "AUTO_CANCEL", A.STUDY_CODE "STUDY_CODE", O.STUDY_NAME "STUDY_NAME", 
       R.ID "ID", C.CANCEL_DATE "CENCEL_DATE", A.USER_CODE "USER_CODE", TO_CHAR(O.START_DATE,'YYYY/MM/DD') ||' ~ ' || TO_CHAR(O.END_DATE,'YYYY/MM/DD') "PERIOD" 
FROM TBL_STUDY_CANCEL C JOIN TBL_STUDY_APPLY A
ON C.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_USER_REGISTER R
    ON A.USER_CODE = R.USER_CODE
        JOIN TBL_STUDY_OPEN O 
        ON A.STUDY_CODE = O.STUDY_CODE
WHERE ID='phi11';

-- 조회예시
SELECT *
FROM VIEW_CANCEL_STD
WHERE ID='phi11';

--WHERE USER_CODE = 'UC1';  
--> 조회할 때 사용자 코드 넣는거 추가하기. 

-- 스터디 취소된 사항을 알려줘야함. 
-- 오토캔슬1이면 -> 강제취소
-- 오토캔슬 null이면 -> 신청 인원이 없어서 취소된것. 


SELECT *
FROM TBL_STUDY_OPEN;

SELECT *
FROM TBL_STUDY_CANCEL;
WHERE AUTO_CANCEL = 1 AND APPLY_CODE ='';

DELETE 
FROM TBL_STUDY_OPEN
WHERE STUDY_CODE ='SO20';

SELECT A.STUDY_CODE, A.USER_CODE 
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_OPEN O
ON A.STUDY_CODE = O.STUDY_CODE;

DELETE 
FROM TBL_STUDY_APPLY A
WHERE STUDY_CODE ='SO13'


-- 종료된 스터디, 진행중인 스터디 , 취소된 스터디 , 진행예정인 스터디 
SELECT *
FROM TBL_STUDY_CANCEL C JOIN TBL_STUDY_APPLY A
ON ;

COMMIT;


--조회예시
SELECT *
FROM MY_CANCEL_STD_VIEW
WHERE USER_CODE ='UC3';


-- ○ MYPAGE_ATTENDANCE.jsp(나의 출석부 조회하는 페이지)
-- ○ 뷰 이름 : ATD_ATTEND_VIEW 
DROP VIEW ATD_ATTEND_VIEW;

CREATE OR REPLACE VIEW VIEW_STUDY_ATTEND
AS
SELECT  A.ATTEND_CODE "ATTEND_CODE",P.PARTI_CODE "PARTI_CODE", AP.USER_CODE "USER_CODE", M.WEEKDAY_CODE "WEEKDAY_CODE"
       , TO_CHAR(A.CLOCK_IN,'HH24:MI') "CLOCK_IN" , A.CLOCK_OUT "CLOCK_OUT", AP.STUDY_CODE "STUDY_CODE", R.ID "ID"
FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
 ON A.PARTI_CODE = P.PARTI_CODE
    JOIN TBL_STUDY_APPLY AP 
    ON P.APPLY_CODE = AP.APPLY_CODE
        JOIN TBL_STUDY_OPEN O
        ON AP.STUDY_CODE = O.STUDY_CODE
            JOIN TBL_STUDY_MEETDAY M
            ON O.STUDY_CODE = M.STUDY_CODE 
                JOIN TBL_SCORE S
                ON O.USER_CODE = S.USER_CODE
                    JOIN TBL_USER_REGISTER R
                    ON A.USER_CODE = R.USER_CODE;

-- 조회 예시. 로그인한 회원의 USER_CODE와 클릭한 스터디의 스터디코드를 가져와서 조회한다. 
SELECT *
FROM VIEW_STUDY_ATTEND
WHERE USER_CODE = 'UC6' 
AND STUDY_CODE ='SO5';   
---- > 이 부분 추가해야함.




-- ○ 진행중, 진행예정, 종료된 스터디 .jsp(상세페이지에서 회원목록 버튼을 클릭하면 조회되는 내용)
-- ○ 뷰 이름 : MY_STD_MEMBER
CREATE OR REPLACE VIEW MY_STD_MEMBER
AS
SELECT A.USER_CODE "USER_CODE", R.ID "ID", A.STUDY_CODE "STUDY_CODE"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_USER_REGISTER R
    ON A.USER_CODE = R.USER_CODE;
--     + 조회 시 스터디코드 추가할 것
--WHERE A.STUDY_CODE = 'SO25';



-- 참가자 아이디, 평가항목, 스터디 코드 
-- 참가자 아이디는 MY_STD_MEMBER에서 가져온다. 
-- ○ MYPAGE_ATTENDANCE.jsp(스터디원 평가항목 조회하는 페이지)
-- ○ 뷰 이름 : 

SELECT *
FROM VIEW_BOARD_FREE;

SELECT COUNT(P.PARTI_CODE)
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE 
WHERE A.STUDY_CODE = 'S025';

SELECT *
FROM TBL_STUDY_PARTICIPANT
SA56
SA57
SA60

SELECT *
FROM TBL_STUDY_APPLY;
SA56
SA57
SA58
SA59
SA60

SELECT R.ID "ID" , A.USER_CODE "USER_CODE" ,A.APPLY_CODE
FROM TBL_STUDY_APPLY A JOIN TBL_USER_REGISTER R
ON A.USER_CODE = R.USER_CODE 





SELECT *
FROM TBL_STUDY_ASSESS_ITEM;


-- 스터디원 평가 항목 조회하는 뷰 
CREATE OR REPLACE VIEW ASSESS_ITEM_VIEW
AS
SELECT DISTINCT  T.ITEM "ITEM"
FROM TBL_STUDY_INTERASSESS I JOIN TBL_STUDY_ASSESS_ITEM T
ON I.ITEM_CODE = T.ITEM_CODE;

--조회 예시
SELECT ITEM
FROM ASSESS_ITEM_VIEW;
--==>>
/*
해당 참가자는 스터디원들을 배려하며 원활한 소통을 위해 노력했나요?
해당 참가자는 과제 등 자신의 할 일을 성실히 수행했나요?
해당 참가자는 스터디 활동에 능동적으로 참여했나요?
*/


--스터디에 참여한 인원 수 조회
CREATE OR REPLACE VIEW VIEW_MEM_CNT
AS
SELECT COUNT(*) AS "CNT" 
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE;
-- WHERE STUDY_CODE = '스터디 코드' 추가하기!!; 

-- 조회 예시
SELECT COUNT(*) AS "CNT" 
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
WHERE A.STUDY_CODE='SO5';
--==>> 2


-- (내가)평가해야하는 사람의 ID 조회하는 뷰 
CREATE OR REPLACE VIEW ASSESSED_MEM_VIEW
AS
SELECT R.ID "ID", A.STUDY_CODE "STUDY_CODE"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_USER_REGISTER R
    ON A.USER_CODE = R.USER_CODE;
-- WHERE A.STUDY_CODE = 'SO5' AND ID NOT IN('나의 아이디'); --> 추가할 부분
-- 나를 제외한 사람 조회. 

-- 조회 예시
SELECT ID, STUDY_CODE 
FROM ASSESSED_MEM_VIEW
WHERE STUDY_CODE = 'SO24' AND ID NOT IN('phi11');
--               스터디코드              내 아이디
--==>>hsm66



SELECT *
FROM STD_DETAIL_VIEW
WHERE (SYSDATE > START_DATE AND SYSDATE < END_DATE); 
SO9
SO25
SO5
SO24


DESC TBL_STUDY_CANCEL;
SELECT C.CALCEN_CODE "CANCEL_CODE", A.STUDY_CODE "STUDY_CODE", A.USER_CODE "USER_CODE"
FROM TBL_STUDY_CANCEL C JOIN TBL_STUDY_APPLY A
ON C.APPLY_CODE = A.APPLY_CODE 

AND STUDY_CODE NOT IN (SELECT STUDY_CODE FROM TBL_STUDY_CANCEL);


-- 내가 참가한 스터디의 리더 아이디 가져오기
-- 회원가입 스터디개설 , 스터디 참가, 스터디 진행,  
DROP VIEW STD_LEADER_ID_VIEW;

CREATE OR REPLACE VIEW VIEW_STUDY_LEADER_ID
AS
SELECT A.STUDY_CODE "STUDY_CODE" , R.ID "ID" ,A.USER_CODE "USER_CODE" , A.APPLY_CODE 
    , CASE WHEN A.POSITION_CODE  = 'SP1' THEN 'LEADER' ELSE 'MEMBER' END AS "POSITION"
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_USER_REGISTER R
    ON A.USER_CODE = R.USER_CODE
        JOIN TBL_STUDY_OPEN O
        ON O.STUDY_CODE = A.STUDY_CODE;
-- View STD_LEADER_ID_VIEW이(가) 생성되었습니다.

SELECT *
FROM VIEW_STUDY_LEADER_ID
WHERE POSITION ='LEADER'
AND STUDY_CODE = 'SO24';
/*
STUDY_CODE      ID       USER_CODE  POSITION
============================================
SO4             phi11     UC1       LEADER
*/
    
--
--CREATE TABLE STUDENT
--(ID NUMBER
--,NAME VARCHAR2(20)
--,TEL VARCHAR2(40)
--);
--
--INSERT INTO STUDENT VALUES(1,'테스트','010-2222-2222');
--drop table student;



-- 종료된 스터디 개수 

SELECT COUNT(*)
FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A
ON P.APPLY_CODE = A.APPLY_CODE
    JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
       LEFT JOIN TBL_USER_REGISTER R
        ON A.USER_CODE = R.USER_CODE 
            JOIN TBL_LOC_MC L
            ON O.LOC_MC_CODE = L.LOC_MC_CODE 
WHERE (SYSDATE >O.END_DATE)
AND R.ID = 'phi11';


SELECT *
FROM VIEW_STUDY_END
ORDER BY RNUM;