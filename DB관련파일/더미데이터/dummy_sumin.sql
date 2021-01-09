    
-- 직책
INSERT INTO TBL_STUDY_POSITION(POSITION_CODE, POSITION)
    VALUES('SP'|| STUDY_POS_SEQ.NEXTVAL, '리더');
INSERT INTO TBL_STUDY_POSITION(POSITION_CODE, POSITION)
    VALUES('SP'|| STUDY_POS_SEQ.NEXTVAL, '스터디원');
--==>> 1 행 이(가) 삽입되었습니다. 
    
-- 평가 점수
INSERT INTO TBL_STUDY_ASSESS_RESP(RESP_CODE, RESP, SCORE)
    VALUES('AR'|| STUDY_ASSE_RESP_SEQ.NEXTVAL, '매우 그렇다.', 100);
INSERT INTO TBL_STUDY_ASSESS_RESP(RESP_CODE, RESP, SCORE)
    VALUES('AR'|| STUDY_ASSE_RESP_SEQ.NEXTVAL, '그렇다.', 80);
INSERT INTO TBL_STUDY_ASSESS_RESP(RESP_CODE, RESP, SCORE)
    VALUES('AR'|| STUDY_ASSE_RESP_SEQ.NEXTVAL, '보통이다.', 60);
INSERT INTO TBL_STUDY_ASSESS_RESP(RESP_CODE, RESP, SCORE)
    VALUES('AR'|| STUDY_ASSE_RESP_SEQ.NEXTVAL, '그렇지 않다.', 40);
INSERT INTO TBL_STUDY_ASSESS_RESP(RESP_CODE, RESP, SCORE)
    VALUES('AR'|| STUDY_ASSE_RESP_SEQ.NEXTVAL, '매우 그렇지 않다.', 20);
--==>> 1 행 이(가) 삽입되었습니다. * 5
    
-- 평가 항목
INSERT INTO TBL_STUDY_ASSESS_ITEM(ITEM_CODE, ITEM)
    VALUES('AI'|| STUDY_ASSE_ITM_SEQ.NEXTVAL, '해당 참가자는 과제 등 자신의 할 일을 성실히 수행했나요?');
INSERT INTO TBL_STUDY_ASSESS_ITEM(ITEM_CODE, ITEM)
    VALUES('AI'|| STUDY_ASSE_ITM_SEQ.NEXTVAL, '해당 참가자는 스터디원들을 배려하며 원활한 소통을 위해 노력했나요?');
INSERT INTO TBL_STUDY_ASSESS_ITEM(ITEM_CODE, ITEM)
    VALUES('AI'|| STUDY_ASSE_ITM_SEQ.NEXTVAL, '해당 참가자는 스터디 활동에 능동적으로 참여했나요?');    
--==>> 1 행 이(가) 삽입되었습니다. * 3


-------------------------------------------------------------------------------------------------------------------------
INSERT INTO TBL_REPORT_HANDLE_INFORM(REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE, HANDLE_DATE) 
VALUES ('HI'||RPT_HD_INFORM_SEQ.NEXTVAL, 'GI5', 'DR1', SYSDATE); 
INSERT INTO TBL_REPORT_HANDLE_INTERVIEW(REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE, HANDLE_DATE) 
VALUES ('HV'||RPT_HD_INTERVIEW_SEQ.NEXTVAL, 'GV5', 'DR1', SYSDATE);
INSERT INTO TBL_REPORT_HANDLE_SEMINAR(REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE, HANDLE_DATE) 
VALUES ('HS'||RPT_HD_SEMINAR_SEQ.NEXTVAL, 'GS5', 'DR4', SYSDATE); 
INSERT INTO TBL_REPORT_HANDLE_QUESTION(REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE, HANDLE_DATE) 
VALUES ('HQ'||RPT_HD_QUESTION_SEQ.NEXTVAL, 'GQ5', 'DR4', SYSDATE);
INSERT INTO TBL_REPORT_HANDLE_STUDYREVIEW(REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE, HANDLE_DATE) 
VALUES ('HR'||RPT_HD_STUDYREVIEW_SEQ.NEXTVAL, 'GR5', 'DR4', SYSDATE); 

-- 경고 등록(4) - 3개-> 계정정지에 INSERT 되는지 확인
INSERT INTO TBL_WARNING(WARNING_CODE, WARNING_DATE, USER_CODE)
    VALUES('WR'|| STUDY_WARN_SEQ.NEXTVAL, SYSDATE, 'UC7');
