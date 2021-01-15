--���� ���ν���(PROCEDURE) ���� ����--

-- ȯ���� �ٲ���� ��, ������ ������ ��� ���͵���� ������¥ NULL�� ������Ʈ
CREATE OR REPLACE PROCEDURE PRC_UPDATE_DATE_NULL
(   -- ���͵��ڵ� �޾ƿ���
    V_STUDY_CODE IN TBL_STUDY_OPEN.STUDY_CODE%TYPE
)
IS
BEGIN
    -- ���͵��ڵ尡 �޾ƿ� �ڵ�� �����鼭, ��å�� 2(���͵��)�� ��� ������ 
    -- ������¥ NULL�� ������Ʈ�ϱ�
    UPDATE TBL_STUDY_APPLY
    SET APPLY_DATE = NULL
    WHERE STUDY_CODE = V_STUDY_CODE AND POSITION_CODE = 2;
    
    -- ���ܹ߻��� �ѹ�
    EXCEPTION
    WHEN OTHERS THEN ROLLBACK; 
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_UPDATE_DATE_NULL��(��) �����ϵǾ����ϴ�.


--Ż�� �� �� �� �ֹ� ����� ���ν���
CREATE OR REPLACE PROCEDURE PRC_DELETE_SSN
(
    -- Ż���ڵ� �޾ƿ���
    V_WDL_CODE  IN TBL_WITHDRAWAL_INFO.SSN%TYPE
)
IS
    V_WDL_DATE  DATE;
BEGIN

    -- Ż��¥ ��������
    SELECT WDL_DATE INTO V_WDL_DATE
    FROM TBL_WITHDRAWAL_INFO
    WHERE WDL_CODE = V_WDL_CODE;
    
     -- �Ѵ��� �������� �ֹ� �����
    IF(ADD_MONTHS(V_WDL_DATE, 1) <= SYSDATE)
    THEN
        UPDATE TBL_WITHDRAWAL_INFO
        SET SSN = NULL
        WHERE WDL_CODE = V_WDL_CODE;
    END IF;  
END;

DROP PROCEDURE PRG_INSERT_WARNING;

-- ��� ���� �� ��� �Ҹ�, ��� �μ�Ʈ, ��� �� ���� 3�� �̻��̸� �������� / ��ȿ�Ⱓ �ø���
CREATE OR REPLACE PROCEDURE PRC_INSERT_WARNING
( V_USER_CODE   IN TBL_USER_CODE_CREATE.USER_CODE%TYPE
, V_WARNING_DATE    IN TBL_WARNING.WARNING_DATE%TYPE
)
IS
    -- �� ��� ���� 
    V_WARNING_COUNT_TOT   NUMBER;
    -- ��ȿ�� ��� ����
    V_WARNING_COUNT       NUMBER;
    -- ��� �ڵ�
    V_WARNING_CODE      VARCHAR2(15);
    -- ���� �ֱ� �������� ���� ��� �ڵ�
    V_WARNING_CODE_RECENT    VARCHAR2(15);
    -- ���� �ֱ� �������� ���� ��� ��¥
    V_WARNING_DATE_RECENT    DATE;
    -- �������� ����
    V_SUSPEND_COUNT   NUMBER;
    -- ���� �ֱ� �������� �ڵ�
    V_SUSPEND_CODE    VARCHAR2(10);
    -- ���� �ֱ� �������� ��¥
    V_SUSPEND_DATE    DATE;
    
BEGIN 

    -- �������� ���� ����
    SELECT COUNT(���������ڵ�) ������������ INTO V_SUSPEND_COUNT
    FROM WARNING_SUSPEND_VIEW
    WHERE �����=V_USER_CODE;  
    
    --������
    IF (V_SUSPEND_COUNT > 0)
    THEN
        -- �̾��� ����ڵ�, ���¥ ��������
        SELECT ����ڵ�, ���¥, ���������ڵ�, ����������¥
          INTO V_WARNING_CODE_RECENT, V_WARNING_DATE_RECENT, V_SUSPEND_CODE, V_SUSPEND_DATE
        FROM WARNING_SUSPEND_VIEW
        WHERE �����=V_USER_CODE AND ���������ڵ� IS NOT NULL;
            
        -- ���� �̾������¥�κ��� 1���� �������� ��� ��� �����
        IF( TRUNC(ADD_MONTHS(V_WARNING_DATE_RECENT, 12), 'DD') <= TRUNC(V_WARNING_DATE, 'DD') )
        THEN
            DELETE
            FROM TBL_WARNING
            WHERE USER_CODE = V_USER_CODE AND WARNING_DATE > V_WARNING_DATE_RECENT;
        END IF;    
        
    --�������� �����ֱ� ���¥ �����ͼ� 1�� �������� ���� �����
    ELSE
        SELECT MAX(WARNING_DATE) INTO V_WARNING_DATE_RECENT
        FROM TBL_WARNING
        WHERE USER_CODE = V_USER_CODE;
        
        IF(TRUNC(ADD_MONTHS(V_WARNING_DATE_RECENT, 12), 'DD') <= TRUNC(V_WARNING_DATE, 'DD'))
        THEN
            DELETE
            FROM TBL_WARNING
            WHERE USER_CODE = V_USER_CODE;
        END IF;    
    END IF;

------------------------------------------------------------------------------------------------------------------------
    V_WARNING_CODE := 'WR'|| STUDY_WARN_SEQ.NEXTVAL;
    INSERT INTO TBL_WARNING(WARNING_CODE, USER_CODE, WARNING_DATE) VALUES(V_WARNING_CODE, V_USER_CODE, V_WARNING_DATE);
    
