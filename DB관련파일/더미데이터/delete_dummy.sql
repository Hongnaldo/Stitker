--■■■ 데이터 삭제 ■■■

--8. 그 다음 순서

  -- 스터디 일정 관리
DELETE
FROM TBL_STUDY_SCHEDULE;

  -- 스터디원 신고 처리
DELETE
FROM TBL_MEM_REPORT_HANDLE;

  -- 내보내기 처리
DELETE
FROM TBL_MEM_KICK_HANDLE;


--7. 그 다음 순서
  -- 스터디 컨텐츠 등록
DELETE
FROM TBL_STUDY_CONTENT;

  -- 스터디 평가 등록
DELETE
FROM TBL_STUDY_ASSESS;

  -- 출석부
DELETE
FROM TBL_STUDY_ATTEND;

  -- 스터디원 평가 등록
DELETE
FROM TBL_STUDY_INTERASSESS;

  -- 스터디원 신고 등록
DELETE
FROM TBL_MEM_REPORT_REG;

  -- 내보내기 등록
DELETE
FROM TBL_MEM_KICK_REG;


--6. 그 다음 순서
  -- 스터디 신고 처리
DELETE
FROM TBL_STUDY_ACCUSE_HANDLE;

  -- 스터디 취소 처리
DELETE
FROM TBL_STUDY_CANCEL;

  -- 스터디 진행
DELETE
FROM TBL_STUDY_PARTICIPANT;

  -- Q&A 답변 댓글 등록
DELETE
FROM TBL_COMMENT_ANSWER;

  -- Q&A 답변 추천/비추천 등록
DELETE
FROM TBL_REC_ANSWER;

  -- 기술정보공유 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_INFORM;

  -- 면접,코딩테스트 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_INTERVIEW;

  -- 세미나, 공모전 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_SEMINAR;

  -- 자유게시판 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_FREE;

  -- Q&A질문 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_QUESTION;

  -- Q&A답변 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_ANSWER;

  -- 스터디 후기 신고 처리
DELETE
FROM TBL_REPORT_HANDLE_STUDYREVIEW;

 -- 스터디 댓글 테이블
DELETE
FROM TBL_COMMENT_STUDY;



--5. 그 다음 순서
  -- 계정 정지 등록
DELETE
FROM TBL_ACCOUNT_SUSPEND;

  -- 진행 요일
DELETE
FROM TBL_STUDY_MEETDAY;

-- 모임 요일 테이블 제약 외래키 조건         
DELETE
FROM TBL_STUDY_MEETDAY;         

  -- 스터디 신고 등록
DELETE
FROM TBL_STUDY_ACCUSE;

  -- 스터디 참여 신청
DELETE
FROM TBL_STUDY_APPLY;

  -- it,기술정보 댓글 등록
DELETE
FROM TBL_COMMENT_INFORM;

  -- 면접, 코딩테스트 댓글 등록
DELETE
FROM TBL_COMMENT_INTERVIEW;

  -- 세미나, 공모전 댓글 등록
DELETE
FROM TBL_COMMENT_SEMINAR;

  -- 자유게시판 댓글 등록
DELETE
FROM TBL_COMMENT_FREE;

  -- Q&A 질문 댓글 등록
DELETE
FROM TBL_COMMENT_QUESTION;

  -- 스터디 후기 댓글 등록
DELETE
FROM TBL_COMMENT_STUDYREVIEW;

  -- Q&A 답변
DELETE
FROM TBL_BOARD_ANSWER;

  -- It, 기술정보 추천/비추천 등록
DELETE
FROM TBL_REC_INFORM;

  -- 면접, 코딩테스트 추천/ 비추천 등록
DELETE
FROM TBL_REC_INTERVIEW;

  -- 세미나,공모전 추천/비추천 등록
DELETE
FROM TBL_REC_SEMINAR;

  -- 자유게시판 추천/비추천 등록
DELETE
FROM TBL_REC_FREE;

  -- Q&A 질문 추천/비추천 등록
DELETE
FROM TBL_REC_QUESTION;

  -- 스터디 후기 추천/ 비추천 테이블
DELETE
FROM TBL_REC_STUDYREVIEW;

  -- 기술정보공유 신고 등록
DELETE
FROM TBL_REPORT_REG_INFORM;

  -- 면접,코딩테스트 신고 등록
