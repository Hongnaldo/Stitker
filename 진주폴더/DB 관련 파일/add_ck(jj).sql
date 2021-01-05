-- CK 제약조건 설정_진주

-- CK 표시한 테이블들만 추가되었습니다.

/*

 ① 모임 요일 테이블  -- CK
 ② 요일 테이블
 ③ 인원수 테이블
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

-- ④ 등급 테이블 체크 제약조건
-- 등급의 최고 점수는 최소 점수보다 커야한다.
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_MS_CK CHECK(MAX_SCORE > MIN_SCORE));

-- ⑩ 스터디 개설 테이블 체크 제약조건 
-- 시작일은 작성일로부터 10일 이후 15일 이내여야한다.
ALTER TABLE TBL_STUDY_OPEN
ADD (CONSTRAINT STD_OPEN_SD_CK CHECK (START_DATE >= WRITE_DATE+10 AND START_DATE <= WRITE_DATE+15));
