--■■■ 시퀀스(SEQUENCE) 삭제 ■■■--


-- ○ 모임 요일 테이블 시퀀스 생성
DROP SEQUENCE STD_MEETDAYSEQ;


-- ○ 요일 테이블 시퀀스 생성
DROP SEQUENCE WEEKDAYSEQ;


-- ○ 인원수 테이블 시퀀스 생성
DROP SEQUENCE MEMNUMSEQ;


-- ○ 등급 테이블 시퀀스 생성
DROP SEQUENCE USER_RANKSEQ;


-- ○ 스터디 유형 테이블 시퀀스 생성
DROP SEQUENCE STD_TYPESEQ;


-- ○ 관심분야 대분류 테이블 시퀀스 생성
DROP SEQUENCE INTER_LCSEQ;


-- ○ 관심분야 중분류 테이블 시퀀스 생성
DROP SEQUENCE INTER_MCSEQ;


-- ○ 지역 대분류 테이블 시퀀스 생성
DROP SEQUENCE LOC_LCSEQ;


-- ○ 지역 중분류 테이블 시퀀스 생성
DROP SEQUENCE LOC_MCSEQ;


-- ○ 스터디 개설 테이블 시퀀스 생성
DROP SEQUENCE STD_OPENSEQ;


--○ 스터디원 신고 등록 시퀀스
DROP SEQUENCE MEM_RRSEQ;


--○ 스터디원 신고 카테고리 시퀀스
DROP SEQUENCE MEM_RCSEQ;


--○ 스터디원 신고 처리 시퀀스
DROP SEQUENCE MEM_RHSEQ;


--○ 스터디원 신고 처리 결과 시퀀스
DROP SEQUENCE MEM_RHRSEQ;


--○ 내보내기 등록 시퀀스
DROP SEQUENCE MEM_KRSEQ;


--○ 내보내기 처리 시퀀스
DROP SEQUENCE MEM_KHSEQ;


--○ IT기술정보공유 테이블
DROP SEQUENCE BOARD_INFORMSEQ;


--○ 면접/코딩테스트 후기 테이블
DROP SEQUENCE BOARD_INTERVIEWSEQ;


--○ 세미나 및 공모전 테이블
DROP SEQUENCE BOARD_SEMINARSEQ;


--○ 자유게시판 테이블
DROP SEQUENCE BOARD_FREESEQ;


--○ Q&A 질문 테이블
DROP SEQUENCE BOARD_QUESTIONSEQ;


--○ Q&A 답변 테이블
DROP SEQUENCE BOARD_ANSWERSEQ;


--○ 스터디 후기 테이블
DROP SEQUENCE BOARD_STUDYREVIEWSEQ;


--○ IT기술정보공유 댓글 테이블
DROP SEQUENCE COMMENT_INFORMSEQ;


--○ 면접 및 코딩테스트 후기 댓글 테이블
DROP SEQUENCE COMMENT_INTERVIEWSEQ;


--○ 세미나 및 공모전 댓글 테이블
DROP SEQUENCE COMMENT_SEMINARSEQ;


--○ 자유게시판 댓글 테이블
DROP SEQUENCE COMMENT_FREESEQ;


--○ Q&A 질문 댓글 테이블
DROP SEQUENCE COMMENT_QUESTIONSEQ;


--○ Q&A 답변 댓글 테이블
DROP SEQUENCE COMMENT_ANSWERSEQ;


--○ 스터디 후기 댓글 테이블
DROP SEQUENCE COMMENT_STUDYREVIEWSEQ;


--○ IT기술정보공유 추천/비추천 테이블
DROP SEQUENCE REC_INFORMSEQ;


--○ 세미나 및 공모전 추천/비추천 테이블
DROP SEQUENCE REC_SEMINARSEQ;


--○ 면접/코딩테스트 후기 추천비추천 테이블
DROP SEQUENCE REC_INTERVIEWSEQ;


--○ 자유게시판 추천비추천 테이블
DROP SEQUENCE REC_FREESEQ;


--○ Q&A 질문 추천비추천 테이블
DROP SEQUENCE REC_QUESTIONSEQ;


--○ Q&A 답변 추천비추천 테이블
DROP SEQUENCE REC_INFORMSEQ;


--○ 스터디 후기 추천/ 비추천 테이블
DROP SEQUENCE REC_STUDYREVIEWSEQ;


--○ IT기술정보공유 신고등록 테이블
DROP SEQUENCE RPT_RG_INFORMSEQ;


--○ 면접/코딩테스트 후기  신고등록 테이블
DROP SEQUENCE RPT_RG_INTERVIEWSEQ;


--○ 세미나 및 공모전  신고등록 테이블
DROP SEQUENCE RPT_RG_SEMINARSEQ;


