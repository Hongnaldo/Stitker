-- 테이블 시퀀스 생성_진주

-- 시퀀스 이름은 『테이블이름축약_SEQ』이런식으로 했습니다.

/*

 ① 모임 요일 테이블
 ② 요일 테이블
 ③ 인원수 테이블
 ④ 등급 테이블
 ⑤ 스터디 유형 테이블
 ⑥ 관심분야 대분류 테이블
 ⑦ 관심분야 중분류 테이블
 ⑧ 지역 대분류 테이블
 ⑨ 지역 중분류 테이블
 ⑩ 스터디 개설 테이블

     
*/

-- ① 모임 요일 테이블 시퀀스 생성
CREATE SEQUENCE STD_MEETDAY_SEQ
NOCACHE;

-- ② 요일 테이블 시퀀스 생성
CREATE SEQUENCE WEEKDAY_SEQ
NOCACHE;

-- ③ 인원수 테이블 시퀀스 생성
CREATE SEQUENCE MEMNUM_SEQ
NOCACHE;

-- ④ 등급 테이블 시퀀스 생성
CREATE SEQUENCE USER_RANK_SEQ
NOCACHE;

-- ⑤ 스터디 유형 테이블 시퀀스 생성
CREATE SEQUENCE STD_TYPE_SEQ
NOCACHE;

-- ⑥ 관심분야 대분류 테이블 시퀀스 생성
CREATE SEQUENCE INTER_LC_SEQ
NOCACHE;

-- ⑦ 관심분야 중분류 테이블 시퀀스 생성
CREATE SEQUENCE INTER_MC_SEQ
NOCACHE;

-- ⑧ 지역 대분류 테이블 시퀀스 생성
CREATE SEQUENCE LOC_LC_SEQ
NOCACHE;

-- ⑨ 지역 중분류 테이블 시퀀스 생성
CREATE SEQUENCE LOC_MC_SEQ
NOCACHE;

-- ⑩ 스터디 개설 테이블 시퀀스 생성
CREATE SEQUENCE STD_OPEN_SEQ
NOCACHE;