------------------------------------------------------------------------------------------------------------------------    
    
   -- �����, ������������
    SELECT COUNT(����ڵ�) �����
      INTO V_WARNING_COUNT_TOT
    FROM WARNING_SUSPEND_VIEW
    WHERE �����=V_USER_CODE;   
  
    -- ��� 3ȸ �̻��̸�
    IF(V_WARNING_COUNT_TOT >= 3)
    
    THEN 
        -- �������� �̷��� �����ϸ� �ֱ� �������� ���� ���� ����
        IF (V_SUSPEND_COUNT > 0)
        THEN            
            -- ��ȿ �����
            SELECT COUNT(*) INTO V_WARNING_COUNT
            FROM WARNING_SUSPEND_VIEW
            WHERE �����=V_USER_CODE AND ���¥ > V_SUSPEND_DATE;
            
            -- ����ƴ��� Ȯ��
            IF (ADD_MONTHS(V_SUSPEND_DATE, 12) <= V_WARNING_DATE)
            THEN
                -- �� ���� + ���� ��ȿ�� ������ 3�� �̻��̸� �μ�Ʈ
                IF (V_WARNING_COUNT >= 3)
                THEN
                    PRC_INSERT_SUSPEND(V_WARNING_DATE, V_WARNING_CODE);
                END IF;
                
                -- ������ȵ����� ������Ʈ ��Ű��    
             ELSE
                UPDATE TBL_ACCOUNT_SUSPEND
                SET ACCT_SUS_DATE = V_WARNING_DATE, WARNING_CODE = V_WARNING_CODE
                WHERE ACCT_SUS_CODE = V_SUSPEND_CODE;

            END IF;    
        
        -- ���������� �̷��� �������� ������ ���� ���� ������ ���
        ELSE
            PRC_INSERT_SUSPEND(V_WARNING_DATE, V_WARNING_CODE);
        END IF;
        
    END IF;    
       
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
    
    COMMIT;
    
END;      
--==>> Procedure PRG_INSERT_WARNING��(��) �����ϵǾ����ϴ�.

CREATE OR REPLACE PROCEDURE PRC_INSERT_CANCEL
(
  V_APPLY_CODE    IN TBL_STUDY_APPLY.APPLY_CODE%TYPE
, V_CANCEL_DATE   IN TBL_STUDY_CANCEL.CANCEL_DATE%TYPE
, V_AUTO_CANCEL   IN TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE
)
IS
    V_CANCEL_CODE   TBL_STUDY_CANCEL.CANCEL_CODE%TYPE;
    V_STUDY         TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_LEFT          NUMBER;
    V_MIN           TBL_MEMNUM.MEMNUM%TYPE;
    V_START_DATE    TBL_STUDY_OPEN.START_DATE%TYPE;
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
BEGIN

    V_CANCEL_CODE := 'SC'|| STUDY_CANC_SEQ.NEXTVAL;
    
    INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
    VALUES(V_CANCEL_CODE, V_APPLY_CODE, V_CANCEL_DATE, V_AUTO_CANCEL);
    
    -- ���͵��ڵ�, �ּ��ο�, ������, ������, ������ ��������
    SELECT ���͵��ڵ�, �ּ��ο�, ������, ������, ������ 
        INTO V_STUDY, V_MIN, V_START_DATE, V_USER_CODE, V_FIRSTLEADER
    FROM STUDY_CANCEL_VIEW
    WHERE ����ڵ� = V_CANCEL_CODE;
    
    -- �ش� ���͵� ���� ��� ����
    SELECT COUNT(*) INTO V_LEFT
    FROM STUDY_CANCEL_VIEW
    WHERE ����ڵ� IS NULL AND ���͵��ڵ� = V_STUDY;
 
    -- �ּ��ο����� ���� ���� + ���͵� �������� ���
    IF (V_LEFT < V_MIN AND V_START_DATE <= V_CANCEL_DATE)
    THEN 
        -- ���ּ��ο��̸�, ������ : ���͵� �����Ŵ.(���ᳯ¥ ���÷�.)
        UPDATE TBL_STUDY_OPEN
        SET END_DATE = V_CANCEL_DATE
        WHERE STUDY_CODE = V_STUDY;
        
    -- �ּ��ο����� ���� ���� ��� �ڹ����� ������ Ȯ��(�ڹ����̸� NULL, �ڵ���Ҹ� 1)
    ELSIF (V_AUTO_CANCEL IS NULL)
    THEN
        -- ���͵� ���������� Ȯ��
        IF (TRUNC(V_START_DATE, 'DD') <= TRUNC(V_CANCEL_DATE, 'DD'))
        THEN 
            -- ��������, ������, �ڹ��� : -200
            IF (V_FIRSTLEADER = V_USER_CODE)
            THEN
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, V_CANCEL_DATE);
            
            -- ��������, ������X, �ڹ��� : -100
            ELSE
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, V_CANCEL_DATE);
            
            END IF;
        ELSE
            -- ���ּ��ο��̻�, ������X : �������� NULL�� ����
            PRC_UPDATE_DATE_NULL(V_STUDY); 
            
            -- Ȯ���Ⱓ ������ 2������ Ȯ��
            IF (TRUNC(V_CANCEL_DATE, 'DD') BETWEEN TRUNC(V_START_DATE-2, 'DD') AND TRUNC(V_START_DATE-1, 'DD'))
            THEN
                -- ��Ȯ���Ⱓ ������2��, ������, �ڹ��� : -100
                IF (V_FIRSTLEADER = V_USER_CODE)
                THEN
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, V_CANCEL_DATE);
                    
                -- ��Ȯ���Ⱓ ������2��, ������X, �ڹ��� : -30    
                ELSE
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, V_CANCEL_DATE);
                END IF;
            END IF;            
        END IF;
        
    END IF;
    
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
    
    COMMIT;
    
END;