--���� ������ ���� ����

--8. �� ���� ����

  -- ���͵� ���� ����
DELETE
FROM TBL_STUDY_SCHEDULE;

  -- ���͵�� �Ű� ó��
DELETE
FROM TBL_MEM_REPORT_HANDLE;

  -- �������� ó��
DELETE
FROM TBL_MEM_KICK_HANDLE;


--7. �� ���� ����
  -- ���͵� ������ ���
DELETE
FROM TBL_STUDY_CONTENT;

  -- ���͵� �� ���
DELETE
FROM TBL_STUDY_ASSESS;

  -- �⼮��
DELETE
FROM TBL_STUDY_ATTEND;

  -- ���͵�� �� ���
DELETE
FROM TBL_STUDY_INTERASSESS;

  -- ���͵�� �Ű� ���
DELETE
FROM TBL_MEM_REPORT_REG;

  -- �������� ���
DELETE
FROM TBL_MEM_KICK_REG;


--6. �� ���� ����
  -- ���͵� �Ű� ó��
DELETE
FROM TBL_STUDY_ACCUSE_HANDLE;

  -- ���͵� ��� ó��
DELETE
FROM TBL_STUDY_CANCEL;

  -- ���͵� ����
DELETE
FROM TBL_STUDY_PARTICIPANT;

  -- Q&A �亯 ��� ���
DELETE
FROM TBL_COMMENT_ANSWER;

  -- Q&A �亯 ��õ/����õ ���
DELETE
FROM TBL_REC_ANSWER;

  -- ����������� �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_INFORM;

  -- ����,�ڵ��׽�Ʈ �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_INTERVIEW;

  -- ���̳�, ������ �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_SEMINAR;

  -- �����Խ��� �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_FREE;

  -- Q&A���� �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_QUESTION;

  -- Q&A�亯 �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_ANSWER;

  -- ���͵� �ı� �Ű� ó��
DELETE
FROM TBL_REPORT_HANDLE_STUDYREVIEW;

 -- ���͵� ��� ���̺�
DELETE
FROM TBL_COMMENT_STUDY;



--5. �� ���� ����
  -- ���� ���� ���
DELETE
FROM TBL_ACCOUNT_SUSPEND;

  -- ���� ����
DELETE
FROM TBL_STUDY_MEETDAY;

-- ���� ���� ���̺� ���� �ܷ�Ű ����         
DELETE
FROM TBL_STUDY_MEETDAY;         

  -- ���͵� �Ű� ���
DELETE
FROM TBL_STUDY_ACCUSE;

  -- ���͵� ���� ��û
DELETE
FROM TBL_STUDY_APPLY;

  -- it,������� ��� ���
DELETE
FROM TBL_COMMENT_INFORM;

  -- ����, �ڵ��׽�Ʈ ��� ���
DELETE
FROM TBL_COMMENT_INTERVIEW;

  -- ���̳�, ������ ��� ���
DELETE
FROM TBL_COMMENT_SEMINAR;

  -- �����Խ��� ��� ���
DELETE
FROM TBL_COMMENT_FREE;

  -- Q&A ���� ��� ���
DELETE
FROM TBL_COMMENT_QUESTION;

  -- ���͵� �ı� ��� ���
DELETE
FROM TBL_COMMENT_STUDYREVIEW;

  -- Q&A �亯
DELETE
FROM TBL_BOARD_ANSWER;

  -- It, ������� ��õ/����õ ���
DELETE
FROM TBL_REC_INFORM;

  -- ����, �ڵ��׽�Ʈ ��õ/ ����õ ���
DELETE
FROM TBL_REC_INTERVIEW;

  -- ���̳�,������ ��õ/����õ ���
DELETE
FROM TBL_REC_SEMINAR;

  -- �����Խ��� ��õ/����õ ���
DELETE
FROM TBL_REC_FREE;

  -- Q&A ���� ��õ/����õ ���
DELETE
FROM TBL_REC_QUESTION;

  -- ���͵� �ı� ��õ/ ����õ ���̺�
DELETE
FROM TBL_REC_STUDYREVIEW;

  -- ����������� �Ű� ���
DELETE
FROM TBL_REPORT_REG_INFORM;

  -- ����,�ڵ��׽�Ʈ �Ű� ���
