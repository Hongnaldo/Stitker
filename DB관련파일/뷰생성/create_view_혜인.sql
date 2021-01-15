-- * 트리거 안에 인서트 할 일 있으면 프로시저 불러서 사용(안 그러면 점수 깎이거나 그런 것들이 안 됨)


--○ VIEW 생성(IT기술정보공유 게시판 리스트, 상세페이지 조회)
--   IT기술정보공유 테이블, 관심분야 중분류 카테고리 테이블
CREATE OR REPLACE VIEW BOARD_INFORM_VIEW
AS
SELECT T.POST_CODE, T.USER_CODE, T.WRITE_DATE, T.HITCOUNT, T.TITLE, T.CONTENT
     , T.REC, T.NOTREC, T.INTEREST_MC
FROM 
(SELECT BI.POST_CODE AS POST_CODE, BI.USER_CODE AS USER_CODE, BI.WRITE_DATE AS WRITE_DATE
     , BI.HITCOUNT AS HITCOUNT, BI.TITLE AS TITLE
     , (SELECT COUNT(*)
        FROM TBL_REC_INFORM
        WHERE REC_CHECK = 1 AND POST_CODE = BI.POST_CODE) AS REC
     , (SELECT COUNT(*)
         FROM TBL_REC_INFORM
        WHERE REC_CHECK = 2 AND POST_CODE = BI.POST_CODE) AS NOTREC
     , BI.INTEREST_MC_CODE AS INTEREST_MC_CODE
     , (SELECT INTEREST_MC
        FROM TBL_INTEREST_MC
        WHERE INTEREST_MC_CODE = BI.INTEREST_MC_CODE) AS INTEREST_MC
     , BI.CONTENT "CONTENT"
FROM TBL_BOARD_INFORM BI 
) T;


--○ VIEW 생성(면접/코딩테스트 게시판 리스트, 상사페이지 조회)
--   면접/코딩테스트 테이블, 관심분야 중분류 카테고리 테이블
CREATE OR REPLACE VIEW BOARD_INTERVIEW_VIEW
AS
SELECT T.POST_CODE, T.USER_CODE, T.WRITE_DATE, T.HITCOUNT, T.TITLE, T.CONTENT
    , T.REC, T.NOTREC, T.INTEREST_MC
FROM 
(SELECT BV.POST_CODE AS POST_CODE, BV.USER_CODE AS USER_CODE, BV.WRITE_DATE AS WRITE_DATE
     , BV.HITCOUNT AS HITCOUNT, BV.TITLE AS TITLE, BV.CONTENT AS CONTENT
     , (SELECT COUNT(*)
        FROM TBL_REC_INTERVIEW
        WHERE REC_CHECK = 1 AND POST_CODE = BV.POST_CODE) AS REC
     , (SELECT COUNT(*)
         FROM TBL_REC_INTERVIEW
        WHERE REC_CHECK = 2 AND POST_CODE = BV.POST_CODE) AS NOTREC
     , BV.INTEREST_MC_CODE AS INTEREST_MC_CODE
     , (SELECT INTEREST_MC
        FROM TBL_INTEREST_MC
        WHERE INTEREST_MC_CODE = BV.INTEREST_MC_CODE) AS INTEREST_MC
FROM TBL_BOARD_INTERVIEW BV 
) T;

--○ VIEW 생성(세미나 및 공모전 게시판 리스트)
--   세미나 및 공모전 테이블, 세미나 말머리 테이블
CREATE OR REPLACE VIEW BOARD_SEMINAR_VIEW
AS
SELECT T.POST_CODE, T.USER_CODE, T.WRITE_DATE, T.HITCOUNT, T.TITLE, T.CONTENT
     , T.REC, T.NOTREC, T.SEMINAR_CTG
FROM 
(SELECT BS.POST_CODE AS POST_CODE, BS.USER_CODE AS USER_CODE, BS.WRITE_DATE AS WRITE_DATE
     , BS.HITCOUNT AS HITCOUNT, BS.TITLE AS TITLE, BS.CONTENT AS CONTENT
     , (SELECT COUNT(*)
        FROM TBL_REC_SEMINAR
        WHERE REC_CHECK = 1 AND POST_CODE = BS.POST_CODE) AS REC
     , (SELECT COUNT(*)
         FROM TBL_REC_SEMINAR
        WHERE REC_CHECK = 2 AND POST_CODE = BS.POST_CODE) AS NOTREC
     , BS.SEMINAR_CATEGORY_CODE AS SEMINAR_CTG_CODE
     , (SELECT SEMINAR_CATEGORY
        FROM TBL_SEMINAR_CATEGORY
        WHERE SEMINAR_CATEGORY_CODE = BS.SEMINAR_CATEGORY_CODE) AS SEMINAR_CTG
FROM TBL_BOARD_SEMINAR BS 
) T;
    
