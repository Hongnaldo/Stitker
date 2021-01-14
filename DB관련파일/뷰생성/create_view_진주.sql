
--○ 정보 공유 게시판 추천수 상위 5개
CREATE OR REPLACE VIEW VIEW_INFORM_RANK5
AS
SELECT A.REC1, A.WRITE_DATE, A.HITCOUNT, A.TITLE, A.CONTENT, B.ID, B.NAME
FROM
(
    SELECT R.REC1, B.USER_CODE, B.WRITE_DATE, B.HITCOUNT, B.TITLE, B.CONTENT
    FROM
    (
        SELECT COUNT(*) REC1, POST_CODE
        FROM TBL_REC_INFORM
        WHERE REC_CHECK =1
        GROUP BY POST_CODE
        ORDER BY REC1 DESC 
    ) R, TBL_BOARD_INFORM B
    WHERE ROWNUM<=5 AND R.POST_CODE = B.POST_CODE
) A, TBL_USER_REGISTER B
WHERE A.USER_CODE = B.USER_CODE;

-- 조회 예시
SELECT *
FROM VIEW_INFORM_RANK5;
--==>>
/*
5	2021-01-09	0	오라클 트리거란?	 개요 테이블에 대한 이벤트를 자동으로 실행해 주는 것	phi11	박혜인
1	2021-01-09	0	맛있는 고구마 있어요	 해남 고구마 팔아요	                                khj77	김호진
*/



--○ 스터디 후기 추천수 상위 5개
CREATE OR REPLACE VIEW VIEW_STDREVIEW_RANK5
AS
SELECT V.REC1, V.WRITE_DATE, V.HITCOUNT, V.TITLE, V.CONTENT, U.ID, U.NAME
FROM 
(
    SELECT R.REC1, SR.POST_CODE, SR.PARTI_CODE, SR.WRITE_DATE, SR.HITCOUNT, SR.TITLE, SR.CONTENT
    FROM
    (
        SELECT COUNT(*) REC1, POST_CODE
        FROM TBL_REC_STUDYREVIEW
        WHERE REC_CHECK = 1
        GROUP BY POST_CODE
        ORDER BY REC1 DESC
    ) R, TBL_BOARD_STUDYREVIEW SR
    WHERE ROWNUM<=5 AND R.POST_CODE = SR.POST_CODE
) V, TBL_STUDY_PARTICIPANT P, TBL_STUDY_APPLY A, TBL_USER_REGISTER U
WHERE V.PARTI_CODE = P.PARTI_CODE
  AND P.APPLY_CODE = A.APPLY_CODE
  AND A.USER_CODE = U.USER_CODE;
-- 조회 예시
SELECT *
FROM VIEW_STDREVIEW_RANK5;
--==>>
/*
6	2021-01-10	0	정처기 준비 스터디 완	        필기 합격했어요	        yhj22	윤홍준
5	2021-01-10	0	카카오 면접 준비 스터디 후기	열심히 해서 전원 합격	phi11	박혜인
*/


--○ 누적 스터디 개설 수
CREATE OR REPLACE VIEW VIEW_OPEN_STUDY_CNT
AS
SELECT COUNT(*) AS OPEN_STUDY_CNT
FROM TBL_STUDY_OPEN;
-- 조회 예시
SELECT *
FROM VIEW_OPEN_STUDY_CNT;
--==>>
/*
11
*/


--○ 스터디 평균 평점
CREATE OR REPLACE VIEW VIEW_STD_ASSESS_AVG
AS
SELECT AVG(SCORE) AS STD_ASSESS_AVG
FROM TBL_STUDY_ASSESS;
-- 조회 예시
SELECT *
FROM VIEW_STD_ASSESS_AVG;
--==>>
/*
4.5
*/



--○ 누적 스터디원 수
CREATE OR REPLACE VIEW VIEW_STD_MEM_CNT
AS
SELECT COUNT(*) AS STUDY_MEM_CNT
FROM TBL_STUDY_PARTICIPANT;
-- 조회 예시
SELECT *
FROM VIEW_STD_MEM_CNT;
--==>>
/*
15
*/
 S.STUDY_CODE, S.USER_CODE AS WRITER , S.WRITE_DATE, S.HITCOUNT, S.STUDY_TYPE_CODE, S.INTEREST_MC_CODE, S.START_DATE, S.END_DATE, S.STUDY_NAME, L.LOC_MC;
 
-- 번호, 스터디명, 스터디리더, 스터디리더등급, 기간, 요일,지역, 상태
-- 스터디리더, 리더등급
-- MEETDAY 입력 안된 스터디들은 안나옴.