DELETE
FROM TBL_REPORT_REG_INTERVIEW;

  -- ���̳�, ������ �Ű� ���
DELETE
FROM TBL_REPORT_REG_SEMINAR;

  -- �����Խ��� �Ű� ���
DELETE
FROM TBL_REPORT_REG_FREE;

  -- Q&A���� �Ű� ���
DELETE
FROM TBL_REPORT_REG_QUESTION;

  -- Q&A�亯 �Ű� ���
DELETE
FROM TBL_REPORT_REG_ANSWER;

  -- ���͵� �ı� �Ű� ���
DELETE
FROM TBL_REPORT_REG_STUDYREVIEW;



--4. �� ���� ����
  -- ������(1:1 ����)
DELETE
FROM TBL_ASK;

  -- Ż�� ��� �� �������� ����
DELETE
FROM TBL_WITHDRAWAL_INFO;

  -- �����
DELETE
FROM TBL_WARNING;

  -- ���� ���
DELETE
FROM TBL_SCORE;

  -- ���͵� ����
DELETE
FROM TBL_STUDY_OPEN;

-- ���͵� ���� ���̺� �ܷ�Ű���� ����
DELETE
FROM TBL_STUDY_OPEN;

  -- it, �����������
DELETE
FROM TBL_BOARD_INFORM;

  -- ����,�ڵ��׽�Ʈ �ı�
DELETE
FROM TBL_BOARD_INTERVIEW;

  -- ���̳�,������
DELETE
FROM TBL_BOARD_SEMINAR;

  -- �����Խ���
DELETE
FROM TBL_BOARD_FREE;

  -- Q&A����
DELETE
FROM TBL_BOARD_QUESTION;

  -- ���͵� �ı� ���̺�
DELETE
FROM TBL_BOARD_STUDYREVIEW;


--3. �� ���̺���� pk�� fk�� �����ִ� ���̺�
  -- ȸ�����(������ڵ�)
DELETE
FROM TBL_USER_REGISTER;



--2. �� ���̺��� pk�� fk�� �����ִ� ���̺�
  -- ���ɺо� �ߺз� 
DELETE
FROM TBL_INTEREST_MC;

  -- ���� �ߺз�
DELETE
FROM TBL_LOC_MC;

  -- �������� �ߺз�
DELETE
FROM TBL_JOB_MC;

  -- ������(��������)
DELETE
FROM TBL_NOTICE;



--1. FK�� ���� ���̺�
  -- ȸ���ڵ����
DELETE
FROM TBL_USER_CODE_CREATE;

  -- ���͵� ����
DELETE
FROM TBL_STUDY_TYPE;

  -- ���ɺо� ��з�
DELETE
FROM TBL_INTEREST_LC;

  -- ������з�
DELETE
FROM TBL_LOC_LC;

  -- �������� ��з�
DELETE
FROM TBL_JOB_LC;

  -- ����
DELETE
FROM TBL_WEEKDAY;

  -- �ο���
DELETE
FROM TBL_MEMNUM;
  
  -- ���
DELETE
FROM TBL_USER_RANK;

  -- ��å
DELETE
FROM TBL_STUDY_POSITION;

  -- ���͵���Ű�ī�װ�
DELETE
FROM TBL_MEM_REPORT_CTG;

  -- ���͵���Ű�ó�����
DELETE
FROM TBL_MEM_REPORT_HANDLE_RESULT;

  -- Ż�� ī�װ�
DELETE
FROM TBL_WITHDRAWAL_CATEGORY;

  -- �弳 ���
DELETE
FROM TBL_CURSE;

  -- ���Ӹ�(���̳�,������)
DELETE
FROM TBL_SEMINAR_CATEGORY;

  -- �Խù��Ű�ī�װ�
DELETE
FROM TBL_POST_REPORT_CTG;

  -- �Խù� �Ű� ó�����
DELETE
FROM TBL_HANDLE_RESULT;

  -- ������
DELETE
FROM TBL_ADMIN;

  -- ������
DELETE
FROM TBL_STUDY_ASSESS_RESP;

  -- ���׸�
DELETE
FROM TBL_STUDY_ASSESS_ITEM;

  -- ��й�ȣ ã�� ����
DELETE
FROM TBL_PW_SEARCH_QUE;


COMMIT;
