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