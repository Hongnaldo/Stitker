--���� ������(SEQUENCE) ���� ����--
--�ؽ������̸� : ���̺������_SEQ

-- ������ ��ȸ
SELECT *
FROM USER_SEQUENCES;

-- �� ���͵� �Ű� ��� ���̺�
CREATE SEQUENCE STUDY_ACC_SEQ
NOCACHE;

-- �� ���͵� �Ű� ó�� ���̺�
CREATE SEQUENCE STUDY_ACC_HAN_SEQ
NOCACHE;

-- �� ���͵� ��� ��� ���̺�
CREATE SEQUENCE STUDY_WAR_SEQ
NOCACHE;

-- �� �弳 ���̺�
CREATE SEQUENCE CURSE_SEQ
NOCACHE;

-- �� ������(1:1����) ���̺�
CREATE SEQUENCE ASK_SEQ
NOCACHE;

-- �� ������(��������) ���̺�
CREATE SEQUENCE NOTICE_SEQ
NOCACHE;

-- �� ������ ���̺�
CREATE SEQUENCE ADMIN_SEQ
NOCACHE;
--==>>
/*
Sequence STUDY_ACC_SEQ��(��) �����Ǿ����ϴ�.


Sequence STUDY_ACC_HAN_SEQ��(��) �����Ǿ����ϴ�.


Sequence STUDY_WAR_SEQ��(��) �����Ǿ����ϴ�.


Sequence CURSE_SEQ��(��) �����Ǿ����ϴ�.


Sequence ASK_SEQ��(��) �����Ǿ����ϴ�.


Sequence NOTICE_SEQ��(��) �����Ǿ����ϴ�.


Sequence ADMIN_SEQ��(��) �����Ǿ����ϴ�.
*/