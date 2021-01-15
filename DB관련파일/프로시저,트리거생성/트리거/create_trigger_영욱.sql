

-- ������ �տ� ���� �� ���� �����ϱ�

--�� it, ������� ���� �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_INFORM
        FOR EACH ROW    
BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----


--�� ����,�ڵ��׽�Ʈ �ı� �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_INTERVIEW
        FOR EACH ROW
BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----


--�� ���̳�,������ �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_SEMINAR
        FOR EACH ROW

BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 5, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;



--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----


--�� ���͵� �ı� �Խ��� �� �ۼ� ���� �߰�TRIGGER(Ʈ����) ����
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_BOARD_STUDYREVIEW
        FOR EACH ROW
BEGIN
    
    -- �Խù��� ����� ����� ���� �߰�
    INSERT INTO TBL_SCORE(SCORE_CODE, USER_CODE, SCORE, SCORE_DATE)
    VALUES('??'||STUDY_ASSE_RESP_SEQ.NEXTVAL, :NEW.USER_CODE, 10, SYSDATE);

   -- COMMIT;
   -- �� TRIGGER �������� COMMT/ ROLLBACK ���� ��� �Ұ�~!!!
END;


-- 2021-01-13 ���͵� ���� ���� Ʈ����
CREATE OR REPLACE TRIGGER TRG_BEFORE_INSERT_STUDY_OPEN
BEFORE 
INSERT ON TBL_STUDY_OPEN
FOR EACH ROW
DECLARE  
V_SUSPEND_CHECK NUMBER;
V_STUDY_NUM      NUMBER;
V_SCORE_NUM      NUMBER;

-- ���� ó�� ���� ����
SUSPEND_CHECK_ERROR   EXCEPTION;
STUDY_NUM_ERROR         EXCEPTION;
SCORE_NUM_ERROR         EXCEPTION;
        
BEGIN
        
        --�� �������� Ȯ��
        SELECT COUNT(*) INTO V_SUSPEND_CHECK
        FROM  ACCOUNT_SUSPEND_VIEW 
        WHERE ID = :NEW.USER_CODE;
        
        IF(V_SUSPEND_CHECK = 1 )
        THEN    RAISE SUSPEND_CHECK_ERROR;
        
        ELSE
            --�� ��� Ȯ��
            SELECT SUM(SCORE) INTO V_SCORE_NUM
            FROM TBL_SCORE
            WHERE USER_CODE = :NEW.USER_CODE;
            
            IF(V_SCORE_NUM < 1800)    
            THEN    RAISE STUDY_NUM_ERROR;
            
            ELSE
                --�� �������� ���͵� ���� Ȯ��
                SELECT COUNT(*) INTO V_STUDY_NUM
                FROM MY_NOW_STUDY_VIEW;                
            
                IF(V_STUDY_NUM >2)
                THEN    RAISE SCORE_NUM_ERROR;

                END IF;
            END IF;
        END IF;
        
        -- Ŀ��
        COMMIT;
        
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

---------------------------------------------------------------------------------------------------------------------------------------

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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,'�Ű� ������ ���¶� �����Ұ�~!!!');
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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' �Ű� ������ ���¶� �����Ұ�~!!!');
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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' �Ű� ������ ���¶� �����Ұ�~!!!');
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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' �Ű� ������ ���¶� �����Ұ�~!!!');
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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' �Ű� ������ ���¶� �����Ұ�~!!!');
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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' �Ű� ������ ���¶� �����Ұ�~!!!');
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
        
        -- Ŀ��
        COMMIT;
        
        -- ����ó��
        EXCEPTION
                WHEN POST_ERROR
                    THEN    RAISE_APPLICATION_ERROR(-70031,' �Ű� ������ ���¶� �����Ұ�~!!!');
                WHEN OTHERS
                    THEN ROLLBACK;
END;

----------------------------END----------------------------------------






















--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--�� ���Ҹ� : ��� �μ�Ʈ�� �� ������ ��� ��¥ üũ�ؼ� 1�� �������� �� �� ��� �Ҹ�.
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


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@----
--�� �������� ����Ҷ� üũ�ؼ� 50% �Ѿ����� ��������ó�� �μ�Ʈ+���ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_BI_
        AFTER
        INSERT  ON TBL_MEM_KICK_REG
        FOR EACH ROW
    
DECLARE
        -- ���͵� ������ �� ���� ���� 
        V_APPLY_NUM   NUMBER;
        -- �������� ���� �� ���� ����
        V_KICK_NUM      NUMBER;
        -- ���͵� ������ �ڵ带 ���� ����
        V_APPLY_CODE   TBL_STUDY_PARTICIPANT.APPLY_CODE%TYPE;
        
BEGIN
     -- ���͵� ������ �� Ȯ��
     SELECT COUNT(*) INTO V_APPLY_NUM
     FROM TBL_STUDY_PARTICIPANT
     WHERE PARTI_CODE = :NEW.PARTI_KICKED_CODE;
     
     -- �������� ���� �� Ȯ��
     SELECT COUNT(*) INTO V_KICK_NUM
     FROM TBL_MEM_KICK_REG
     WHERE MEM_KICK_REG_CODE = :NEW.MEM_KICK_REG_CODE;
     
     -- ���͵� ������ �ڵ� Ȯ��
     SELECT APPLY_CODE INTO V_APPLY_CODE
     FROM TBL_STUDY_PARTICIPANT
     WHERE APPLY_CODE = :NEW.APPLY_CODE;
     
     -- �������� ���� ���� 50% �̻��� ��� �������� ó�� �� ���͵� ��� ó�� 
     IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- �������� ó��
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('??'||MEM_KH_SEQ.NEXTVAL, :NEW.MEM_KICK_REG_CODE, SYSDATE);
        
        -- ���͵� ��� ó��
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('??'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
    END IF;
END;