INSERT INTO TBL_WARNING(WARNING_CODE, WARNING_DATE, USER_CODE)
    VALUES('WR'|| STUDY_WARN_SEQ.NEXTVAL, SYSDATE, 'UC7');
INSERT INTO TBL_WARNING(WARNING_CODE, WARNING_DATE, USER_CODE)
    VALUES('WR'|| STUDY_WARN_SEQ.NEXTVAL, SYSDATE, 'UC7');    
    
-- 스터디 댓글(5)
INSERT INTO TBL_COMMENT_STUDY(COMMENT_CODE, STUDY_CODE, COMMENTS, USER_CODE, WRITE_DATE)
    VALUES('SM'|| COMM_STD_SEQ.NEXTVAL, 스터디코드, '1시간만 당겨주시면 안될까요?', 'UC1', SYSDATE);
    
-- 스터디 신청(5)
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디1, 'UC1', 개설날짜, 'SP1');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디1, 'UC2', 개설날짜+1, 'SP2');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디1, 'UC3', 개설날짜+3, 'SP2');   
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디1, 'UC4', 개설날짜+3, 'SP2');    
    
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디2, 'UC5', 개설날짜, 'SP1');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디2, 'UC1', 개설날짜+1, 'SP2');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디2, 'UC3', 개설날짜+2, 'SP2');    
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디2, 'UC6', 개설날짜+4, 'SP2');
INSERT INTO TBL_STUDY_APPLY(APPLY_CODE, STUDY_CODE, USER_CODE, APPLY_DATE, POSITION_CODE)
    VALUES('SA'|| STUDY_APL_SEQ.NEXTVAL, 스터디2, 'UC7', 개설날짜+4, 'SP2');    
    
-- 스터디 취소처리(6)
-- 패널티 확인하기
INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
    VALUES('SC'|| STUDY_CANC_SEQ.NEXTVAL, 'SA4', 스터디시작날짜-2일);
INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
    VALUES('SC'|| STUDY_CANC_SEQ.NEXTVAL, 'SA9', 스터디시작날짜-2일); 
--※ 스터디2의 사용자3과 사용자7은 자동으로 인서트되어야 함.    
    
    
-- 스터디 진행(6) -- 이거 넣으면 취소처리에 인서트되는지 확인하기
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA1');    
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA2'); 
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA3');     

      --사용자코드5,1,6
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA5');
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA6'); 
INSERT INTO TBL_STUDY_PARTICIPANT(PARTI_CODE, APPLY_CODE)
    VALUES('PT'|| STUDY_PARTI_SEQ.NEXTVAL, 'SA8');     

-- 스터디 컨텐츠(7)
INSERT INTO TBL_STUDY_CONTENT(CONTENT_CODE, PARTI_CODE, WRITE_DATE, HITCOUNT, TITLE, CONTENT)
    VALUES('CT'|| STUDY_CON_SEQ.NEXTVAL, 'PT1', 시작일-2, 0, '처음 오실 때 준비하실 것', '노트북챙겨오세요. 자기소개도 할거니까 미리 생각해오면 좋겠습니다.');
INSERT INTO TBL_STUDY_CONTENT(CONTENT_CODE, PARTI_CODE, WRITE_DATE, HITCOUNT, TITLE, CONTENT)
    VALUES('CT'|| STUDY_CON_SEQ.NEXTVAL, 'PT2', 시작일+10, 0, '오늘공부한거정리해봤어요.', 'PROGRAMMER_A.TSTORY.COM/오늘공부 ←이 링크로 오시면 됩니다.');
    
INSERT INTO TBL_STUDY_CONTENT(CONTENT_CODE, PARTI_CODE, WRITE_DATE, HITCOUNT, TITLE, CONTENT)
    VALUES('CT'|| STUDY_CON_SEQ.NEXTVAL, 'PT4', 시작일+4, 0, '처음올리네요', '스터디리더인데 이제야 처음 올리네요..ㅠㅠ 다음시간까지 이거랑 저거랑 공부할테니 예습 해옵시다!');    
INSERT INTO TBL_STUDY_CONTENT(CONTENT_CODE, PARTI_CODE, WRITE_DATE, HITCOUNT, TITLE, CONTENT)
    VALUES('CT'|| STUDY_CON_SEQ.NEXTVAL, 'PT6', 시작일+7, 0, '안녕하세요', '여기 제가 발견한 사이트인데 너무 좋아요. 한 번 둘러보세요. WWW.STUDY_IT.COM');
    
    
