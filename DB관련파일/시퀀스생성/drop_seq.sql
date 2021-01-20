--■■■ 시퀀스(SEQUENCE) 삭제 ■■■--


-- ○ 모임 요일 테이블 시퀀스 생성
CREATE SEQUENCE STD_MEETDAY_SEQ;

-- ○ 요일 테이블 시퀀스 생성
DROP SEQUENCE WEEKDAY_SEQ;


-- ○ 인원수 테이블 시퀀스 생성
DROP SEQUENCE MEMNUM_SEQ;


-- ○ 등급 테이블 시퀀스 생성
DROP SEQUENCE USER_RANK_SEQ;


-- ○ 스터디 유형 테이블 시퀀스 생성
DROP SEQUENCE STD_TYPE_SEQ;


-- ○ 관심분야 대분류 테이블 시퀀스 생성
DROP SEQUENCE INTER_LC_SEQ;


-- ○ 관심분야 중분류 테이블 시퀀스 생성
DROP SEQUENCE INTER_MC_SEQ;


-- ○ 지역 대분류 테이블 시퀀스 생성
DROP SEQUENCE LOC_LC_SEQ;


-- ○ 지역 중분류 테이블 시퀀스 생성
DROP SEQUENCE LOC_MC_SEQ;


-- ○ 스터디 개설 테이블 시퀀스 생성
DROP SEQUENCE STD_OPEN_SEQ;


--○ 스터디원 신고 등록 시퀀스
DROP SEQUENCE MEM_RR_SEQ;


--○ 스터디원 신고 카테고리 시퀀스
DROP SEQUENCE MEM_RC_SEQ;


--○ 스터디원 신고 처리 시퀀스
DROP SEQUENCE MEM_RH_SEQ;


--○ 스터디원 신고 처리 결과 시퀀스
DROP SEQUENCE MEM_RHR_SEQ;


--○ 내보내기 등록 시퀀스
DROP SEQUENCE MEM_KR_SEQ;


--○ 내보내기 처리 시퀀스
DROP SEQUENCE MEM_KH_SEQ;


--○ IT기술정보공유 테이블
DROP SEQUENCE BOARD_INFORM_SEQ;


--○ 면접/코딩테스트 후기 테이블
DROP SEQUENCE BOARD_INTERVIEW_SEQ;


--○ 세미나 및 공모전 테이블
DROP SEQUENCE BOARD_SEMINAR_SEQ;


--○ 자유게시판 테이블
DROP SEQUENCE BOARD_FREE_SEQ;


--○ Q&A 질문 테이블
DROP SEQUENCE BOARD_QUESTION_SEQ;


--○ Q&A 답변 테이블
DROP SEQUENCE BOARD_ANSWER_SEQ;


--○ 스터디 후기 테이블
DROP SEQUENCE BOARD_STUDYREVIEW_SEQ;


--○ IT기술정보공유 댓글 테이블
DROP SEQUENCE COMMENT_INFORM_SEQ;


--○ 면접 및 코딩테스트 후기 댓글 테이블
DROP SEQUENCE COMMENT_INTERVIEW_SEQ;


--○ 세미나 및 공모전 댓글 테이블
DROP SEQUENCE COMMENT_SEMINAR_SEQ;


--○ 자유게시판 댓글 테이블
DROP SEQUENCE COMMENT_FREE_SEQ;


--○ Q&A 질문 댓글 테이블
DROP SEQUENCE COMMENT_QUESTION_SEQ;


--○ Q&A 답변 댓글 테이블
DROP SEQUENCE COMMENT_ANSWER_SEQ;


--○ 스터디 후기 댓글 테이블
DROP SEQUENCE COMMENT_STUDYREVIEW_SEQ;


--○ IT기술정보공유 추천/비추천 테이블
DROP SEQUENCE REC_INFORM_SEQ;


--○ 세미나 및 공모전 추천/비추천 테이블
DROP SEQUENCE REC_SEMINAR_SEQ;


--○ 면접/코딩테스트 후기 추천비추천 테이블
DROP SEQUENCE REC_INTERVIEW_SEQ;


--○ 자유게시판 추천비추천 테이블
DROP SEQUENCE REC_FREE_SEQ;


--○ Q&A 질문 추천비추천 테이블
DROP SEQUENCE REC_QUESTION_SEQ;


--○ Q&A 답변 추천비추천 테이블
DROP SEQUENCE REC_INFORM_SEQ;


--○ 스터디 후기 추천/ 비추천 테이블
DROP SEQUENCE REC_STUDYREVIEW_SEQ;


--○ IT기술정보공유 신고등록 테이블
DROP SEQUENCE RPT_RG_INFORM_SEQ;


--○ 면접/코딩테스트 후기  신고등록 테이블
DROP SEQUENCE RPT_RG_INTERVIEW_SEQ;


--○ 세미나 및 공모전  신고등록 테이블
DROP SEQUENCE RPT_RG_SEMINAR_SEQ;


--○ 자유게시판 신고등록 테이블
DROP SEQUENCE RPT_RG_FREE_SEQ;


