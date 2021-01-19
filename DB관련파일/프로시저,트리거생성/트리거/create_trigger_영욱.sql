

-- ������ �տ� ���� �� ���� �����ϱ�

--�� it, ������� ���� �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BI_SCORE
        AFTER
        INSERT  ON TBL_BOARD_INFORM
        FOR EACH ROW    
BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;



--�� ����,�ڵ��׽�Ʈ �ı� �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BV_SCORE
        AFTER
        INSERT  ON TBL_BOARD_INTERVIEW
        FOR EACH ROW
BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;



--�� ���̳�,������ �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BS_SCORE
        AFTER
        INSERT  ON TBL_BOARD_SEMINAR
        FOR EACH ROW

BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;


--�� ���͵� �ı� �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BSR_SCORE
        AFTER
        INSERT  ON TBL_BOARD_STUDYREVIEW
        FOR EACH ROW
DECLARE  
V_USER_CODE VARCHAR2(10);

BEGIN
    
    -- ���� �ڵ� �޾ƿ���
    SELECT A.USER_CODE INTO V_USER_CODE
    FROM TBL_STUDY_PARTICIPANT P JOIN TBL_STUDY_APPLY A 
    ON P.APPLY_CODE = A.APPLY_CODE
    WHERE PARTI_CODE = :NEW.PARTI_CODE ;
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, 10, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;


commit;
---------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO TBL_BOARD_STUDYREVIEW
VALUES('SR1','PT3',SYSDATE,0,'ASDF','ASFSG','IM1');
ROLLBACK;
DROP TRIGGER TRG_SR_SCORE;
SELECT * FROM TBL_INTEREST_MC;
SELECT * FROM TBL_BOARD_STUDYREVIEW;
SELECT * FROM TBL_SCORE;
SELECT * FROM TBL_WARNING;
SELECT * FROM TBL_ACCOUNT_SUSPEND;
update TBL_BOARD_INFORM
SET CONTENT='����Ȯ��'
WHERE POST_CODE = 'BI1';

-- it, ������� ���� �Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_INFORM
BEFORE 
UPDATE ON TBL_BOARD_INFORM
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN

        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_INFORM 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,'�Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

--�� ����,�ڵ��׽�Ʈ �ı� �Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_INTERVIEW
BEFORE 
UPDATE ON TBL_BOARD_INTERVIEW
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_INTERVIEW 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--�� ���̳�,������  �Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_SEMINAR
BEFORE 
UPDATE ON TBL_BOARD_SEMINAR
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_SEMINAR 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--�� �����Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_FREE
BEFORE 
UPDATE ON TBL_BOARD_FREE
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_FREE 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--�� Q&A����  �Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_QUESTION
BEFORE 
UPDATE ON TBL_BOARD_QUESTION
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_QUESTION 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--�� Q&A�亯 �Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_ANSWER
BEFORE 
UPDATE ON TBL_BOARD_ANSWER
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_ANSWER 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;


--�� ���͵� �ı� �Խ��� ���� BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_UPDATE_STUDYREVIEW
BEFORE 
UPDATE ON TBL_BOARD_STUDYREVIEW
FOR EACH ROW
DECLARE  
V_POST_NUM NUMBER;

-- ���� ó�� ���� ����
POST_ERROR   EXCEPTION;
        
BEGIN
        
        
        --�� �Ű� ���� Ȯ��
        SELECT COUNT(*) INTO V_POST_NUM
        FROM  TBL_REPORT_REG_STUDYREVIEW 
        WHERE POST_CODE = :NEW.POST_CODE;
        
        IF(V_POST_NUM > 0 )
        THEN    RAISE POST_ERROR;
        END IF;
        
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-20031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

