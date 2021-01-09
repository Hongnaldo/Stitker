--���� ������� ����--

-- ���̺� �̸����� �������� ��ȸ
SELECT *
FROM ALL_CONSTRAINTS
WHERE OWNER = 'STITKER' AND TABLE_NAME = 'TBL_STUDY_APPLY'
ORDER BY TABLE_NAME;

-- ������ ����
PURGE RECYCLEBIN;


-- ���� ���̺� ����(��� ������.)
DROP TABLE TBL_STUDY_STEPOUT;

-- ���͵� �⼮ �ð� NOT NULL �������� ����.
-- ���͵� �⼮���̺� ���ᳯ¥������ ��� ȸ�� �ϴ� �� �μ�Ʈ�ϱ�� ��.
ALTER TABLE TBL_STUDY_ATTEND DROP CONSTRAINT SYS_C008005;

-- ���͵� ��û ��¥.
-- ���͵� Ȯ�� ��ư ���ȴ��� �ȴ��ȴ��� Ȯ���ϱ� ����.
ALTER TABLE TBL_STUDY_APPLY DROP CONSTRAINT SYS_C007764;


-- ���͵� ���࿡�� ��å �÷� ����
ALTER TABLE TBL_STUDY_PARTICIPANT DROP COLUMN POSITION_CODE;

-- ���͵� �������� ��å �÷� �߰�
ALTER TABLE TBL_STUDY_APPLY ADD (
    POSITION_CODE VARCHAR(5) NOT NULL
  , CONSTRAINT STUDY_APPLY_PC_FK FOREIGN KEY (POSITION_CODE)
            REFERENCES TBL_STUDY_POSITION (POSITION_CODE)
);

-- ��� ���̺� üũ �������� ����
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK BETWEEN 1 AND 6));

<<<<<<< HEAD
=======
<<<<<<< HEAD
-- Ż�� ī�װ� �׸� �÷����� ����(50 -> 150)
ALTER TABLE TBL_WITHDRAWAL_CATEGORY MODIFY(WDL_CTG VARCHAR2(150));
=======
<<<<<<< HEAD
>>>>>>> 50561ad211080c8ed4abc5a2b4811f9ce7db9e82
-- ��� ���̺� üũ �������� ����
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK BETWEEN 1 AND 6)
    , CONSTRAINT USER_RANK_MNS_CK CHECK(MIN_SCORE >= 0)
    , CONSTRAINT USER_RANK_MXS_CK CHECK(MAX_SCORE <= 18600 AND MAX_SCORE > MIN_SCORE));

-- �ο��� ���̺� üũ �������� ���� 
ALTER TABLE TBL_MEMNUM
ADD ( CONSTRAINT MEMNUM_CK CHECK(MEMNUM BETWEEN 3 AND 8));

-- ���͵�� �Ű�ī�װ� ���̺��� ī�װ� Į�� ������Ÿ�� ����(�ø�)
ALTER TABLE TBL_MEM_REPORT_CTG MODIFY MEM_REPORT_CTG VARCHAR2(50);

-- ���͵�� �Ű�ī�װ� ���̺��� �⺻Ű Į�� ������Ÿ�� ����(�ø�)
ALTER TABLE TBL_MEM_REPORT_CTG MODIFY MEM_REPORT_CTG_CODE VARCHAR2(5);

-- ���͵�� ó����� ���̺� �⺻Ű Į�� ������Ÿ�� ����(�ø�)
ALTER TABLE TBL_MEM_REPORT_HANDLE_RESULT MODIFY MEM_REPORT_HANDLE_RESULT_CODE VARCHAR2(5);
<<<<<<< HEAD

-- ���̳� �� ������ ���̺� ����������, ���������� �÷� �߰�
ALTER TABLE TBL_BOARD_SEMINAR ADD START_DATE DATE NOT NULL;
ALTER TABLE TBL_BOARD_SEMINAR ADD END_DATE DATE NOT NULL;
=======
>>>>>>> bd5f779ce9caa72b771bed7c3603226a9ca0e4fb
>>>>>>> 50561ad211080c8ed4abc5a2b4811f9ce7db9e82

--���͵�� �Ű�ó�� ���̺� Į�� ������Ÿ�� ����(�ø�
ALTER TABLE TBL_MEM_REPORT_HANDLE MODIFY HANDLE_RESULT VARCHAR2(5);