--○ 자유게시판 신고등록 테이블
DROP SEQUENCE RPT_RG_FREESEQ;


--○ Q&A 질문 신고등록 테이블
DROP SEQUENCE RPT_RG_QUESTIONSEQ;


--○ Q&A 답변 신고등록 테이블
DROP SEQUENCE RPT_RG_ANSWERSEQ;


--○ 스터디 후기 신고 등록
DROP SEQUENCE RPT_RG_STUDYREVIEWSEQ;


--○ IT기술정보공유 신고처리 테이블
DROP SEQUENCE RPT_HD_INFORMSEQ;


--○ 면접/코딩테스트 후기 신고처리 테이블
DROP SEQUENCE RPT_HD_INTERVIEWSEQ;


--○ 세미나 및 공모전 신고처리 테이블
DROP SEQUENCE RPT_HD_SEMINARSEQ;


--○ 자유게시판 신고처리 테이블
DROP SEQUENCE RPT_HD_FREESEQ;


--○ Q&A 질문 신고처리 테이블
DROP SEQUENCE RPT_HD_QUESTIONSEQ;


--○ Q&A 답변 신고처리 테이블
DROP SEQUENCE RPT_HD_ANSWERSEQ;


--○ 스터디 후기 신고 처리  
DROP SEQUENCE RPT_HD_STUDYREVIEWSEQ;
  

--○ 실습 테이블 생성(신고 처리 테이블)
DROP SEQUENCE HD_RESULTSEQ;


--○ 실습 테이블 생성(세미나 카테고리 테이블)
DROP SEQUENCE SEMI_CTGSEQ;


--○ 실습 테이블 생성(게시글 신고 카테고리 테이블)
DROP SEQUENCE POST_RPT_CTGSEQ;


--○ 회원 코드 생성 테이블
DROP SEQUENCE USER_CODE_CRESEQ;


--○ 회원 등록 테이블 
DROP SEQUENCE USER_REGSEQ;


--○ 비밀번호 찾기 질문 테이블
DROP SEQUENCE PW_SRCH_QUESEQ;


--○ 현재 직업 대분류 테이블
DROP SEQUENCE JOB_LCSEQ;


--○ 현재 직업 중분류 테이블
DROP SEQUENCE JOB_LCSEQ;


--○ 계정 정지 등록 테이블
DROP SEQUENCE ACCT_SUSSEQ;


--○ 탈퇴 기록 및 개인정보 보관 테이블
DROP SEQUENCE WDL_INFOSEQ;


--○ 탈퇴 카테고리 테이블
DROP SEQUENCE WDL_CTGSEQ;


-- ○ 직책 테이블
DROP SEQUENCE STUDY_POSSEQ;


--○ 스터디 신청 테이블
DROP SEQUENCE STUDY_APLSEQ;


--○ 스터디 취소 처리 테이블
DROP SEQUENCE STUDY_CANCSEQ;


--○ 스터디 참가 테이블
DROP SEQUENCE STUDY_PARTISEQ;


--○ 스터디 컨텐츠 테이블
DROP SEQUENCE STUDY_CONSEQ;


--○ 스터디 평가 테이블
DROP SEQUENCE STUDY_ASSESEQ;


--○ 출석부 테이블
DROP SEQUENCE STUDY_ATTSEQ;


--○ 일정관리 테이블
DROP SEQUENCE STUDY_SCHESEQ;


--○ 외출등록 테이블
DROP SEQUENCE STUDY_STOSEQ;


--○ 스터디원 평가 등록
DROP SEQUENCE STUDY_IASSESEQ;


--○ 평가점수 테이블
DROP SEQUENCE STUDY_ASSE_RESPSEQ;


--○ 평가항목 테이블
DROP SEQUENCE STUDY_ASSE_ITMSEQ;


--○ 점수 기록 테이블
DROP SEQUENCE STUDY_SCORSEQ;


--○ 경고 등록 테이블
DROP SEQUENCE STUDY_WARNSEQ;


--○ 스터디 댓글 테이블
DROP SEQUENCE COMM_STDSEQ;


-- ○ 스터디 신고 등록 테이블
DROP SEQUENCE STUDY_ACCSEQ;


-- ○ 스터디 신고 처리 테이블
DROP SEQUENCE STUDY_ACC_HANSEQ;


-- ○ 스터디 경고 등록 테이블
DROP SEQUENCE STUDY_WARSEQ;


-- ○ 욕설 테이블
DROP SEQUENCE CURSESEQ;


-- ○ 고객센터(1:1문의) 테이블
DROP SEQUENCE ASKSEQ;


-- ○ 고객센터(공지사항) 테이블
DROP SEQUENCE NOTICESEQ;


-- ○ 관리자 테이블
DROP SEQUENCE ADMINSEQ;