--○ VIEW 생성(Q&A 게시판 리스트, 상세페이지 조회)
--   QUSTION테이블, ANSWER 테이블, 관심분야 중분류 카테고리 테이블
CREATE OR REPLACE VIEW BOARD_QUESTION_VIEW
AS
SELECT T.QPOST_CODE, T.QUSER_CODE, T.QWRITE_DATE, T.QHITCOUNT, T.QTITLE, T.QCONTENT
     , T.QREC, T.QNOTREC, T.INTEREST_MC, T.APOST_CODE, T.AUSER_CODE, T.AWRITE_DATE
     , T.AHITCOUNT, T.ATITLE, T.ACONTENT, T.AREC, T.ANOTREC
FROM 
(SELECT BQ.POST_CODE AS QPOST_CODE, BQ.USER_CODE AS QUSER_CODE, BQ.WRITE_DATE AS QWRITE_DATE
     , BQ.HITCOUNT AS QHITCOUNT, BQ.TITLE AS QTITLE, BQ.CONTENT AS QCONTENT
     , BA.POST_CODE AS APOST_CODE, BA.USER_CODE AS AUSER_CODE, BA.WRITE_DATE AS AWRITE_DATE
     , BA.HITCOUNT AS AHITCOUNT, BA.TITLE AS ATITLE, BA.CONTENT AS ACONTENT
     , (SELECT COUNT(*)
        FROM TBL_REC_QUESTION
        WHERE REC_CHECK = 1 AND POST_CODE = BQ.POST_CODE) AS QREC
     , (SELECT COUNT(*)
         FROM TBL_REC_QUESTION
        WHERE REC_CHECK = 2 AND POST_CODE = BQ.POST_CODE) AS QNOTREC
     , (SELECT COUNT(*)
        FROM TBL_REC_ANSWER
        WHERE REC_CHECK = 1 AND POST_CODE = BA.POST_CODE) AS AREC
     , (SELECT COUNT(*)
         FROM TBL_REC_ANSWER
        WHERE REC_CHECK = 2 AND POST_CODE = BA.POST_CODE) AS ANOTREC
     , BQ.INTEREST_MC_CODE "INTEREST_MC_CODE" 
     , (SELECT INTEREST_MC
        FROM TBL_INTEREST_MC
        WHERE INTEREST_MC_CODE = BQ.INTEREST_MC_CODE) AS INTEREST_MC
FROM TBL_BOARD_QUESTION BQ FULL OUTER JOIN TBL_BOARD_ANSWER BA
ON BQ.POST_CODE = BA.QPOST_CODE
) T;
        
            
--○ VIEW 생성(스터디리뷰 게시판 리스트, 상세페이지 조회)
--   스터디리뷰 테이블, 관심분야 중분류 카테고리 테이블
CREATE OR REPLACE VIEW BOARD_STUDYREVIEW_VIEW
AS
SELECT T.POST_CODE, T.PARTI_CODE, T.WRITE_DATE, T.HITCOUNT, T.TITLE, T.CONTENT
     , T.REC, T.NOTREC, T.INTEREST_MC
FROM
(SELECT BR.POST_CODE AS POST_CODE, BR.PARTI_CODE AS PARTI_CODE, BR.WRITE_DATE AS WRITE_DATE
     , BR.HITCOUNT AS HITCOUNT, BR.TITLE AS TITLE, BR.CONTENT AS CONTENT
     , (SELECT COUNT(*)
        FROM TBL_REC_STUDYREVIEW
        WHERE REC_CHECK = 1 AND POST_CODE = BR.POST_CODE) AS REC
     , (SELECT COUNT(*)
         FROM TBL_REC_STUDYREVIEW
        WHERE REC_CHECK = 2 AND POST_CODE = BR.POST_CODE) AS NOTREC
     , BR.INTEREST_MC_CODE AS INTEREST_MC_CODE
     , (SELECT INTEREST_MC
        FROM TBL_INTEREST_MC
        WHERE INTEREST_MC_CODE = BR.INTEREST_MC_CODE) AS INTEREST_MC
FROM TBL_BOARD_STUDYREVIEW BR 
) T;

  
--○ VIEW 생성(자유게시판 리스트)
--   자유게시판 테이블, 자유게시판 추천비추천 테이블
CREATE OR REPLACE VIEW BOARD_FREE_VIEW
AS
SELECT T.POST_CODE, T.USER_CODE, T.WRITE_DATE, T.HITCOUNT, T.TITLE, T.CONTENT
     , T.REC, T.NOTREC
