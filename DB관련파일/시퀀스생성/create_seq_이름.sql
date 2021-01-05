--■■■ 시퀀스(SEQUENCE) 생성 ■■■--
--※시퀀스이름 : 테이블명간단히_SEQ
--※PK 자료형 확인 후 만들기
--  영어 두자리 + 나머지 숫자
--  겹쳐서 에러나면 영어 두자리 다른 글자로 변경해서 시도하기 

--예시)
-- ○ 직책 테이블
CREATE SEQUENCE STUDY_POS_SEQ
NOCACHE;
