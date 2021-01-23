--■■■ 뷰(VIEW) 생성 ■■■--
--※SELECT로 먼저 조회한 후 CREATE VIEW 하기

SELECT *
FROM TBL_REPORT_HANDLE_INFORM
UNION ALL
SELECT *
FROM TBL_REPORT_HANDLE_SEMINAR
UNION ALL
SELECT *
FROM TBL_REPORT_HANDLE_INTERVIEW
UNION ALL
SELECT *
FROM TBL_REPORT_HANDLE_FREE
UNION ALL
SELECT *
FROM TBL_REPORT_HANDLE_QUESTION
UNION ALL
SELECT *
FROM TBL_REPORT_HANDLE_ANSWER
UNION ALL
SELECT *
FROM TBL_REPORT_HANDLE_STUDYREVIEW;
		SELECT ID, POST_CODE, TITLE, HANDLE_RESULT, HANDLE_DATE
		FROM VIEW_RH_BOARDLIST
		ORDER BY HANDLE_DATE DESC;
        		SELECT COUNT(*)
		FROM VIEW_RH_BOARDLIST;
        
EXEC PRC_RPT_REG_INFOM_INSERT( 'BI4', 'UC5', '', 'PR1');


SELECT COUNT(*)
FROM VIEW_RH_BOARDLIST
WHERE HANDLE_RESULT IS NULL;

SELECT RNUM, ID, POST_CODE, TITLE, NVL(HANDLE_RESULT,'미처리') HANDLE_RESULT, HANDLE_DATE
FROM VIEW_RH_BOARDLIST
ORDER BY RNUM DESC;

commit;
-- ○ Board_report_list.jsp(각종 게시판 신고처리를 위한 리스트 뷰 - 작성자, 글제목, 내용, 신고처리결과, 신고처리날짜)
-- ○ 뷰 이름 : VIEW_RH_BOARDLIST
CREATE OR REPLACE VIEW VIEW_RH_BOARDLIST
AS
SELECT ROWNUM RNUM, ID, POST_CODE, TITLE, HANDLE_RESULT, HANDLE_DATE
FROM
(
    SELECT ID, POST_CODE, TITLE, HANDLE_RESULT, HANDLE_DATE
    FROM
    (
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_INFORM H JOIN TBL_REPORT_REG_INFORM R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_INFORM B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_USER_REGISTER U 
            ON B.USER_CODE = U.USER_CODE
    UNION ALL
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_INTERVIEW H JOIN TBL_REPORT_REG_INTERVIEW R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_INTERVIEW B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_USER_REGISTER U 
            ON B.USER_CODE = U.USER_CODE
    UNION ALL
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_SEMINAR H JOIN TBL_REPORT_REG_SEMINAR R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_SEMINAR B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_USER_REGISTER U 
            ON B.USER_CODE = U.USER_CODE
    UNION ALL      
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_FREE H JOIN TBL_REPORT_REG_FREE R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_FREE B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_USER_REGISTER U 
            ON B.USER_CODE = U.USER_CODE
    UNION ALL      
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_QUESTION H JOIN TBL_REPORT_REG_QUESTION R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_QUESTION B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_USER_REGISTER U 
            ON B.USER_CODE = U.USER_CODE
    UNION ALL      
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_ANSWER H JOIN TBL_REPORT_REG_ANSWER R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_ANSWER B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_USER_REGISTER U 
            ON B.USER_CODE = U.USER_CODE
    UNION ALL
    SELECT U.ID, B.POST_CODE, B.TITLE, HR.HANDLE_RESULT, H.HANDLE_DATE
    FROM TBL_REPORT_HANDLE_STUDYREVIEW H JOIN TBL_REPORT_REG_STUDYREVIEW R
      ON R.POST_REPORT_CODE = H.POST_REPORT_CODE
        JOIN TBL_BOARD_STUDYREVIEW B
        ON B.POST_CODE = R.POST_CODE
          LEFT JOIN TBL_HANDLE_RESULT HR
          ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_STUDY_PARTICIPANT P
            ON P.PARTI_CODE = B.PARTI_CODE
                JOIN TBL_STUDY_APPLY A
                ON A.APPLY_CODE = P.APPLY_CODE
                    JOIN TBL_USER_REGISTER U 
                    ON A.USER_CODE = U.USER_CODE
    UNION ALL
    SELECT U.ID, B.STUDY_CODE, B.STUDY_NAME, HR.HANDLE_RESULT, H.ACCUSE_HANDLE_DATE
    FROM TBL_STUDY_OPEN B JOIN TBL_STUDY_ACCUSE R
      ON B.STUDY_CODE = R.STUDY_CODE
        JOIN TBL_STUDY_ACCUSE_HANDLE H
        ON R.ACCUSE_CODE = H.ACCUSE_CODE
            LEFT JOIN TBL_HANDLE_RESULT HR
            ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
                JOIN TBL_USER_REGISTER U 
                ON B.USER_CODE = U.USER_CODE
    )
    ORDER BY HANDLE_RESULT, HANDLE_DATE
);