FROM
(SELECT BF.POST_CODE AS POST_CODE, BF.USER_CODE AS USER_CODE, BF.WRITE_DATE AS WRITE_DATE
     , BF.HITCOUNT AS HITCOUNT, BF.TITLE AS TITLE, BF.CONTENT AS CONTENT
     , (SELECT COUNT(*)
        FROM TBL_REC_FREE
        WHERE REC_CHECK = 1 AND POST_CODE = BF.POST_CODE) AS REC
     , (SELECT COUNT(*)
         FROM TBL_REC_FREE
        WHERE REC_CHECK = 2 AND POST_CODE = BF.POST_CODE) AS NOTREC
FROM TBL_BOARD_FREE BF
) T;

--○ VIEW 생성(스터디신청확인)
-- 스터디 기본정보
CREATE OR REPLACE VIEW STD_APPLY_CHECK_VIEW
AS
SELECT SO.STUDY_CODE AS STUDY_CODE, SO.USER_CODE AS USER_CODE, SO.STUDY_DESC AS STUDY_DESC
     , (SELECT STUDY_TYPE
        FROM TBL_STUDY_TYPE
        WHERE STUDY_TYPE_CODE = SO.STUDY_TYPE_CODE) AS STUDY_TYPE
     , SO.START_DATE AS START_DATE, SO.END_DATE AS END_DATE
     , (SELECT MEMNUM
        FROM TBL_MEMNUM
        WHERE MEMNUM_CODE = SO.MIN_MEM_CODE) AS MIN_MEM
     , (SELECT MEMNUM
        FROM TBL_MEMNUM
        WHERE MEMNUM_CODE = SO.MAX_MEM_CODE) AS MAX_MEM
     , SO.STUDY_NAME AS STUDY_NAME
     , (SELECT RANK 
        FROM TBL_USER_RANK
        WHERE RANK_CODE = SO.MIN_RANK) AS MIN_RANK
     , SO.CLOSE_DATE AS CLOSE_DATE
     , (SELECT INTEREST_MC 
        FROM TBL_INTEREST_MC 
        WHERE INTEREST_MC_CODE = SO.INTEREST_MC_CODE) AS INTEREST_MC
     , (SELECT LOC_MC 
        FROM TBL_LOC_MC 
        WHERE LOC_MC_CODE = SO.LOC_MC_CODE) AS LOC_MC
FROM TBL_STUDY_OPEN SO;


--○ 스터디 상세 조회 뷰 
-- 스터디명, 지역, 작성일, 스터디유형,관심분야,시작일,종료일,최소인원수,최대인원수,참여최소등급, 모집마감임, 스터디 설명
CREATE OR REPLACE VIEW STD_DETAIL_VIEW
AS
SELECT SO.STUDY_CODE AS STUDY_CODE, SO.USER_CODE AS USER_CODE, SO.STUDY_DESC AS STUDY_DESC
     , (SELECT STUDY_TYPE
        FROM TBL_STUDY_TYPE
        WHERE STUDY_TYPE_CODE = SO.STUDY_TYPE_CODE) AS STUDY_TYPE
     , SO.START_DATE AS START_DATE, SO.END_DATE AS END_DATE
     , (SELECT MEMNUM
        FROM TBL_MEMNUM
        WHERE MEMNUM_CODE = SO.MIN_MEM_CODE) AS MIN_MEM
     , (SELECT MEMNUM
        FROM TBL_MEMNUM
        WHERE MEMNUM_CODE = SO.MAX_MEM_CODE) AS MAX_MEM
     , SO.STUDY_NAME AS STUDY_NAME
     , (SELECT RANK 
        FROM TBL_USER_RANK
        WHERE RANK_CODE = SO.MIN_RANK) AS MIN_RANK
     , SO.CLOSE_DATE AS CLOSE_DATE
     , (SELECT INTEREST_MC 
        FROM TBL_INTEREST_MC 
        WHERE INTEREST_MC_CODE = SO.INTEREST_MC_CODE) AS INTEREST_MC
     , (SELECT LOC_MC 
        FROM TBL_LOC_MC 
        WHERE LOC_MC_CODE = SO.LOC_MC_CODE) AS LOC_MC
FROM TBL_STUDY_OPEN SO;


--○ 스터디 진행요일 및 시간
-- 스터디 코드, 스터디 진행요일-시작시간, 종료시간
CREATE OR REPLACE VIEW STD_MEETDAY_VIEW
AS
SELECT SM.STUDY_CODE AS STUDY_CODE, (SELECT WEEKDAY
                                     FROM TBL_WEEKDAY
                                     WHERE WEEKDAY_CODE = SM.WEEKDAY_CODE) AS WEEKDAY
     , SM.START_TIME AS START_TIME, SM.END_TIME AS END_TIME 
FROM TBL_STUDY_MEETDAY SM JOIN TBL_WEEKDAY WD
ON SM.WEEKDAY_CODE = WD.WEEKDAY_CODE;