-- STUDY_CODE, STUDY_NAME, 기간, 지역, 요일, 상태
CREATE OR REPLACE VIEW VIEW_STUDYLIST
AS
SELECT S.STUDY_CODE, S.STUDY_NAME, (S.START_DATE||' ~ '||S.END_DATE) AS 기간
    , L.LOC_MC AS 지역, LISTAGG(W.WEEKDAY, ',') WITHIN GROUP (ORDER BY W.WEEKDAY_CODE) WEEKDAY
    , CASE WHEN SYSDATE > S.CLOSE_DATE AND SYSDATE < S.START_DATE THEN '마감'
            WHEN SYSDATE < S.CLOSE_DATE THEN '모집중'
            WHEN SYSDATE > S.START_DATE THEN '진행중'
            WHEN SYSDATE > S.END_DATE THEN '종료'
        ELSE '-1'
        END "상태", S.CLOSE_DATE
FROM TBL_STUDY_OPEN S, TBL_LOC_MC L, TBL_STUDY_MEETDAY M, TBL_WEEKDAY W
WHERE S.LOC_MC_CODE = L.LOC_MC_CODE
  AND S.STUDY_CODE = M.STUDY_CODE
  AND M.WEEKDAY_CODE = W.WEEKDAY_CODE
GROUP BY S.STUDY_CODE, S.STUDY_NAME, S.END_DATE, S.START_DATE, L.LOC_MC, S.CLOSE_DATE;


SELECT STUDY_CODE, USER_CODE
FROM TBL_STUDY_APPLY
WHERE POSITION_CODE = 'SP1'
  AND STUDY_CODE NOT IN (SELECT STUDY_CODE
FROM TBL_STUDY_CANCEL C, TBL_STUDY_APPLY A
WHERE C.APPLY_CODE = A.APPLY_CODE
  AND A.POSITION_CODE = 'SP1')
 ;
--==>> 
/*
SO24	UC3
SO25	UC5
SO9	    UC3
*/


SELECT *
FROM VIEW_STUDYLIST;

--==>
/*
SO4	카카오톡 개발자 공채 면접 준비	2020-12-16 ~ 2021-01-12	은평구/서대문구/마포구	월,수	진행중	2020-12-16
SO5	정보처리기사 자격증 취득 스터디	2021-01-04 ~ 2021-01-18	종로구/중구/용산구	화	진행중	2021-01-04
SO6	@ㄷh박ㄴr는 ㅋrㅈi노ㅂr다2ya기@	2021-01-18 ~ 2021-02-01	도봉구/강북구/성북구/노원구	목,금	모집중	2021-01-18
SO20	에러좀그만	2021-01-26 ~ 2021-02-10	은평구/서대문구/마포구	일	모집중	2021-01-24
*/
SELECT *
FROM TBL_STUDY_APPLY
WHERE STUDY_CODE = 'SO6';

-- 수민이가 준 요일 한 컬럼에 보이게 하는 코드
SELECT O.STUDY_CODE, O.STUDY_NAME, , LISTAGG(W.WEEKDAY, ',') WITHIN GROUP (ORDER BY W.WEEKDAY_CODE) WEEKDAY
FROM TBL_STUDY_OPEN O JOIN TBL_STUDY_MEETDAY M
  ON O.STUDY_CODE = M.STUDY_CODE
    JOIN TBL_WEEKDAY W
      ON W.WEEKDAY_CODE = M.WEEKDAY_CODE
GROUP BY O.STUDY_CODE, O.STUDY_NAME, O.END_DATE, O.START_DATE;




-- V_NEW_LEADER 
SELECT USER_CODE  
FROM ( SELECT USER_CODE
       FROM TBL_STUDY_APPLY
       WHERE POSITION_CODE = 'SP1'
       GROUP BY STUDY_CODE )
WHERE USER_CODE NOT IN (   -- 신청테이블에 있지만 취소한 사람들의 USER_CODE 는 제외
                        SELECT distinct A.USER_CODE
                        FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
                        WHERE A.APPLY_CODE IN ( SELECT APPLY_CODE
                                                FROM TBL_STUDY_CANCEL)
                          AND C.APPLY_CODE IN (SELECT APPLY_CODE
                                                FROM TBL_STUDY_APPLY)
                       );
       SELECT *
       FROM  TBL_STUDY_APPLY;
       
       
       SELECT STUDY_CODE, USER_CODE
       FROM TBL_STUDY_APPLY
       WHERE POSITION_CODE = 'SP1'
         AND USER_CODE NOT IN 
