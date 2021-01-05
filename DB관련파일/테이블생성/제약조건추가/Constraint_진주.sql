-- CK, UK 제약조건 설정_진주


-- 모임 요일 테이블 CK 제약 조건
ALTER TABLE TBL_STUDY_MEETDAY
ADD ( CONSTRAINT STD_MEETDAY_ST_CK CHECK(START_TIME BETWEEN 0 AND 24)
    , CONSTRAINT STD_MEETDAY_ET_CK CHECK(END_TIME BETWEEN 0 AND 24 AND END_TIME>START_TIME));

-- 요일 테이블 UK 제약 조건
ALTER TABLE TBL_WEEKDAY
ADD ( CONSTRAINT WEEKDAY_WD_UK UNIQUE(WEEKDAY));

-- 인원수 테이블 CK, UK 제약 조건
ALTER TABLE TBL_MEMNUM
ADD ( CONSTRAINT MEMNUM_MN_CK CHECK(MEMNUM >=3 AND MEMNUM <=8 ));

ALTER TABLE TBL_MEMNUM
ADD ( CONSTRAINT MEMNUM_MN_UK UNIQUE(MEMNUM));


-- 등급 테이블 CK, UK 제약 조건
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK >=6 AND RANK<=1)
    , CONSTRAINT USER_RANK_MNS_CK CHECK(MIN_SCORE >= -4200)
    , CONSTRAINT USER_RANK_MXS_CK CHECK(MAX_SCORE <= 21600 AND MAX_SCORE > MIN_SCORE));

ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_UK UNIQUE(RANK)
    , CONSTRAINT USER_RANK_MNS_UK UNIQUE(MIN_SCORE)
    , CONSTRAINT USER_RANK_MXS_UK UNIQUE(MAX_SCORE));

-- 스터디 유형 테이블 UK 제약 조건
ALTER TABLE TBL_STUDY_TYPE
ADD (CONSTRAINT STD_TYPE_ST_UK UNIQUE(STUDY_TYPE));

-- 관심분야 대분류 테이블 UK 제약 조건
ALTER TABLE TBL_INTEREST_LC
ADD (CONSTRAINT INTER_LC_IL_UK UNIQUE(INTEREST_LC));

-- 관심분야 중분류 테이블 UK 제약 조건
ALTER TABLE TBL_INTEREST_MC
ADD (CONSTRAINT INTER_MC_IM_UK UNIQUE(INTEREST_MC));

-- 지역 대분류 테이블 UK 제약 조건
ALTER TABLE TBL_LOC_LC
ADD ( CONSTRAINT LOC_LC_UK UNIQUE(LOC_LC));

-- 지역 중분류 테이블 UK 제약 조건
ALTER TABLE TBL_LOC_MC
ADD ( CONSTRAINT LOC_MC_UK UNIQUE(LOC_MC));

-- 스터디 개설 테이블 체크 제약조건 
ALTER TABLE TBL_STUDY_OPEN
ADD (CONSTRAINT STD_OPEN_SD_CK CHECK (START_DATE >= WRITE_DATE+10 AND START_DATE <= WRITE_DATE+15));
