--■■■ 시퀀스(SEQUENCE) 생성 ■■■--
--※시퀀스이름 : 테이블명간단히_SEQ

-- 시퀀스 조회
SELECT *
FROM USER_SEQUENCES;

--예시)
-- ○ 직책 테이블
CREATE SEQUENCE STUDY_POS_SEQ
NOCACHE;


-- ○ 모임 요일 테이블 시퀀스 생성
CREATE SEQUENCE STD_MEETDAY_SEQ
NOCACHE;

-- ○ 요일 테이블 시퀀스 생성
CREATE SEQUENCE WEEKDAY_SEQ
NOCACHE;

-- ○ 인원수 테이블 시퀀스 생성
CREATE SEQUENCE MEMNUM_SEQ
NOCACHE;

-- ○ 등급 테이블 시퀀스 생성
CREATE SEQUENCE USER_RANK_SEQ
NOCACHE;

-- ○ 스터디 유형 테이블 시퀀스 생성
CREATE SEQUENCE STD_TYPE_SEQ
NOCACHE;

-- ○ 관심분야 대분류 테이블 시퀀스 생성
CREATE SEQUENCE INTER_LC_SEQ
NOCACHE;

-- ○ 관심분야 중분류 테이블 시퀀스 생성
CREATE SEQUENCE INTER_MC_SEQ
NOCACHE;

-- ○ 지역 대분류 테이블 시퀀스 생성
CREATE SEQUENCE LOC_LC_SEQ
NOCACHE;

-- ○ 지역 중분류 테이블 시퀀스 생성
CREATE SEQUENCE LOC_MC_SEQ
NOCACHE;

-- ○ 스터디 개설 테이블 시퀀스 생성
CREATE SEQUENCE STD_OPEN_SEQ
NOCACHE;