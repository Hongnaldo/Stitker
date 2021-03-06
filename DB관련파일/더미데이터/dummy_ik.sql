--○ 회원 코드 생성(입력완)
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)
VALUES('UC'||USER_CODE_CRE_SEQ.NEXTVAL);
--==>>1 행 이(가) 삽입되었습니다. * 7

-- 회원 등록 코드 입력
SELECT *
FROM TBL_USER_CODE_CREATE;
/*
UC1
UC2
UC3
UC4
UC5
UC6
UC7
*/

--확인용
--관심분야(중분류)
SELECT *
FROM TBL_INTEREST_MC;
/*
IM1	정보기술전략
IM2	정보기술컨설팅
IM3	정보기술기획
IM4	SW제품기획
IM5	빅데이터분석
IM6	IOT융합서비스기획
IM7	빅데이터기획
IM8	핀테크기술기획
IM9	SW아키텍처
*/
--지역 중분류
SELECT *
FROM TBL_LOC_MC;
/*
LM1	은평구/서대문구/마포구
LM2	종로구/중구/용산구
LM3	도봉구/강북구/성북구/노원구
LM4	동대문구/중랑구/성동구/광진구
LM5	강서구/양천구
LM6	영등포구/구로구/금천구
LM7	동작구/관악구
*/
--관심 스터디
SELECT *
FROM TBL_STUDY_TYPE;
/*
ST1	면접
ST2	자격증
ST3	프로그래밍언어
ST4	알고리즘
ST5	취업관련
ST6	기타
*/
--○ 회원 등록(작성완)
INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC1','phi11','java001$','9301022345678','PQ1','강아지(울집포도)','IM1','LM6','JM1','phi11@gmail.com','박혜인',SYSDATE,'ST1');

INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC2','yhj22','java002$','9401031234567','PQ2','마르게리타피자','IM2','LM2','JM5','yhj22@daum.net','윤홍준',SYSDATE,'ST2');

INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC3','ljj33','java003$','9407082345678','PQ3','아이슬란드','IM3','LM1','JM6','ljj33@gmail.com','이진주',SYSDATE,'ST3');

INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC4','jyw44','java004$','9502031234567','PQ4','반지의 제왕','IM4','LM3','JM8','jyw44@naver.com','조영욱',SYSDATE,'ST4');

INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC5','jik55','java005$','9603142345678','PQ5','오만과 편견','IM5','LM4','JM5','jik55@nate.com','조인경',SYSDATE,'ST5');

INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC6','hsm66','java006$','9507052345678','PQ6','우리 가족','IM6','LM5','JM6','hsm66@naver.com','허수민',SYSDATE,'ST6');

INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN,PW_SRCH_QUE_CODE,PW_SRCH_QUE_ANS,INTEREST_MC_CODE,LOC_MC_CODE,
JOB_MC_CODE,EMAIL,NAME,REGDATE,STUDY_TYPE_CODE)
VALUES('UC7','khj77','java007$','8709041234567','PQ7','이순신','IM7','LM6','JM7','khj77@daum.net','김호진',SYSDATE,'ST1');
COMMIT;
--데이터 확인
SELECT *
FROM TBL_USER_REGISTER
ORDER BY TO_NUMBER(SUBSTR(USER_CODE, 3));
/*


*/
--제약조건 확인
SELECT * FROM ALL_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_USER_REGISTER';