UPDATE TBL_REPORT_HANDLE_INFORM
SET HANDLE_RESULT_CODE = NULL
WHERE REPORT_HANDLE_CODE = 'HI1';

            
--번호신고사유신고자신고일자
SELECT ROWNUM RNUM, POST_REPORT_CTG, REPORT_ID, REPORT_REASON, REPORT_DATE, POST_CODE
FROM VIEW_RH_REPORTLIST
WHERE POST_CODE = 'BI4';

-- ○ Report_detailpage.jsp(각종 게시판 신고처리 상세페이지를 위한 뷰 - 게시물코드, 피신고자, 신고자, 신고일, 카테고리, 기타내용)
-- ○ 뷰 이름 : VIEW_RH_REPORTLIST
CREATE OR REPLACE VIEW VIEW_RH_REPORTLIST
AS
SELECT B.POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_INFORM R JOIN TBL_BOARD_INFORM B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
                JOIN TBL_USER_REGISTER U
                ON U.USER_CODE = R.USER_CODE
UNION ALL
SELECT B.POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_INTERVIEW R JOIN TBL_BOARD_INTERVIEW B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
                JOIN TBL_USER_REGISTER U
                ON U.USER_CODE = R.USER_CODE            
UNION ALL
SELECT B.POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_SEMINAR R JOIN TBL_BOARD_SEMINAR B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
                JOIN TBL_USER_REGISTER U
                ON U.USER_CODE = R.USER_CODE            
UNION ALL
SELECT B.POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_FREE R JOIN TBL_BOARD_FREE B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
                JOIN TBL_USER_REGISTER U
                ON U.USER_CODE = R.USER_CODE            
UNION ALL
SELECT B.POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_QUESTION R JOIN TBL_BOARD_QUESTION B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
                JOIN TBL_USER_REGISTER U
                ON U.USER_CODE = R.USER_CODE            
UNION ALL
SELECT B.POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_ANSWER R JOIN TBL_BOARD_ANSWER B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
                JOIN TBL_USER_REGISTER U
                ON U.USER_CODE = R.USER_CODE            
UNION ALL
SELECT B.POST_CODE, A.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.REPORT_DATE, C.POST_REPORT_CTG, R.REPORT_REASON
FROM TBL_REPORT_REG_STUDYREVIEW R JOIN TBL_BOARD_STUDYREVIEW B
        ON B.POST_CODE = R.POST_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE            
                JOIN TBL_STUDY_PARTICIPANT P
                ON P.PARTI_CODE = B.PARTI_CODE
                    JOIN TBL_STUDY_APPLY A
                    ON A.APPLY_CODE = P.APPLY_CODE
                        JOIN TBL_USER_REGISTER U
                        ON U.USER_CODE = R.USER_CODE                    