(   -- 신청테이블에 있지만 취소한 사람들의 USER_CODE 는 제외
    SELECT distinct A.USER_CODE
    FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
    WHERE A.APPLY_CODE IN ( SELECT APPLY_CODE
                            FROM TBL_STUDY_CANCEL)
      AND C.APPLY_CODE IN (SELECT APPLY_CODE
                            FROM TBL_STUDY_APPLY)
) ;
       
     /*
    UC7
UC13
UC3
UC1
UC5
UC6
UC2
UC4
     */  
SELECT *
FROM TBL_STUDY_CANCEL;

/*
CC162	SA1	2021-01-12	
CC163	SA5	2021-01-12	
CC164	SA5	2021-01-12	
CC165	SA5	2021-01-12	
CC166	SA5	2021-01-12	
*/

SELECT STUDY_CODE, USER_CODE
FROM TBL_STUDY_APPLY
WHERE POSITION_CODE = 'SP1'
  AND STUDY_CODE NOT IN (SELECT STUDY_CODE
FROM TBL_STUDY_CANCEL C, TBL_STUDY_APPLY A
WHERE C.APPLY_CODE = A.APPLY_CODE
  AND A.POSITION_CODE = 'SP1');
/*
SO5	    UC5ㅇ
SO6	    UC7ㅇ
SO13	UC3ㅇ
SO9	    UC3ㅇ
SO25	UC5ㅇ
SO10	    UC13ㅇ
SO10	    UC5ㅇ
SO4	    UC1 ㅇ
SO24	UC3ㅇ
*/
SELECT *
FROM TBL_STUDY_APPLY
WHERE STUDY_CODE = 'SO25';
--==>>
/*
SA56	SO25	UC3		SP2
SA57	SO25	UC1		SP2
SA58	SO25	UC7		SP2
SA59	SO25	UC2		SP2
SA60	SO25	UC5	2021-01-03	SP1
*/
SELECT *
FROM TBL_STUDY_CANCEL C, TBL_STUDY_APPLY A
WHERE C.APPLY_CODE = A.APPLY_CODE
  AND A.POSITION_CODE = 'SP1';
       
       
       
WHERE ROWNUM=1;


(   -- 신청테이블에 있지만 취소한 사람들의 USER_CODE 는 제외
    SELECT distinct A.USER_CODE, A.STUDY_CODE
    FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
    WHERE A.APPLY_CODE IN ( SELECT APPLY_CODE
                            FROM TBL_STUDY_CANCEL)
      AND C.APPLY_CODE IN (SELECT APPLY_CODE
                            FROM TBL_STUDY_APPLY)
) 


SELECT *
FROM TBL_USER_RANK;



-- P_NEW_LEADER
SELECT USER_CODE INTO P_NEW_LEADER
FROM 
(   SELECT T.USER_CODE, SUM(S.SCORE) AS MAX_SCORE
    FROM 
    ( SELECT A.APPLY_CODE, A.STUDY_CODE, A.USER_CODE, A.POSITION_CODE
      FROM TBL_STUDY_APPLY A, TBL_STUDY_PARTICIPANT P
      WHERE A.APPLY_CODE = P.APPLY_CODE
        AND A.USER_CODE NOT IN (    -- 신청테이블에 있지만 취소한 사람들의 USER_CODE
                                    SELECT USER_CODE
                                    FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
                                    WHERE A.STUDY_CODE =V_STUDY_CODE
                                      AND A.APPLY_CODE IN ( SELECT APPLY_CODE
                                                            FROM TBL_STUDY_CANCEL)
                                      AND C.APPLY_CODE IN (SELECT APPLY_CODE
                                                            FROM TBL_STUDY_APPLY
                                                            WHERE STUDY_CODE =V_STUDY_CODE)
                                )   
    ) T, TBL_SCORE S
    WHERE T.USER_CODE = S.USER_CODE
    GROUP BY T.USER_CODE
    ORDER BY MAX_SCORE DESC
)
WHERE ROWNUM=1;





-- 진행 요일 뷰 : 삭제
CREATE OR REPLACE VIEW VIEW_STD_MEETDAY
AS
SELECT S.STUDY_CODE, W.WEEKDAY 
FROM  TBL_STUDY_OPEN S, TBL_STUDY_MEETDAY M, TBL_WEEKDAY W
WHERE S.STUDY_CODE = M.STUDY_CODE 
  AND M.WEEKDAY_CODE = W.WEEKDAY_CODE
ORDER BY TO_NUMBER(SUBSTR(STUDY_CODE, 3));
-- 조회 예
SELECT WEEKDAY
FROM VIEW_STD_MEETDAY
WHERE STUDY_CODE = 'SO4';


