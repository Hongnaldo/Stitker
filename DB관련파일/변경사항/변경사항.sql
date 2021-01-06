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