-- 스터디 평가(7)
INSERT INTO TBL_STUDY_ASSESS(ASSESS_CODE, PARTI_CODE, SCORE, ASSESS_DATE)
    VALUES('AS'|| STUDY_ASSE_SEQ.NEXTVAL, 'PT1', 5, 종료날짜+1);
INSERT INTO TBL_STUDY_ASSESS(ASSESS_CODE, PARTI_CODE, SCORE, ASSESS_DATE)
    VALUES('AS'|| STUDY_ASSE_SEQ.NEXTVAL, 'PT2', 4.5, 종료날짜+1);
INSERT INTO TBL_STUDY_ASSESS(ASSESS_CODE, PARTI_CODE, SCORE, ASSESS_DATE)
    VALUES('AS'|| STUDY_ASSE_SEQ.NEXTVAL, 'PT3', 4, 종료날짜+1);    
    
-- 출석부(7) - 스터디1(월/수 총4회) - 3번 지각1,결석1-4회모두완료. 
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT1', 1회, 시작시간, NULL);
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT1', 2회, 시작시간, 종료);
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT1', 3회, 시작시간, 종료);    
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT1', 4회, 시작시간, 종료);
    
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT2', 1회, 시작시간, 종료);
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT2', 2회, 시작시간, 종료);    
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT2', 3회, 시작시간, 종료);
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT2', 4회, 시작시간, 종료);
    
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT3', 1회, 시작시간, 종료);
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT3', 3회, 시작시간+30분, NULL);
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT3', 4회, 시작시간, 종료);    

---------------스터디2(화, 총2회) - 6번이 한 번 조퇴, 1회만진행함.    
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT4', 1회, 시작시간, 종료);    
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT5', 1회, 시작시간, 종료); 
INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE, CLOCK_IN, CLOCK_OUT)
    VALUES('AT'|| STUDY_ATT_SEQ.NEXTVAL, 'PT6', 1회, 시작시간, NULL);     

-- 종료시간 업데이트
-----정상종료(점수 안깎여야 함.)
UPDATE TBL_STUDY_ATTEND
SET CLOCK_OUT = 종료시간
WHERE ATTEND_CODE = 'AT1';
-----조퇴(5점 감점 업데이트 되어야 함.)
UPDATE TBL_STUDY_ATTEND
SET CLOCK_OUT = 종료시간
WHERE ATTEND_CODE = 'AT10';
-----지각(5점 감점 업데이트 되어야 함.)
UPDATE TBL_STUDY_ATTEND
SET CLOCK_OUT = 종료시간-30분
WHERE ATTEND_CODE = 'AT14';




    
-- 스터디원평가등록(7) -- 3명 중 1은 다 함. 2는 다 안함. 3은 아예 안했지만 점수가 음수.
-- 이거 넣어보고 1과 3에게만 점수 반영되는지 확인.
--종료된스터디에서 1(두명분)
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT1', 'AR1', 'AI1', 'PT2', 종료날짜+1);
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT1', 'AR1', 'AI2', 'PT2', 종료날짜+1);
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT1', 'AR1', 'AI3', 'PT2', 종료날짜+1);   
    
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT1', 'AR5', 'AI1', 'PT3', 종료날짜+1);
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT1', 'AR4', 'AI2', 'PT3', 종료날짜+1);
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT1', 'AR4', 'AI3', 'PT3', 종료날짜+1);       

--2번은 3번에 대해서만 평가.
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT2', 'AR5', 'AI1', 'PT3', 종료날짜+1);
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT2', 'AR4', 'AI2', 'PT3', 종료날짜+1);
INSERT INTO TBL_STUDY_INTERASSESS(INTERASSESS_CODE, PARTI_CODE, RESP_CODE, ITEM_CODE, PARTI_ASSESSED_CODE, INTERASSESS_DATE)
    VALUES('IA'|| STUDY_IASSE_SEQ.NEXTVAL, 'PT2', 'AR4', 'AI3', 'PT3', 종료날짜+1);           


-- 점수 기록(8) --> 글 인서트 될 때 자동 인서트.
INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'|| STUDY_SCOR_SEQ.NEXTVAL, 유저코드, 점수, 시간);




    
-- 외출등록(보류)
INSERT INTO TBL_STUDY_STEPOUT(ATTEND_CODE, CLOCK_IN, CLOCK_OUT)
    VALUES('SO'|| STUDY_STO_SEQ.NEXTVAL, 외출시작, 종료시간);
-- 일정관리(보류)
INSERT INTO TBL_STUDY_SCHEDULE(ATTEND_CODE, SCHEDULE)
    VALUES('SC'|| STUDY_SCHE_SEQ.NEXTVAL, '자바 반복문까지');
  
  

  