UNION ALL
SELECT B.STUDY_CODE AS POST_CODE, B.USER_CODE REPORTED_USER_CODE, U.ID REPORT_ID, R.ACCUSE_DATE AS REPORT_DATE, C.POST_REPORT_CTG, R.ACCUSE_REASON AS REPORT_REASON
FROM TBL_STUDY_ACCUSE R JOIN TBL_STUDY_OPEN B
  ON B.STUDY_CODE = R.STUDY_CODE
    JOIN TBL_POST_REPORT_CTG C
    ON C.POST_REPORT_CTG_CODE = R.POST_REPORT_CTG_CODE
        JOIN TBL_USER_REGISTER U 
        ON R.USER_CODE = U.USER_CODE;

SELECT ROWNUM RNUM, STUDY_NAME,NVL(HANDLE_RESULT,'미처리'), REPORTED_ID, HANDLE_CODE
FROM RH_STUDYMEM_VIEW;

SELECT COUNT(*) AS COUNT
FROM RH_STUDYMEM_VIEW
WHERE HANDLE_RESULT IS NULL;


-- ○ 뷰 이름 : RH_STUDYMEM_VIEW
CREATE OR REPLACE VIEW RH_STUDYMEM_VIEW
AS
SELECT ROWNUM RNUM, STUDY_NAME, REPORTED_ID, REPORT_ID, START_DATE, HANDLE_RESULT, HANDLE_DATE
    , HANDLE_CODE, REPORTED_PARTI_CODE, REPORTED_USER_CODE
FROM
(
    SELECT O.STUDY_NAME, UR2.ID REPORTED_ID, UR.ID REPORT_ID, O.START_DATE
        , HR.MEM_REPORT_HANDLE_RESULT HANDLE_RESULT, H.HANDLE_DATE, H.MEM_REPORT_HANDLE_CODE HANDLE_CODE
        , P2.PARTI_CODE REPORTED_PARTI_CODE, A2.USER_CODE REPORTED_USER_CODE
    FROM TBL_MEM_REPORT_HANDLE H JOIN TBL_MEM_REPORT_REG R
      ON H.MEM_REPORT_REG_CODE = R.MEM_REPORT_REG_CODE
        LEFT JOIN TBL_MEM_REPORT_HANDLE_RESULT HR
        ON HR.MEM_REPORT_HANDLE_RESULT_CODE = H.HANDLE_RESULT
        JOIN TBL_STUDY_PARTICIPANT P
        ON P.PARTI_CODE = R.PARTI_REPORT_CODE
            JOIN TBL_STUDY_PARTICIPANT P2
            ON P2.PARTI_CODE = R.PARTI_REPORTED_CODE
                JOIN TBL_STUDY_APPLY A
                ON A.APPLY_CODE = P.APPLY_CODE
                    JOIN TBL_STUDY_APPLY A2
                    ON P2.APPLY_CODE = A2.APPLY_CODE
                        JOIN TBL_STUDY_OPEN O
                        ON O.STUDY_CODE = A.STUDY_CODE
                            JOIN TBL_USER_REGISTER UR
                            ON A.USER_CODE = UR.USER_CODE
                                JOIN TBL_USER_REGISTER UR2
                                ON A2.USER_CODE = UR2.USER_CODE
    ORDER BY NVL2(HR.MEM_REPORT_HANDLE_RESULT, 0, 1),  H.HANDLE_DATE
)
;


-- ○ Study_report_list.jsp(스터디 신고처리를 위한 뷰 - 개설자, 스터디이름, 내용, 신고처리결과, 신고처리날짜)
-- ○ 뷰 이름 : RH_STUDY_VIEW
CREATE OR REPLACE VIEW RH_STUDY_VIEW
AS
SELECT O.USER_CODE USER_CODE, O.WRITE_DATE, O.STUDY_NAME, O.STUDY_DESC, HR.HANDLE_RESULT, H.ACCUSE_HANDLE_DATE
    , A.ACCUSE_REASON, C.POST_REPORT_CTG
