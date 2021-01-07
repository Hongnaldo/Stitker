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