--확인
SELECT *
FROM TBL_USER_REGISTER
ORDER BY USER_CODE;
/*
UC1	phi11	java001$	9301022345678	PQ1	강아지(울집포도)	IM1	LM6	JM1	phi11@gmail.com	박혜인	2021-01-09	ST1
UC5	jik55	java005$	9603142345678	PQ5	오만과 편견	IM5	LM4	JM5	jik55@nate.com	조인경	2021-01-09	ST5
UC6	hsm66	java006$	9507052345678	PQ6	우리 가족	IM6	LM5	JM6	hsm66@naver.com	허수민	2021-01-09	ST6
UC7	khj77	java007$	8709041234567	PQ7	이순신	IM7	LM6	JM7	khj77@daum.net	김호진	2021-01-09	ST1
*/
--○ 비밀번호 찾기 질문(입력완)
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'가장 좋아하는 동물은?');
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'가장 좋아하는 음식은? ');
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'기억에 남는 장소는?');
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'가장 좋아하는 영화는?');
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'인상 깊게 읽은 책 이름은?');
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'자신의 보물 1호는?');
INSERT INTO TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE, PW_SRCH_QUE)
VALUES('PQ'||PW_SRCH_QUE_SEQ.NEXTVAL,'가장 친한 친구의 이름은?');
--==>>1 행 이(가) 삽입되었습니다. * 7
SELECT *
FROM TBL_PW_SEARCH_QUE
ORDER BY PW_SRCH_QUE;
/*
PQ1	가장 좋아하는 동물은?
PQ4	가장 좋아하는 영화는?
PQ2	가장 좋아하는 음식은? 
PQ7	가장 친한 친구의 이름은?
PQ3	기억에 남는 장소는?
PQ5	인상 깊게 읽은 책 이름은?
PQ6	자신의 보물 1호는?
*/

--○ 현재 직업 대분류(입력완)
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'관리·경영·금융·보험');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'교육·연구·법률·보건');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'사회복지·문화·예술·방송');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'운송·영업·판매·경비');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'관리·숙박·여행·스포츠·음식');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'건설·기계·재료·화학·섬유');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'전기·전자·정보통신');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'식품·환경·농림어업·군인');
INSERT INTO TBL_JOB_LC(JOB_LC_CODE, JOB_LC)
VALUES('JL'||JOB_LC_SEQ.NEXTVAL,'녹색직업');
--==>> 1 행 이(가) 삽입되었습니다. * 12
SELECT *
FROM TBL_JOB_LC
ORDER BY JOB_LC_CODE;
/*
JL1	관리·경영·금융·보험
JL2	교육·연구·법률·보건
JL3	사회복지·문화·예술·방송
JL4	운송·영업·판매·경비
JL5	관리·숙박·여행·스포츠·음식
JL6	건설·기계·재료·화학·섬유
JL7	전기·전자·정보통신
JL8	식품·환경·농림어업·군인
JL9	녹색직업
*/
COMMIT;

