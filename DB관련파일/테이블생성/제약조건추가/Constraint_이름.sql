--�� ���̺��, CK/UK �߰�
--����)
ALTER TABLE TBL_��¼��
ADD( CONSTRAINT ��¼��_�÷�_CK CHECK (�÷��� > 100 AND �÷��� < 200)
   , CONSTRAINT ��¼��_�÷�_UK UNIQUE (�÷���)
);