DELETE
FROM TBL_REPORT_REG_INTERVIEW;

  -- 세미나, 공모전 신고 등록
DELETE
FROM TBL_REPORT_REG_SEMINAR;

  -- 자유게시판 신고 등록
DELETE
FROM TBL_REPORT_REG_FREE;

  -- Q&A질문 신고 등록
DELETE
FROM TBL_REPORT_REG_QUESTION;

  -- Q&A답변 신고 등록
DELETE
FROM TBL_REPORT_REG_ANSWER;

  -- 스터디 후기 신고 등록
DELETE
FROM TBL_REPORT_REG_STUDYREVIEW;



--4. 그 다음 순서
  -- 고객센터(1:1 문의)
DELETE
FROM TBL_ASK;

  -- 탈퇴 기록 및 개인정보 보관
DELETE
FROM TBL_WITHDRAWAL_INFO;

  -- 경고등록
DELETE
FROM TBL_WARNING;

  -- 점수 기록
DELETE
FROM TBL_SCORE;

  -- 스터디 개설
DELETE
FROM TBL_STUDY_OPEN;

-- 스터디 개설 테이블 외래키제약 조건
DELETE
FROM TBL_STUDY_OPEN;

  -- it, 기술정보공유
DELETE
FROM TBL_BOARD_INFORM;

  -- 면접,코딩테스트 후기
DELETE
FROM TBL_BOARD_INTERVIEW;

  -- 세미나,공모전
DELETE
FROM TBL_BOARD_SEMINAR;

  -- 자유게시판
DELETE
FROM TBL_BOARD_FREE;

  -- Q&A질문
DELETE
FROM TBL_BOARD_QUESTION;

  -- 스터디 후기 테이블
DELETE
FROM TBL_BOARD_STUDYREVIEW;


--3. 위 테이블들의 pk를 fk로 갖고있는 테이블
  -- 회원등록(사용자코드)
DELETE
FROM TBL_USER_REGISTER;



--2. 위 테이블의 pk를 fk로 갖고있는 테이블
  -- 관심분야 중분류 
DELETE
FROM TBL_INTEREST_MC;

  -- 지역 중분류
DELETE
FROM TBL_LOC_MC;

  -- 현재직업 중분류
DELETE
FROM TBL_JOB_MC;

  -- 고객센터(공지사항)
DELETE
FROM TBL_NOTICE;



--1. FK가 없는 테이블
  -- 회원코드생성
DELETE
FROM TBL_USER_CODE_CREATE;

  -- 스터디 유형
DELETE
FROM TBL_STUDY_TYPE;

  -- 관심분야 대분류
DELETE
FROM TBL_INTEREST_LC;

  -- 지역대분류
DELETE
FROM TBL_LOC_LC;

  -- 현재직업 대분류
DELETE
FROM TBL_JOB_LC;

  -- 요일
DELETE
FROM TBL_WEEKDAY;

  -- 인원수
DELETE
FROM TBL_MEMNUM;
  
  -- 등급
DELETE
FROM TBL_USER_RANK;

  -- 직책
DELETE
FROM TBL_STUDY_POSITION;

  -- 스터디원신고카테고리
DELETE
FROM TBL_MEM_REPORT_CTG;

  -- 스터디원신고처리결과
DELETE
FROM TBL_MEM_REPORT_HANDLE_RESULT;

  -- 탈퇴 카테고리
DELETE
FROM TBL_WITHDRAWAL_CATEGORY;

  -- 욕설 등록
DELETE
FROM TBL_CURSE;

  -- 말머리(세미나,공모전)
DELETE
FROM TBL_SEMINAR_CATEGORY;

  -- 게시물신고카테고리
DELETE
FROM TBL_POST_REPORT_CTG;

  -- 게시물 신고 처리결과
DELETE
FROM TBL_HANDLE_RESULT;

  -- 관리자
DELETE
FROM TBL_ADMIN;

  -- 평가점수
DELETE
FROM TBL_STUDY_ASSESS_RESP;

  -- 평가항목
DELETE
FROM TBL_STUDY_ASSESS_ITEM;

  -- 비밀번호 찾기 질문
DELETE
FROM TBL_PW_SEARCH_QUE;


COMMIT;
