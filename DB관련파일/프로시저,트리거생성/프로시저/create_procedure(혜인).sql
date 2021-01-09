--���� ���ν���(PROCEDURE) ���� ����--


DESC TBL_STUDY_OPEN;
DESC TBL_STUDY_MEETDAY;


--���ڵ尡 ������� ������ŭ
--������Ͽ� �μ�Ʈ�� Ʈ����

    --���͵𰳼�/������� �μ�Ʈ ���ν��� 
/*---------------------------------------------------------------
 ���� �μ�Ʈ ���ν����� ������� �ߴµ�, �׷��� �ϴϱ� �������
 �μ�Ʈ �� �� ���͵𰳼��� ���͵� �ڵ带 �޾ƿ� ����� �𸣰���..
 �׷��� ����ο��� V_STUDY_CODE�� �������� ����� ���͵� �ڵ带
 ���, �� V_STUDY_CODE�� ���͵𰳼��� ������Ͽ� ���� �μ�Ʈ ��Ŵ
 
 �̷��� �ؾ� �� �� ���Ƽ� �� �ôµ�.. �ѹ� ������ ���� �����ؾ�
 �� ���� ������ �˷� �ּ���!
 
 -----------��������----------------------------------------------
 - ���͵� ���¿� �μ�Ʈ�Ǵ� ���ν���1
 - �Ե��̿� �μ�Ʈ�Ǵ� ���ν���2(���͵��ڵ� �Ű������� �޾Ƽ� ó��)
 �� Ʈ���ſ� ���� ���� �ٲ� ������ �����ϱ�.
---------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE STD_MEETDAY_INSERT
( V_STUDY_NAME              IN TBL_STUDY_OPEN.STUDY_NAME%TYPE       -- ���͵� �̸�
, V_STUDY_DESC              IN TBL_STUDY_OPEN.STUDY_DESC%TYPE       -- ���͵� ����
, V_INTEREST_MC_CODE        IN TBL_STUDY_OPEN.INTEREST_MC_CODE%TYPE -- ���͵� ī�װ�
, V_STUDY_TYPE_CODE         IN TBL_STUDY_OPEN.STUDY_TYPE_CODE%TYPE  -- ���͵� ����
, V_START_DATE              IN TBL_STUDY_OPEN.START_DATE%TYPE       -- ���͵� ���� ��¥
, V_END_DATE                IN TBL_STUDY_OPEN.END_DATE%TYPE         -- ���͵� ���� ��¥
, V_LOC_MC_CODE             IN TBL_STUDY_OPEN.LOC_MC_CODE%TYPE      -- ����
, V_MIN_MEM_CODE            IN TBL_STUDY_OPEN.MIN_MEM_CODE%TYPE     -- �ּ� �ο�
, V_MAX_MEM_CODE            IN TBL_STUDY_OPEN.MAX_MEM_CODE%TYPE     -- �ִ� �ο�
, V_MIN_RANK                IN TBL_STUDY_OPEN.MIN_RANK%TYPE         -- �����ּҵ��
, V_WEEKDAY_CODE            IN TBL_STUDY_MEETDAY.WEEKDAY_CODE%TYPE  -- ���� �ڵ�
, V_START_TIME              IN TBL_STUDY_MEETDAY.START_TIME%TYPE    -- ���� �ð�
, V_END_TIME                IN TBL_STUDY_MEETDAY.END_TIME%TYPE      -- ���� �ð�
)
IS
    --���� ����
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;    
    V_USER_CODE     TBL_STUDY_OPEN.USER_CODE%TYPE;
    V_HITCOUNT      TBL_STUDY_OPEN.HITCOUNT%TYPE;
    V_CLOSE_DATE    TBL_STUDY_OPEN.CLOSE_DATE%TYPE;
    V_MEETDAY_CODE  TBL_STUDY_MEETDAY.MEETDAY_CODE%TYPE;

    
BEGIN

    V_STUDY_CODE := 'SC'||STD_OPEN_SEQ.NEXTVAL;
    
    SELECT USER_CODE INTO V_USER_CODE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    SELECT (START_DATE - 2) INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;

    
    INSERT INTO TBL_STUDY_OPEN(STUDY_CODE, USER_CODE, WRITE_DATE, HITCOUNT, STUDY_TYPE_CODE
                             , INTEREST_MC_CODE, START_DATE, END_DATE, MIN_MEM_CODE, MAX_MEM_CODE
                             , STUDY_NAME, MIN_RANK, CLOSE_DATE, STUDY_DESC, LOC_MC_CODE)
    VALUES(V_STUDY_CODE, V_USER_CODE, SYSDATE, DEFAULT, V_STUDY_TYPE_CODE, V_INTEREST_MC_CODE
         , V_START_DATE, V_END_DATE, V_MIN_MEM_CODE, V_MAX_MEM_CODE, V_STUDY_NAME, V_MIN_RANK
         , V_CLOSE_DATE, V_STUDY_DESC, V_LOC_MC_CODE);
         
    INSERT INTO TBL_STUDY_MEETDAY(MEETDAY_CODE, WEEKDAY_CODE, STUDY_CODE, START_TIME, END_TIME)
    VALUES('SM'||STD_MEETDAY_SEQ.NEXTVAL, V_WEEKDAY_CODE, V_STUDY_CODE, V_START_TIME, V_END_TIME);

    --Ŀ��
    COMMIT;
    
        
END;