---------------------------------------------
SELECT * FROM TBL_USER_RANK;
SELECT * FROM VIEW_STUDY_NOW;
SELECT * FROM TBL_STUDY_OPEN ORDER BY USER_CODE;
SELECT * FROM TBL_USER_REGISTER WHERE ID ='khj77'; --uc1,uc7
SELECT * FROM  ACCOUNT_SUSPEND_VIEW;
INSERT INTO TBL_STUDY_OPEN
(study_code, user_code, write_date, hitcount , study_type_code, interest_mc_code, start_date, end_date, min_mem_code, max_mem_code, study_name, min_rank, close_date, study_desc , loc_mc_code) 
VALUES('SO'||STD_OPEN_SEQ.NEXTVAL, 'UC4', SYSDATE, 0, 'ST3', 'IM7', '2021-01-22', '2021-02-10', 'MN1', 'MN6', '���׽�Ʈ', 'UR4', '2021-01-20', '���׽�Ʈ', 'LM1');


-- ���͵� ���� ���� Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_INSERT_STUDY_OPEN
BEFORE 
INSERT ON TBL_STUDY_OPEN
FOR EACH ROW

DECLARE  
V_ID                      VARCHAR2(30);
V_SUSPEND_CHECK NUMBER;
V_STUDY_NUM      NUMBER;
V_SCORE_NUM      NUMBER;

-- ���� ó�� ���� ����
SUSPEND_CHECK_ERROR   EXCEPTION;
STUDY_NUM_ERROR         EXCEPTION;
SCORE_NUM_ERROR         EXCEPTION;
        