--○ Q&A 질문 신고등록 테이블
DROP SEQUENCE RPT_RG_QUESTION_SEQ;


--○ Q&A 답변 신고등록 테이블
DROP SEQUENCE RPT_RG_ANSWER_SEQ;


--○ 스터디 후기 신고 등록
DROP SEQUENCE RPT_RG_STUDYREVIEW_SEQ;


--○ IT기술정보공유 신고처리 테이블
DROP SEQUENCE RPT_HD_INFORM_SEQ;


--○ 면접/코딩테스트 후기 신고처리 테이블
DROP SEQUENCE RPT_HD_INTERVIEW_SEQ;


--○ 세미나 및 공모전 신고처리 테이블
DROP SEQUENCE RPT_HD_SEMINAR_SEQ;


--○ 자유게시판 신고처리 테이블
DROP SEQUENCE RPT_HD_FREE_SEQ;


--○ Q&A 질문 신고처리 테이블
DROP SEQUENCE RPT_HD_QUESTION_SEQ;


--○ Q&A 답변 신고처리 테이블
DROP SEQUENCE RPT_HD_ANSWER_SEQ;


--○ 스터디 후기 신고 처리  
DROP SEQUENCE RPT_HD_STUDYREVIEW_SEQ;
  

--○ 실습 테이블 생성(신고 처리 테이블)
DROP SEQUENCE HD_RESULT_SEQ;


--○ 실습 테이블 생성(세미나 카테고리 테이블)
DROP SEQUENCE SEMI_CTG_SEQ;


--○ 실습 테이블 생성(게시글 신고 카테고리 테이블)
DROP SEQUENCE POST_RPT_CTG_SEQ;


--○ 회원 코드 생성 테이블
DROP SEQUENCE USER_CODE_CRE_SEQ;


--○ 회원 등록 테이블 
DROP SEQUENCE USER_REG_SEQ;


--○ 비밀번호 찾기 질문 테이블
DROP SEQUENCE PW_SRCH_QUE_SEQ;


--○ 현재 직업 대분류 테이블
DROP SEQUENCE JOB_LC_SEQ;


--○ 현재 직업 중분류 테이블
DROP SEQUENCE JOB_LC_SEQ;


--○ 계정 정지 등록 테이블
DROP SEQUENCE ACCT_SUS_SEQ;


--○ 탈퇴 기록 및 개인정보 보관 테이블
DROP SEQUENCE WDL_INFO_SEQ;


--○ 탈퇴 카테고리 테이블
DROP SEQUENCE WDL_CTG_SEQ;


-- ○ 직책 테이블
DROP SEQUENCE STUDY_POS_SEQ;


--○ 스터디 신청 테이블
DROP SEQUENCE STUDY_APL_SEQ;


--○ 스터디 취소 처리 테이블
DROP SEQUENCE STUDY_CANC_SEQ;


--○ 스터디 참가 테이블
DROP SEQUENCE STUDY_PARTI_SEQ;


--○ 스터디 컨텐츠 테이블
DROP SEQUENCE STUDY_CON_SEQ;


--○ 스터디 평가 테이블
DROP SEQUENCE STUDY_ASSE_SEQ;


--○ 출석부 테이블
DROP SEQUENCE STUDY_ATT_SEQ;


--○ 일정관리 테이블
DROP SEQUENCE STUDY_SCHE_SEQ;


--○ 외출등록 테이블
DROP SEQUENCE STUDY_STO_SEQ;


--○ 스터디원 평가 등록
DROP SEQUENCE STUDY_IASSE_SEQ;


--○ 평가점수 테이블
DROP SEQUENCE STUDY_ASSE_RESP_SEQ;


--○ 평가항목 테이블
DROP SEQUENCE STUDY_ASSE_ITM_SEQ;


--○ 점수 기록 테이블
DROP SEQUENCE STUDY_SCOR_SEQ;


--○ 경고 등록 테이블
DROP SEQUENCE STUDY_WARN_SEQ;


--○ 스터디 댓글 테이블
DROP SEQUENCE COMM_STD_SEQ;


-- ○ 스터디 신고 등록 테이블
DROP SEQUENCE STUDY_ACC_SEQ;


-- ○ 스터디 신고 처리 테이블
DROP SEQUENCE STUDY_ACC_HAN_SEQ;


-- ○ 스터디 경고 등록 테이블
DROP SEQUENCE STUDY_WAR_SEQ;


-- ○ 욕설 테이블
DROP SEQUENCE CURSE_SEQ;


-- ○ 고객센터(1:1문의) 테이블
DROP SEQUENCE ASK_SEQ;


-- ○ 고객센터(공지사항) 테이블
DROP SEQUENCE NOTICE_SEQ;


-- ○ 관리자 테이블
DROP SEQUENCE ADMIN_SEQ;


-- 추가
DROP SEQUENCE JOB_MC_SEQ;
DROP SEQUENCE REC_ANSWER_SEQ;
DROP SEQUENCE STD_MEETDAY_SEQ;
DROP SEQUENCE STUDY_SCORE_SEQ;
DROP SEQUENCE STUDY_ASSE_RESP_SEQ;