--○ 현재 직업 중분류
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'정부행정 관리자','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기업고위임원','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'행정 및 경영지원 관련 서비스 관리자','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'사회복지관련관리자','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'음식서비스관련 관리자','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'영업 및 판매 관리자','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'연구관리자','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'인사 및 노사 관련 전문가','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'정부 및 공공 행정 전문가','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'관세사','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'상품기획 전문가','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'자재관리사무원','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'운송 사무원','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'보험계리사','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'출납창구사무원','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'금융관련사무원','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'증권 및 외환 딜러','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'투자 및 신용 분석가','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'병무행정사무원','JL1');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'대학교수','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'대학 시간강사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'생명과학 연구원','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'자연과학 연구원','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'대학 교육조교','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'인문과학 연구원','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'초등학교교사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'유치원교사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'중·고등학교 교사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'문리 및 어학 강사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'컴퓨터강사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'학습지 및 방문교사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'변호사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'법무사 및 집행관','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'경찰관','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'변리사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'소방관','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'판사 및 검사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'소년보호관 및 교도관','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'일반의사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'전문 의사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'한의사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'수의사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'약사 및 한약사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'간호사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'물리 및 작업 치료사','JL2');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'사회복지사','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'직업상담사 및 취업 알선원','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기타 사회복지관련 종사원','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'보육교사','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'사회단체활동가','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'성직자','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'작가 및 관련 전문가','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'통역가','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'번역가','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'출판물기획자','JL3');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'항공기조종사','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'선장·항해사 및 도선사','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'관제사','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'택시운전원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'화물열차 차장 및 관련 종사원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'버스운전원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'영업원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'판매원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'상품중개인 및 경매사','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'경호원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'무인경비원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'계기 검침원 및 가스 점검원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'주차관리원 및 안내원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'검표원','JL4');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'미용사','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'피부미용 및 체형관리사','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'애완동물미용사','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'항공기 객실승무원','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'오락시설 서비스원','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'운동선수','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'프로게이머','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'스포츠 및 레크레이션 강사','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'객실승무원','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'조리사','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'바텐더','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'주방장','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'웨이터','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'패스트푸드원','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'음식배달원','JL5');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'토목공학 기술자','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'조경기술자','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'도시 및 교통설계 전문가','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'건축가 및 건축공학 기술자','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'건축목공','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'채굴 및 토목 관련 종사자','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'건설자재시험원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'측량 및 지리정보 전문가','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기계공학 기술자 및 연구원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'공업기계설치 및 정비원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'건설 및 광업기계설치 및 정비원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기타 운송장비 정비원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'금속공작기계조작원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'자동조립라인 및 산업용 로봇 조작원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'운송장비 조립원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'금속·재료공학 기술자 및 연구원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'금속 가공기계 조작원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'비금속제품 관련 생산기 조작원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'용접원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'화학공학 기술자 및 연구원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'양장 및 양복 제조원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'섬유공학 기술자 및 연구원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'재단사','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'섬유제조 기계 조작원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'식품·섬유 공학 및 에너지 시험원','JL6');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'전기공학 기술자 및 연구원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'전자공학 기술자 및 연구원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'PC 및 사무기기 설치 및 수리원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'발전 및 배전 장치 조작원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'전기 및 전자 설비 조작원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'통신공학 기술자 및 연구원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'컴퓨터시스템 설계 및 분석가','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'네트워크시스템 개발자','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'응용 소프트웨어 개발자','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'웹개발자','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'웹 및 멀티미디어 기획자','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'시스템 소프트웨어 개발자','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'통신 및 방송송출 장비 기사','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'컴퓨터 하드웨어 기술자 및 연구원','JL7');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'제빵원 및 제과원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'식품·섬유 공학 및 에너지 시험원(식품분야)','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'식품 및 담배 등급원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'육류·어패류 및 낙농품 가공기계 조작원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'제분 및 도정 관련 기계 조작원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'식품공학 기술자 및 연구원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'음료 제조관련 기계 조작원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'환경공학 기술자 및 연구원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'환경공학 시험원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'가스에너지기술자및연구원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기타 공학관련 기술자 및 시험원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'산업안전 및 위험 관리원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'목재가공 관련 기계 조작원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'사진인화 및 현상기 조작원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'공예원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'과수작물재배자','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'채소 및 특용작물 재배원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'가축사육종사원','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'영관급 이상','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'위관급','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'부사관','JL8');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'자연과학 연구원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'건축가 및 건축공학 기술자','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'조경기술자','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'단열공(보온공)','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기계공학 기술자 및 연구원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'화학공학 기술자 및 연구원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'발전 및 배전 장치 조작원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'전자공학 기술자 및 연구원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'환경공학 기술자 및 연구원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'기타 공학관련 기술자 및 시험원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'환경공학 시험원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'가스에너지기술자및연구원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'상·하수도 처리장치 조작원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'조림·영림 및 벌목원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'조경원','JL9');
INSERT INTO TBL_JOB_MC(JOB_MC_CODE, JOB_MC,JOB_LC_CODE)
VALUES('JM'||JOB_MC_SEQ.NEXTVAL,'재활용 처리 및 소각로 조작원','JL9');

SELECT *
FROM TBL_JOB_MC
ORDER BY JOB_MC_CODE;
COMMIT;
--○ 계정 정지
INSERT INTO TBL_ACCOUNT_SUSPEND(ACCT_SUS_CODE, ACCT_SUS_DATE, WARNING_CODE)
VALUES('AS'||ACCT_SUS_SEQ.NEXTVAL,SYSDATE,'경고코드');
 
--○ 탈퇴 카테고리(입력완)
INSERT INTO TBL_WITHDRAWAL_CATEGORY(WDL_CTG_CODE, WDL_CTG)
VALUES('WC'||WDL_CTG_SEQ.NEXTVAL,'개인정보(개인정보 누출 우려, 아이디 변경 위해 탈퇴 후 재가입)');

