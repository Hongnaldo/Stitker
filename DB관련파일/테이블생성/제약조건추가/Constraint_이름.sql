--○ 테이블명, CK/UK 추가
--예시)
ALTER TABLE TBL_어쩌구
ADD( CONSTRAINT 어쩌구_컬럼_CK CHECK (컬럼명 > 100 AND 컬럼명 < 200)
   , CONSTRAINT 어쩌구_컬럼_UK UNIQUE (컬럼명)
);