-- ���� C ����̺꿡 StitkerData ���� ����� ����.

-- ���̺����̽� ����
CREATE TABLESPACE TBS_STITKER
DATAFILE 'C:\StitkerData\TBS_STITKER01.DBF'
SIZE 30M
AUTOEXTEND ON NEXT 10M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

-- ����� ���� ����(�̸� : stitker, ��� : java006$, ���̺����̽� : TBS_STITKER)
CREATE USER stitker IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_STITKER;

-- ���� ���� ���� �ο�
GRANT CREATE SESSION TO STITKER;

-- ���̺� ���� ���� �ο�
GRANT CREATE TABLE TO STITKER;

-- ���̺����̽� �Ҵ緮 �ο�(�뷮����X)
ALTER USER STITKER
QUOTA UNLIMITED ON TBS_STITKER;

-- ������ ���� ���� �ο�
GRANT CREATE SEQUENCE TO STITKER;

-- �� ���� ���� �ο�
GRANT CREATE VIEW TO STITKER;

-- ���ν��� ���� ���� �ο�
GRANT CREATE PROCEDURE TO STITKER;

-- Ʈ���� ���� ���� �ο�
GRANT CREATE TRIGGER TO STITKER;