INSERT INTO TBL_WITHDRAWAL_CATEGORY(WDL_CTG_CODE, WDL_CTG)
VALUES('WC'||WDL_CTG_SEQ.NEXTVAL,'사이트 이용관련(서비스 부족,속도 및 안정성 불만, 이용 불편, 이용빈도 낮음, 혜택 부족');

INSERT INTO TBL_WITHDRAWAL_CATEGORY(WDL_CTG_CODE, WDL_CTG)
VALUES('WC'||WDL_CTG_SEQ.NEXTVAL,'기타(직접 입력)');
--확인
SELECT *
FROM TBL_WITHDRAWAL_CATEGORY
ORDER BY WDL_CTG_CODE; 
/*
WC1	개인정보(개인정보 누출 우려, 아이디 변경 위해 탈퇴 후 재가입)
WC2	사이트 이용관련(서비스 부족,속도 및 안정성 불만, 이용 불편, 이용빈도 낮음, 혜택 부족
WC3	기타(직접 입력)
*/


--○ 탈퇴 기록 및 개인정보 보관(작성완)
INSERT INTO TBL_WITHDRAWAL_INFO(WDL_CODE,WDL_DATE,WDL_CTG_CODE,SSN,USER_CODE,WDL_REASON)
VALUES('WI'||WDL_INFO_SEQ.NEXTVAL,TO_DATE('20200109','YYYY-MM-DD'),'WC1','9507052345678','UC6','여러분 안녕히 계세요~ 저는 제 행복을 찾아 떠납니다.');
 
SELECT *
FROM TBL_WITHDRAWAL_INFO;

 
 
 


--커밋
COMMIT;

SELECT *
FROM TBL_WEEKDAY
ORDER BY WEEKDAY_CODE;
-- 요일 테이블 데이터 입력
DELETE FROM TBL_WEEKDAY;
DROP SEQUENCE WEEKDAY_SEQ;
CREATE SEQUENCE WEEKDAY_SEQ
NOCACHE;

INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '일');
INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '월');
INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '화');
INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '수');
INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '목');
INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '금');
INSERT INTO TBL_WEEKDAY(WEEKDAY_CODE, WEEKDAY) VALUES('WD'||WEEKDAY_SEQ.NEXTVAL, '토');
 

-- 모임 요일
DROP TABLE TBL_STUDY_MEETDAY;

CREATE TABLE TBL_STUDY_MEETDAY
( MEETDAY_CODE  VARCHAR2(5)
, WEEKDAY_CODE  VARCHAR2(5)
, STUDY_CODE    VARCHAR2(15)
, START_TIME    VARCHAR2(5) NOT NULL
, END_TIME      VARCHAR2(5) NOT NULL
, CONSTRAINT STD_MEETDAY_MDC_PK PRIMARY KEY(MEETDAY_CODE)
);
-- 모임 요일 테이블 제약 외래키 조건
ALTER TABLE TBL_STUDY_MEETDAY
ADD ( CONSTRAINT STD_MEETDAY_WDC_FK FOREIGN KEY(WEEKDAY_CODE)
                 REFERENCES TBL_WEEKDAY(WEEKDAY_CODE)); 
                 


DESC TBL_STUDY_MEETDAY;

SELECT *
FROM TBL_STUDY_MEETDAY;
COMMIT;

--시퀀스 확인
SELECT *
FROM USER_SEQUENCES;

--제약조건 확인
SELECT * FROM ALL_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_STUDY_MEETDAY';


ALTER TABLE TBL_STUDY_MEETDAY MODIFY(START_TIME VARCHAR2(5));
ALTER TABLE TBL_STUDY_MEETDAY MODIFY(END_TIME VARCHAR2(5));
COMMIT;

ALTER SESSION SET NLS_DATE_FORMAT='HH24:MI';

SELECT TO_DATE('12:55','HH24:MI') FROM DUAL;