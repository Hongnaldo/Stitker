
--○ 정보 공유 게시판 추천수 상위 5개
CREATE OR REPLACE VIEW VIEW_INFORM_RANK5
AS
SELECT A.REC1 AS REC, A.POST_CODE AS POSTCODE, A.USER_CODE AS USERCODE, A.WRITE_DATE AS WRITEDATE, A.HITCOUNT, A.TITLE, A.CONTENT
    , A.INTEREST_MC_CODE AS INTERMCCODE, B.ID AS WRITER
FROM
(
    SELECT R.REC1,B.POST_CODE, B.USER_CODE, B.WRITE_DATE, B.HITCOUNT, B.TITLE, B.CONTENT, B.INTEREST_MC_CODE
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
SELECT REC, POSTCODE, USERCODE, WRITEDATE, HITCOUNT, TITLE, CONTENT, INTERMCCODE, WRITER
FROM VIEW_INFORM_RANK5;
--==>>
/*
5	2021-01-09	0	오라클 트리거란?	 개요 테이블에 대한 이벤트를 자동으로 실행해 주는 것	phi11	박혜인
1	2021-01-09	0	맛있는 고구마 있어요	 해남 고구마 팔아요	                                khj77	김호진
*/







--○ 스터디 후기 추천수 상위 3개
CREATE OR REPLACE VIEW VIEW_STDREVIEW_RANK3
AS
SELECT V.POST_CODE AS POSTCODE, V.WRITE_DATE AS WRITEDATE, V.REC1 AS REC, V.HITCOUNT AS HITCOUNT
    , V.TITLE AS TITLE, V.CONTENT AS CONTENT, U.ID AS WRITER, V.INTEREST_MC_CODE AS INTERMCCODE, A.STUDY_CODE AS STUDYCODE
FROM 
(
    SELECT R.REC1, SR.POST_CODE, SR.PARTI_CODE, SR.WRITE_DATE, SR.HITCOUNT, SR.TITLE
         , CASE WHEN LENGTH(CONTENT) >= 58
                THEN SUBSTR(SR.CONTENT,0, 58)||' ..'
                ELSE CONTENT
                END AS CONTENT, SR.INTEREST_MC_CODE
    FROM
    (
        SELECT COUNT(*) REC1, POST_CODE
        FROM TBL_REC_STUDYREVIEW
        WHERE REC_CHECK = 1
        GROUP BY POST_CODE
        ORDER BY REC1 DESC
    ) R, TBL_BOARD_STUDYREVIEW SR
    WHERE ROWNUM<=3 AND R.POST_CODE = SR.POST_CODE
) V, TBL_STUDY_PARTICIPANT P, TBL_STUDY_APPLY A, TBL_USER_REGISTER U
WHERE V.PARTI_CODE = P.PARTI_CODE
  AND P.APPLY_CODE = A.APPLY_CODE
  AND A.USER_CODE = U.USER_CODE;
-- 조회 예시



SELECT *
FROM VIEW_STDREVIEW_RANK3;
--==>>
/*
6	2021-01-10	0	정처기 준비 스터디 완	        필기 합격했어요	        yhj22	윤홍준
5	2021-01-10	0	카카오 면접 준비 스터디 후기	열심히 해서 전원 합격	phi11	박혜인
*/



-- 스터디 개설 페이지 모집중인 스터디중 조회수 

CREATE OR REPLACE VIEW VIEW_HIT_STUDY
AS
SELECT ROWNUM AS CNT, STUDYCODE, USERCODE, WRITEDATE, HITCOUNT
     , CASE WHEN LENGTH(TITLE) >= 15 
            THEN SUBSTR(TITLE,0,15)||'..'
            ELSE TITLE
       END AS TITLE
     , CASE WHEN LENGTH(CONTENT) >= 58 
            THEN SUBSTR(CONTENT,0,58)||'..'
            ELSE CONTENT
       END AS CONTENT
    , STUDYTYPECODE, STUDYTYPE, INTERMCCODE, INTERMC, LOCMCCODE, LOCMC
    , STARTDATE, ENDDATE, CLOSEDATE
FROM
(
    SELECT STUDY_CODE AS STUDYCODE, USER_CODE AS USERCODE, WRITE_DATE AS WRITEDATE, HITCOUNT
        , S.STUDY_NAME AS TITLE, S.STUDY_DESC AS CONTENT
        , S.STUDY_TYPE_CODE AS STUDYTYPECODE, STUDY_TYPE AS STUDYTYPE
        , S.INTEREST_MC_CODE AS INTERMCCODE, INTEREST_MC AS INTERMC
        , S.LOC_MC_CODE AS LOCMCCODE, LOC_MC AS LOCMC
        , S.START_DATE AS STARTDATE, S.END_DATE AS ENDDATE
        , S.CLOSE_DATE AS CLOSEDATE
    FROM TBL_STUDY_OPEN S, TBL_STUDY_TYPE T, TBL_INTEREST_MC M, TBL_LOC_MC L
    WHERE S.STUDY_TYPE_CODE = T.STUDY_TYPE_CODE
      AND S.INTEREST_MC_CODE = M.INTEREST_MC_CODE
      AND S.LOC_MC_CODE = L.LOC_MC_CODE
      AND S.CLOSE_DATE < SYSDATE
    ORDER BY HITCOUNT
)
WHERE ROWNUM<=3;


CREATE OR REPLACE VIEW VIEW_INTERSTUDY_RANK3
AS
SELECT ROWNUM AS CNT, STUDYCODE, U.USER_CODE AS USERCODE, WRITEDATE, HITCOUNT
     , CASE WHEN LENGTH(TITLE) >= 15 
            THEN SUBSTR(TITLE,0,15)||'..'
            ELSE TITLE
       END AS TITLE
     , CASE WHEN LENGTH(CONTENT) >= 58 
            THEN SUBSTR(CONTENT,0,58)||'..'
            ELSE CONTENT
       END AS CONTENT
    , STUDYTYPECODE, STUDYTYPE, INTERMCCODE, INTERMC, LOCMCCODE, LOCMC
    , STARTDATE, ENDDATE, CLOSEDATE
FROM
(
    SELECT STUDY_CODE AS STUDYCODE, USER_CODE AS USERCODE, WRITE_DATE AS WRITEDATE, HITCOUNT
        , S.STUDY_NAME AS TITLE, S.STUDY_DESC AS CONTENT
        , S.STUDY_TYPE_CODE AS STUDYTYPECODE, STUDY_TYPE AS STUDYTYPE
        , S.INTEREST_MC_CODE AS INTERMCCODE, INTEREST_MC AS INTERMC
        , S.LOC_MC_CODE AS LOCMCCODE, LOC_MC AS LOCMC
        , S.START_DATE AS STARTDATE, S.END_DATE AS ENDDATE
        , S.CLOSE_DATE AS CLOSEDATE
    FROM TBL_STUDY_OPEN S, TBL_STUDY_TYPE T, TBL_INTEREST_MC M, TBL_LOC_MC L
    WHERE S.STUDY_TYPE_CODE = T.STUDY_TYPE_CODE
      AND S.INTEREST_MC_CODE = M.INTEREST_MC_CODE
      AND S.LOC_MC_CODE = L.LOC_MC_CODE
      AND S.CLOSE_DATE < SYSDATE
    ORDER BY HITCOUNT
) A, TBL_USER_REGISTER U
WHERE A.INTERMCCODE = U.INTEREST_MC_CODE;

SELECT ROWNUM AS CNT, STUDYCODE, USERCODE, TITLE, CONTENT, INTERMC
FROM VIEW_INTERSTUDY_RANK3
WHERE USERCODE = 'UC2'
  AND ROWNUM<=3;

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

-- 번호, 스터디명, 스터디리더, 스터디리더등급, 기간, 요일,지역, 상태
-- 스터디리더, 리더등급
-- MEETDAY 입력 안된 스터디들은 안나옴.

-- STUDY_CODE, STUDY_NAME, PERIOD(기간), LOCATION, WEEKDAY, STATE(상태) 조회함.
CREATE OR REPLACE VIEW VIEW_STUDYLIST
AS
SELECT S.STUDY_CODE, S.STUDY_NAME, (S.START_DATE||' ~ '||S.END_DATE) AS PERIOD
    , L.LOC_MC AS LOCATION, LISTAGG(W.WEEKDAY, ',') WITHIN GROUP (ORDER BY W.WEEKDAY_CODE) WEEKDAY
    , CASE WHEN SYSDATE > S.CLOSE_DATE AND SYSDATE < S.START_DATE THEN '마감'
            WHEN SYSDATE < S.CLOSE_DATE THEN '모집중'
            WHEN SYSDATE > S.START_DATE THEN '진행중'
            WHEN SYSDATE > S.END_DATE THEN '종료'
        ELSE '-1'
        END "STATE", S.CLOSE_DATE
FROM TBL_STUDY_OPEN S, TBL_LOC_MC L, TBL_STUDY_MEETDAY M, TBL_WEEKDAY W
WHERE S.LOC_MC_CODE = L.LOC_MC_CODE
  AND S.STUDY_CODE = M.STUDY_CODE
  AND M.WEEKDAY_CODE = W.WEEKDAY_CODE
GROUP BY S.STUDY_CODE, S.STUDY_NAME, S.END_DATE, S.START_DATE, L.LOC_MC, S.CLOSE_DATE;


-- 조회 예
SELECT *
FROM VIEW_STUDYLIST;
--==>
/*
SO4	카카오톡 개발자 공채 면접 준비	2020-12-16 ~ 2021-01-12	은평구/서대문구/마포구	월,수	진행중	2020-12-16
SO5	정보처리기사 자격증 취득 스터디	2021-01-04 ~ 2021-01-18	종로구/중구/용산구	화	진행중	2021-01-04
SO6	@ㄷh박ㄴr는 ㅋrㅈi노ㅂr다2ya기@	2021-01-18 ~ 2021-02-01	도봉구/강북구/성북구/노원구	목,금	모집중	2021-01-18
SO20	에러좀그만	2021-01-26 ~ 2021-02-10	은평구/서대문구/마포구	일	모집중	2021-01-24
*/
