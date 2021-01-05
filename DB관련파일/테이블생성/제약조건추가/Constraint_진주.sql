-- CK �������� ����_����

-- CK ǥ���� ���̺�鸸 �߰��Ǿ����ϴ�.

-- �߰� : �ο��� ���̺� �ο��� CK �������� �߰�
--        ��� ���̺� ��� CK �������� �߰�, �ְ������� ���������� CK �������� �߰�

/*

 �� ���� ���� ���̺�  -- CK
 �� ���� ���̺�
 �� �ο��� ���̺�     -- CK
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


--  �� �ο��� ���̺�
-- �ο����� 3�̻� 8���� �̾�� �Ѵ�.
ALTER TABLE TBL_MEMNUM
ADD ( CONSTRAINT MEMNUM_MN_CK CHECK(MEMNUM >=3 AND MEMNUM <=8 ));



-- �� ��� ���̺� üũ ��������
-- ����� 1~6, ���� ������ -4200�� �̻�, �ְ������� 21600���� + ���� ���� ���� Ŀ����
ALTER TABLE TBL_USER_RANK
ADD ( CONSTRAINT USER_RANK_RK_CK CHECK(RANK >=6 AND RANK<=1)
    , CONSTRAINT USER_RANK_MNS_CK CHECK(MIN_SCORE >= -4200)
    , CONSTRAINT USER_RANK_MXS_CK CHECK(MAX_SCORE <= 21600 AND MAX_SCORE > MIN_SCORE));

-- �� ���͵� ���� ���̺� üũ �������� 
-- �������� �ۼ��Ϸκ��� 10�� ���� 15�� �̳������Ѵ�.
ALTER TABLE TBL_STUDY_OPEN
ADD (CONSTRAINT STD_OPEN_SD_CK CHECK (START_DATE >= WRITE_DATE+10 AND START_DATE <= WRITE_DATE+15));
