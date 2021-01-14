--■■■ 변경사항 ■■■--

-- 테이블 이름으로 제약조건 조회
SELECT *
FROM ALL_CONSTRAINTS
WHERE OWNER = 'STITKER' AND TABLE_NAME = 'TBL_STUDY_APPLY'
ORDER BY TABLE_NAME;

-- 휴지통 비우기
PURGE RECYCLEBIN;


-- 외출 테이블 삭제(기능 삭제함.)
DROP TABLE TBL_STUDY_STEPOUT;

-- 스터디 출석 시간 NOT NULL 제약조건 삭제.
-- 스터디 출석테이블에 종료날짜까지의 모든 회차 일단 다 인서트하기로 함.
ALTER TABLE TBL_STUDY_ATTEND DROP CONSTRAINT SYS_C008005;

-- 스터디 신청 날짜.
-- 스터디 확인 버튼 눌렸는지 안눌렸는지 확인하기 위함.
ALTER TABLE TBL_STUDY_APPLY DROP CONSTRAINT SYS_C007764;


-- 스터디 진행에서 직책 컬럼 삭제
ALTER TABLE TBL_STUDY_PARTICIPANT DROP COLUMN POSITION_CODE;

-- 스터디 참가에서 직책 컬럼 추가
ALTER TABLE TBL_STUDY_APPLY ADD (
    POSITION_CODE VARCHAR(5) NOT NULL
  , CONSTRAINT STUDY_APPLY_PC_FK FOREIGN KEY (POSITION_CODE)
            REFERENCES TBL_STUDY_POSITION (POSITION_CODE)
);

-- 등급 테이블 체크 제약조건 수정
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK BETWEEN 1 AND 6));

-- 탈퇴 카테고리 항목 컬럼길이 수정(50 -> 150)
ALTER TABLE TBL_WITHDRAWAL_CATEGORY MODIFY(WDL_CTG VARCHAR2(150));

-- 등급 테이블 체크 제약조건 수정
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK BETWEEN 1 AND 6)
    , CONSTRAINT USER_RANK_MNS_CK CHECK(MIN_SCORE >= 0)
    , CONSTRAINT USER_RANK_MXS_CK CHECK(MAX_SCORE <= 18600 AND MAX_SCORE > MIN_SCORE));

-- 인원수 테이블 체크 제약조건 수정 
ALTER TABLE TBL_MEMNUM
ADD ( CONSTRAINT MEMNUM_CK CHECK(MEMNUM BETWEEN 3 AND 8));

-- 스터디원 신고카테고리 테이블의 카테고리 칼럼 데이터타입 변경(늘림)
ALTER TABLE TBL_MEM_REPORT_CTG MODIFY MEM_REPORT_CTG VARCHAR2(50);

-- 스터디원 신고카테고리 테이블의 기본키 칼럼 데이터타입 변경(늘림)
ALTER TABLE TBL_MEM_REPORT_CTG MODIFY MEM_REPORT_CTG_CODE VARCHAR2(5);

-- 스터디원 처리결과 테이블 기본키 칼럼 데이터타입 변경(늘림)
ALTER TABLE TBL_MEM_REPORT_HANDLE_RESULT MODIFY MEM_REPORT_HANDLE_RESULT_CODE VARCHAR2(5);

-- 세미나 및 공모전 테이블 모집시작일, 모집마감일 컬럼 추가
ALTER TABLE TBL_BOARD_SEMINAR ADD START_DATE DATE NOT NULL;
ALTER TABLE TBL_BOARD_SEMINAR ADD END_DATE DATE NOT NULL;

--스터디원 신고처리 테이블 칼럼 데이터타입 변경(늘림
ALTER TABLE TBL_MEM_REPORT_HANDLE MODIFY HANDLE_RESULT VARCHAR2(5);

-- Q&A 답변 게시판 Q&A질문게시물코드 추가
ALTER TABLE TBL_BOARD_ANSWER ADD (
    QPOST_CODE VARCHAR(15) 
  , CONSTRAINT BRD_AWR_QPC_FK FOREIGN KEY(QPOST_CODE)
            REFERENCES TBL_BOARD_QUESTION(POST_CODE)
);

--Q&A 답변 게시판 관심분야 중분류 코드 삭제
ALTER TABLE TBL_BOARD_ANSWER DROP COLUMN INTEREST_MC_CODE;


-- 주민번호 컬럼 길이 변경 
ALTER TABLE TBL_USER_REGISTER MODIFY(SSN VARCHAR2(20));
--==>>Table TBL_USER_REGISTER이(가) 변경되었습니다.

ALTER TABLE TBL_WITHDRAWAL_INFO MODIFY(SSN VARCHAR2(20));
--==>>Table TBL_WITHDRAWAL_INFO이(가) 변경되었습니다.

COMMIT;