FROM TBL_STUDY_ACCUSE_HANDLE H JOIN TBL_STUDY_ACCUSE A
  ON H.ACCUSE_CODE = H.ACCUSE_CODE
    JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        JOIN TBL_HANDLE_RESULT HR
        ON HR.HANDLE_RESULT_CODE = H.HANDLE_RESULT_CODE
            JOIN TBL_POST_REPORT_CTG C
            ON C.POST_REPORT_CTG_CODE = A.POST_REPORT_CTG_CODE;

SELECT ROWNUM RNUM, STUDY_CODE, STUDY_NAME, REPORT_CTG, REPORT_REASON, REPORT_ID, REPORT_DATE
FROM RH_MEM_REPORTLIST_VIEW
WHERE REPORTED_CODE='PT2';

SELECT *
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_PARTICIPANT P
ON A.APPLY_CODE = P.APPLY_CODE;


-- ○ Report_detailpage.jsp(신고처리에 들어간 스터디원의 신고내역 - 번호, 스터디이름, 신고사유, 피신고자ID, 신고자ID, 신고일자)
-- ○ 뷰 이름 : RH_MEM_REPORTLIST_VIEW
CREATE OR REPLACE VIEW RH_MEM_REPORTLIST_VIEW
AS
SELECT H.MEM_REPORT_HANDLE_CODE HANDLE_CODE, R.MEM_REPORT_REG_CODE REPORT_CODE, O.STUDY_CODE, O.STUDY_NAME
    , HR.MEM_REPORT_HANDLE_RESULT HANDLE_RESULT, P.PARTI_CODE REPORTED_CODE, UR2.ID REPORT_ID, H.HANDLE_DATE
    , C.MEM_REPORT_CTG REPORT_CTG, R.REPORT_REG_REASON REPORT_REASON, R.REPORT_REG_DATE REPORT_DATE
    , UR2.USER_CODE REPORT_USER_CODE
FROM TBL_MEM_REPORT_HANDLE H RIGHT JOIN TBL_MEM_REPORT_REG R
  ON H.MEM_REPORT_REG_CODE = R.MEM_REPORT_REG_CODE
    LEFT JOIN TBL_MEM_REPORT_HANDLE_RESULT HR
    ON HR.MEM_REPORT_HANDLE_RESULT_CODE = H.HANDLE_RESULT
        JOIN TBL_STUDY_PARTICIPANT P
        ON P.PARTI_CODE = R.PARTI_REPORTED_CODE
            JOIN TBL_STUDY_PARTICIPANT P2
            ON P2.PARTI_CODE = R.PARTI_REPORT_CODE
            JOIN TBL_STUDY_APPLY A
            ON P.APPLY_CODE = A.APPLY_CODE
                JOIN TBL_STUDY_APPLY A2
                ON P2.APPLY_CODE = A2.APPLY_CODE
                    JOIN TBL_USER_REGISTER UR
                        ON UR.USER_CODE = A.USER_CODE
                            JOIN TBL_USER_REGISTER UR2
                            ON UR2.USER_CODE = A2.USER_CODE
                                JOIN TBL_STUDY_OPEN O
                                ON O.STUDY_CODE = A.STUDY_CODE
                                    JOIN TBL_MEM_REPORT_CTG C
                                    ON C.MEM_REPORT_CTG_CODE = R.MEM_REPORT_CTG_CODE
ORDER BY HR.MEM_REPORT_HANDLE_RESULT DESC, H.HANDLE_DATE DESC;
                

SELECT N.NOTICE_CODE, N.NOTICE_DATE, N.NOTICE_TITLE, A.ADMIN_ID, N.HITCOUNT, N.NOTICE_CONTENT
FROM TBL_NOTICE N JOIN TBL_ADMIN A
  ON N.ADMIN_CODE = A.ADMIN_CODE;
  