BEGIN
        --�� �������� Ȯ���� ���� ID �� ��������
        SELECT ID INTO V_ID
        FROM TBL_USER_REGISTER
        WHERE USER_CODE = :NEW.USER_CODE;
        
        --�� �������� Ȯ��
        SELECT COUNT(*) INTO V_SUSPEND_CHECK
        FROM  ACCOUNT_SUSPEND_VIEW 
        WHERE ID = V_ID;
        
        IF(V_SUSPEND_CHECK = 1 )
        THEN    RAISE SUSPEND_CHECK_ERROR;
        
        ELSE
            --�� ��� Ȯ��
            SELECT SUM(SCORE) INTO V_SCORE_NUM
            FROM TBL_SCORE
            WHERE USER_CODE = :NEW.USER_CODE;
            
            
            IF(V_SCORE_NUM < 1800)    
            THEN    RAISE SCORE_NUM_ERROR;
            
            ELSE
                --�� �������� ���͵� ���� Ȯ��
                SELECT COUNT(*) INTO V_STUDY_NUM
                FROM VIEW_STUDY_NOW;                
            
                IF(V_STUDY_NUM >2)
                THEN    RAISE STUDY_NUM_ERROR;

                END IF;
            END IF;
        END IF;
        
        
        -- ����ó��
        EXCEPTION
                WHEN SUSPEND_CHECK_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70021,'�����������¶� �����Ұ�~!!!');
                WHEN STUDY_NUM_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70022,'4��� ���϶� �����Ұ�~!!!');
                WHEN SCORE_NUM_ERROR 
                    THEN    RAISE_APPLICATION_ERROR(-70023,'�������� ���͵� 2���̻��̶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

----------------------------END----------------------------------------






















--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--�� ���Ҹ� : ��� �μ�Ʈ�� �� ������ ��� ��¥ üũ�ؼ� 1�� �������� �� �� ��� �Ҹ�.
-- ���ν����� �����ؼ� ��
/*
CREATE OR REPLACE TRIGGER TRG_BIA
        BEFORE
        INSERT  ON TBL_WARNING
        FOR EACH ROW    
DECLARE
        -- �� ��� ���� / �������� ���� ���� ��� ����
        V_WARNING_COUNT   NUMBER;
        -- ���� �ֱ� �������� ���� ��� �ڵ�
        V_WARNING_CODE    VARCHAR2(15);
        -- ���� �ֱ� �������� ���� ��� ��¥
        V_WARNING_DATE    DATE;
        -- �������� ����
        V_SUSPEND_COUNT   NUMBER;
        -- ���� �ֱ� �������� �ڵ�
        V_SUSPEND_CODE    VARCHAR2(10);

BEGIN
    -- ��� ���� �����ϱ�
    SELECT COUNT(*) INTO V_WARNING_COUNT
    FROM TBL_WARNING 
    WHERE USER_CODE = :NEW.USER_CODE;
    
    -- ��� 3ȸ �̻��̸�
    IF(V_WARNING_COUNT >= 3)
    
    THEN
        -- �������� ���� �����ϱ�
        SELECT COUNT(*) INTO V_SUSPEND_COUNT
        FROM TBL_WARNING W LEFT JOIN TBL_ACCOUNT_SUSPEND S
            ON W.WARNING_CODE = S.WARNING_CODE
        WHERE W.USER_CODE = :NEW.USER_CODE AND S.ACCT_SUS_CODE IS NOT NULL;
        
        -- �������� �̷��� �����ϸ� �ֱ� �������� ���� ���� ����
        IF (V_SUSPEND_COUNT > 0)
        THEN
            -- ���� �ֱ� �������� �ڵ� ����
            SELECT MAX(S.ACCT_SUS_CODE) INTO V_SUSPEND_CODE
            FROM TBL_WARNING W LEFT JOIN TBL_ACCOUNT_SUSPEND S
                ON W.WARNING_CODE = S.WARNING_CODE
            WHERE W.USER_CODE = :NEW.USER_CODE;
            
            -- ���� �ֱ� ���������� �̾��� ����ڵ� ����, �ش� ����ڵ� ��¥ ����
            SELECT S.WARNING_CODE, W.WARNING_DATE INTO V_WARNING_CODE, V_WARNING_DATE 
            FROM TBL_ACCOUNT_SUSPEND S JOIN TBL_WARNING W
                ON W.WARNING_CODE = S.WARNING_CODE
            WHERE S.ACCT_SUS_CODE = V_SUSPEND_CODE;
            
            -- �ֱ� ���¥�κ��� 1���� �������� �� ���� ��� �������ֱ�
            IF (ADD_MONTHS(V_WARNING_DATE, 12) <= SYSDATE) -- ������ �������� ��� ��¥ 
            THEN 
               DELETE 
               FROM TBL_WARNING W
               WHERE W.USER_CODE = :NEW.USER_CODE AND W.WARNING_DATE > V_WARNING_DATE;
            END IF;
            
            ------------------------------------------------    
        
        -- �������� �̷��� �������� ������ �ֱ� ���¥�κ��� 1���� �������� �� ���� ��� �������ֱ�
        ELSE
            -- ���� �ֱ� ��� ��¥
            SELECT MAX(WARNING_DATE) INTO V_WARNING_DATE
            FROM TBL_WARNING
            WHERE USER_CODE = :NEW.USER_CODE;
            
            IF (ADD_MONTHS(V_WARNING_DATE, 12) <= SYSDATE)
            THEN 
               DELETE 
               FROM TBL_WARNING W
               WHERE W.USER_CODE = :NEW.USER_CODE AND W.WARNING_DATE <= V_WARNING_DATE;
            END IF;
        END IF;
        
    END IF;        
    
    /*
     -- ���� �ֱ� ��� ��¥
    SELECT MAX(WARNING_DATE) INTO V_WARNING_DATE
    FROM TBL_WARNING
    WHERE USER_CODE = :NEW.USER_CODE;
    -- �ֱٰ��¥�κ��� 1���� �������� �� ���� ��� �������ֱ�
    IF (ADD_MONTHS(V_WARNING_DATE, 12) <= SYSDATE)
    THEN 
       DELETE 
       FROM TBL_WARNING W
       WHERE W.USER_CODE = :NEW.USER_CODE AND W.WARNING_DATE <= V_WARNING_DATE;
    END IF;  
    */
END;


*/