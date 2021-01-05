-- CK 제약조건 설정_진주

-- CK 표시한 테이블들만 추가되었습니다.

-- 추가 : 인원수 테이블 인원수 CK 제약조건 추가
--        등급 테이블 등급 CK 제약조건 추가, 최고점수와 최저점수에 CK 제약조건 추가

/*

 ① 모임 요일 테이블  -- CK
 ② 요일 테이블
 ③ 인원수 테이블     -- CK
 ④ 등급 테이블       -- CK
 ⑤ 스터디 유형 테이블
 ⑥ 관심분야 대분류 테이블
 ⑦ 관심분야 중분류 테이블
 ⑧ 지역 대분류 테이블
 ⑨ 지역 중분류 테이블
 ⑩ 스터디 개설 테이블   -- CK

     
*/

-- ① 모임 요일 테이블 체크 제약 조건
-- 시작 시간이 0이상 24이하
-- 끝시간이 0이상 24이하 AND 끝시간이 시작 시간보다 커야한다.
ALTER TABLE TBL_STUDY_MEETDAY
ADD ( CONSTRAINT STD_MEETDAY_ST_CK CHECK(START_TIME BETWEEN 0 AND 24)
    , CONSTRAINT STD_MEETDAY_ET_CK CHECK(END_TIME BETWEEN 0 AND 24 AND END_TIME>START_TIME));


--  ③ 인원수 테이블
-- 인원수는 3이상 8이하 이어야 한다.
ALTER TABLE TBL_MEMNUM
ADD ( CONSTRAINT MEMNUM_MN_CK CHECK(MEMNUM >=3 AND MEMNUM <=8 ));



-- ④ 등급 테이블 체크 제약조건
-- 등급은 1~6, 최저 점수는 -4200점 이상, 최고점수는 21600이하 + 최저 점수 보다 커야함
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK >=6 AND RANK<=1)
    , CONSTRAINT USER_RANK_MNS_CK CHECK(MIN_SCORE >= -4200)
    , CONSTRAINT USER_RANK_MXS_CK CHECK(MAX_SCORE <= 21600 AND MAX_SCORE > MIN_SCORE));

-- ⑩ 스터디 개설 테이블 체크 제약조건 
-- 시작일은 작성일로부터 10일 이후 15일 이내여야한다.
ALTER TABLE TBL_STUDY_OPEN
ADD (CONSTRAINT STD_OPEN_SD_CK CHECK (START_DATE >= WRITE_DATE+10 AND START_DATE <= WRITE_DATE+15));