select *
from tbl_notice;

UPDATE TBL_NOTICE
SET HITCOUNT = (HITCOUNT+1)
WHERE NOTICE_CODE = 'NT1';

COMMIT;

ROLLBACK;

INSERT INTO TBL_ASK(ASK_CODE, USER_CODE, ASK_TITLE, ASK_CONTENT, ASK_DATE, ASK_ANSWER, ASK_ANSWER_DATE, ADMIN_CODE)
VALUES('AS'||ASK_SEQ.NEXTVAL, 'UC1', '스터디문의','스터디관련해서 한 요일에 두 번 진행 못하나요?.', SYSDATE-3 , '못합니다.',SYSDATE-2, 'AD1');

INSERT INTO TBL_ASK(ASK_CODE, USER_CODE, ASK_TITLE, ASK_CONTENT, ASK_DATE)
VALUES('AS'||ASK_SEQ.NEXTVAL, 'UC2', '개설문의','개설하려고하는데 개설이 안되는데요?', SYSDATE-2);

INSERT INTO TBL_ASK(ASK_CODE, USER_CODE, ASK_TITLE, ASK_CONTENT, ASK_DATE)
VALUES('AS'||ASK_SEQ.NEXTVAL, 'UC3', '게시판문의','게시판을수정하려는데 안되는데요?', SYSDATE-1);

SELECT *
FROM TBL_ASK;

SELECT *
FROM TBL_NOTICE;

SELECT A.ASK_CODE ASK_CODE, R.ID ID, A.ASK_DATE ASK_DATE, A.ASK_TITLE ASK_TITLE, NVL2(ASK_ANSWER, '답변 대기', '답변 완료')
FROM TBL_ASK A JOIN TBL_USER_REGISTER R
  ON A.USER_CODE = R.USER_CODE
ORDER BY ASK_ANSWER_DATE, ASK_DATE DESC;

SELECT *
FROM TBL_ASK;

--------------------------------------------------------------------------------------------------------------------

-- ○ 계정정지 등록 프로시저를 위한 뷰
-- ○ 뷰 이름 : INSERT_SUSPEND_VIEW
CREATE OR REPLACE VIEW INSERT_SUSPEND_VIEW
AS
SELECT A.USER_CODE, A.APPLY_CODE, C.CANCEL_CODE, O.END_DATE
FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
  ON A.APPLY_CODE = C.APPLY_CODE    
    JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
WHERE END_DATE > SYSDATE;
--==>> View INSERT_SUSPEND_VIEW이(가) 생성되었습니다.


-- ○ 스터디 취소 등록 프로시저에서 사용하는 뷰
-- ○ 뷰 이름 : STUDY_CANCEL_VIEW
CREATE OR REPLACE VIEW STUDY_CANCEL_VIEW
AS
SELECT O.STUDY_CODE 스터디코드, A.APPLY_CODE 참가코드, A.USER_CODE 참여자, C.CANCEL_CODE 취소코드, C.CANCEL_DATE 취소날짜, C.AUTO_CANCEL 자동취소여부, P.POSITION_CODE 직책, O.USER_CODE AS 개설자 
     , O.START_DATE 시작일, O.END_DATE 종료일, M.MEMNUM AS 최소인원, O.WRITE_DATE 작성일
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        JOIN TBL_MEMNUM M
        ON M.MEMNUM_CODE = O.MIN_MEM_CODE
            LEFT JOIN TBL_STUDY_CANCEL C
            ON C.APPLY_CODE = A.APPLY_CODE
                JOIN TBL_MEMNUM M2
                ON M2.MEMNUM_CODE = O.MAX_MEM_CODE
                    JOIN TBL_STUDY_POSITION P
                    ON A.POSITION_CODE = P.POSITION_CODE;
--==>> View STUDY_CANCEL_VIEW이(가) 생성되었습니다.

SELECT *
FROM TBL_ADMIN;
