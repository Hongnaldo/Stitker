--���� ���ν���(PROCEDURE) ���� ����--


DESC TBL_STUDY_OPEN;
DESC TBL_STUDY_MEETDAY;


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

-- ���͵� ���� ���̺� �μ�Ʈ
CREATE OR REPLACE PROCEDURE STD_OPEN_INSERT
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
, V_USER_CODE               IN TBL_USER_REGISTER.USER_CODE%TYPE     -- ����� �ڵ�
)
IS
    --���� ����
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;    
    V_CLOSE_DATE    TBL_STUDY_OPEN.CLOSE_DATE%TYPE;
    V_WRITE_DATE    TBL_STUDY_OPEN.WRITE_DATE%TYPE := SYSDATE;
    V_HITCOUNT      TBL_STUDY_OPEN.HITCOUNT%TYPE := 0;

    
BEGIN

    -- ���� �������� ���͵� ���� ��¥ ��Ʋ ��
    V_CLOSE_DATE := TRUNC(V_START_DATE - 2, 'DD');

    
    
    INSERT INTO TBL_STUDY_OPEN(STUDY_CODE, USER_CODE, WRITE_DATE, HITCOUNT, STUDY_TYPE_CODE
                             , INTEREST_MC_CODE, START_DATE, END_DATE, MIN_MEM_CODE, MAX_MEM_CODE
                             , STUDY_NAME, MIN_RANK, CLOSE_DATE, STUDY_DESC, LOC_MC_CODE)
    VALUES('SO'||STD_OPEN_SEQ.NEXTVAL, V_USER_CODE, V_WRITE_DATE, V_HITCOUNT, V_STUDY_TYPE_CODE, V_INTEREST_MC_CODE
         , V_START_DATE, V_END_DATE, V_MIN_MEM_CODE, V_MAX_MEM_CODE, V_STUDY_NAME, V_MIN_RANK
         , V_CLOSE_DATE, V_STUDY_DESC, V_LOC_MC_CODE);

    --Ŀ��
    COMMIT;
    
        
END;



-- ������Ͽ� �μ�Ʈ
CREATE OR REPLACE PROCEDURE STD_MEETDAY_INSERT
( V_STUDY_CODE              IN TBL_STUDY_OPEN.STUDY_CODE%TYPE       -- ���͵� ������ ���͵� �ڵ�
, V_WEEKDAY_CODE            IN TBL_STUDY_MEETDAY.WEEKDAY_CODE%TYPE  -- ���� �ڵ�
, V_START_TIME              IN TBL_STUDY_MEETDAY.START_TIME%TYPE    -- ���� �ð�
, V_END_TIME                IN TBL_STUDY_MEETDAY.END_TIME%TYPE      -- ���� �ð�
)
IS
    --���� ����
    V_MEETDAY_CODE  TBL_STUDY_MEETDAY.MEETDAY_CODE%TYPE;


    
BEGIN

      
    INSERT INTO TBL_STUDY_MEETDAY(MEETDAY_CODE, WEEKDAY_CODE, STUDY_CODE, START_TIME, END_TIME)
    VALUES('MD'||STD_MEETDAY_SEQ.NEXTVAL, V_WEEKDAY_CODE, V_STUDY_CODE, V_START_TIME, V_END_TIME);

    --Ŀ��
    COMMIT;
    
        
END;


-- ���� �μ�Ʈ -> ����� 0 �����̸� 0������ �μ�Ʈ -> ���������� �μ�Ʈ 
--                                       18600 �ʰ��� 18600������ �μ�Ʈ
-- �׽�Ʈ �Ϸ�

CREATE OR REPLACE PROCEDURE STD_SCORE_INSERT
( V_USER_CODE   IN TBL_USER_REGISTER.USER_CODE%TYPE     -- ����� �ڵ�
, V_SCORE       IN TBL_SCORE.SCORE%TYPE                 -- ����
)
IS
     V_SCORE_CODE   TBL_SCORE.SCORE_CODE%TYPE;
     V_SCORE_DATE   TBL_SCORE.SCORE_DATE%TYPE := SYSDATE;
     V_SUM_SCORE    NUMBER;
       
     
BEGIN

    SELECT SUM(SCORE) INTO V_SUM_SCORE
    FROM TBL_SCORE
    WHERE USER_CODE = V_USER_CODE;
   
    IF V_SUM_SCORE + V_SCORE <= 0 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, -(V_SUM_SCORE), SYSDATE);
        PRG_INSERT_WARNING(V_USER_CODE, SYSDATE);
    ELSIF V_SUM_SCORE + V_SCORE  <= 18600 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, V_SCORE, SYSDATE);
    ELSIF V_SUM_SCORE IS NULL THEN 
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, V_SCORE, SYSDATE);
    ELSIF V_SUM_SCORE + V_SCORE - 18600 > 0 THEN
        INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE) 
        VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL,  V_USER_CODE, V_SCORE - (V_SUM_SCORE + V_SCORE - 18600), SYSDATE);
    ELSIF V_SUM_SCORE = 18600 THEN
        RAISE_APPLICATION_ERROR(-20001, '�Է��� �� �ִ� �ִ� ������ �ʰ��߽��ϴ�.');  

    END IF;
  
END;

SELECT *
FROM TBL_WARNING;

