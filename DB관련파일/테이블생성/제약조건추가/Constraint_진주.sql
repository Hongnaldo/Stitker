-- CK �������� ����_����

-- CK ǥ���� ���̺�鸸 �߰��Ǿ����ϴ�.

/*

 �� ���� ���� ���̺�  -- CK
 �� ���� ���̺�
 �� �ο��� ���̺�
 �� ��� ���̺�       -- CK
 �� ���͵� ���� ���̺�
 �� ���ɺо� ��з� ���̺�
 �� ���ɺо� �ߺз� ���̺�
 �� ���� ��з� ���̺�
 �� ���� �ߺз� ���̺�
 �� ���͵� ���� ���̺�   -- CK

     
*/

-- �� ���� ���� ���̺� üũ ���� ����
-- ���� �ð��� 0�̻� 24����
-- ���ð��� 0�̻� 24���� AND ���ð��� ���� �ð����� Ŀ���Ѵ�.
ALTER TABLE TBL_STUDY_MEETDAY
ADD ( CONSTRAINT STD_MEETDAY_ST_CK CHECK(START_TIME BETWEEN 0 AND 24)
    , CONSTRAINT STD_MEETDAY_ET_CK CHECK(END_TIME BETWEEN 0 AND 24 AND END_TIME>START_TIME));

-- �� ��� ���̺� üũ ��������
-- ����� �ְ� ������ �ּ� �������� Ŀ���Ѵ�.
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_MS_CK CHECK(MAX_SCORE > MIN_SCORE));

-- �� ���͵� ���� ���̺� üũ �������� 
-- �������� �ۼ��Ϸκ��� 10�� ���� 15�� �̳������Ѵ�.
ALTER TABLE TBL_STUDY_OPEN
ADD (CONSTRAINT STD_OPEN_SD_CK CHECK (START_DATE >= WRITE_DATE+10 AND START_DATE <= WRITE_DATE+15));
