--■■■ 시퀀스(SEQUENCE) 생성 ■■■--
--※시퀀스이름 : 테이블명간단히_SEQ

-- 시퀀스 조회
SELECT *
FROM USER_SEQUENCES;

-- ○ 스터디 신고 등록 테이블
CREATE SEQUENCE STUDY_ACC_SEQ
NOCACHE;

-- ○ 스터디 신고 처리 테이블
CREATE SEQUENCE STUDY_ACC_HAN_SEQ
NOCACHE;

-- ○ 스터디 경고 등록 테이블
CREATE SEQUENCE STUDY_WAR_SEQ
NOCACHE;

-- ○ 욕설 테이블
CREATE SEQUENCE CURSE_SEQ
NOCACHE;

-- ○ 고객센터(1:1문의) 테이블
CREATE SEQUENCE ASK_SEQ
NOCACHE;

-- ○ 고객센터(공지사항) 테이블
CREATE SEQUENCE NOTICE_SEQ
NOCACHE;

-- ○ 관리자 테이블
CREATE SEQUENCE ADMIN_SEQ
NOCACHE;
--==>>
/*
Sequence STUDY_ACC_SEQ이(가) 생성되었습니다.


Sequence STUDY_ACC_HAN_SEQ이(가) 생성되었습니다.


Sequence STUDY_WAR_SEQ이(가) 생성되었습니다.


Sequence CURSE_SEQ이(가) 생성되었습니다.


Sequence ASK_SEQ이(가) 생성되었습니다.


Sequence NOTICE_SEQ이(가) 생성되었습니다.


Sequence ADMIN_SEQ이(가) 생성되었습니다.
*/