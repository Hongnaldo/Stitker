--���� Ʈ����(TRIGGER) ���� ����--
/*
"���3ȸ -> ���������� �����;��� :  ���������� �μ�Ʈ
            ���������� ������ ���� : ���� �ֱ� ���������ڵ��� ����������¥�� 1���� ������ -> ���������� �μ�Ʈ
                                     ���� �ֱ� ���������ڵ��� ����������¥ sysdate�� ������Ʈ"
"���ó���� �μ�Ʈ -> �ּ��ο��̸� -> ���͵����ᳯ¥�� ���÷� ����(������Ʈ) : ���Ḹ ����������. / �⼮�� ����..
                                                          -> (�������� ���͵�) ���͵������ ���°� ��. 
                                                               (������) ���ó��-�ڵ����ε�.
                                   (�������ν��͵�,�ڹ���) �г�Ƽ -100(�����ھƴ�), -200(������)
                                   (Ȯ���Ⱓ 4,5����,�ڹ���) �г�Ƽ -30��(�����ھƴ�), -100(������)
                                   (������/������, �ڹ����ƴ�) �г�Ƽ����.
                                   (������, �ڹ���) ���� ������ ������ ��� ��û��¥ null�� ������Ʈ(�Լ�/���ν��� ȣ��)"
"���͵������Ʈ -> (sysdate ���͵���۳�¥���� �̷�)  �⼮��,�������� �����(����������� �̷��� �����͵鸸 ��� ����)
                               (�������۾ȵ�) -> ���� ������ ���͵�� ��� ��û��¥ null�� ������Ʈ(�Լ�/���ν��� ȣ��)"
*/


-- ��� ���� �� ���� ��� �� ���� 3�� �̻��̸� �������� / ��ȿ�Ⱓ �ø���
CREATE OR REPLACE TRIGGER TRG_AFTER_INSERT_WARNING
AFTER
INSERT ON TBL_WARNING
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
    -- ���� �ֱ� �������� ��¥
    V_SUSPEND_DATE    DATE;
    
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
            
            -- �ֱ� �������� ������ ���� ����
            SELECT COUNT(*) INTO V_WARNING_COUNT
            FROM TBL_WARNING
            WHERE USER_CODE=:NEW.USER_CODE AND WARNING_DATE > V_WARNING_DATE;
            
            -- ���� ��ȿ�� ������ 3�� �̻��̸�
            IF (V_WARNING_COUNT >= 3)
            THEN 
                -- �ش� �������� �ڵ��� ��¥ ����
                SELECT ACCT_SUS_DATE INTO V_SUSPEND_DATE
                FROM TBL_ACCOUNT_SUSPEND
                WHERE ACCT_SUS_CODE = V_SUSPEND_CODE;
                
                -- ��������� ���� �������� ��Ű��
                IF (ADD_MONTHS(V_SUSPEND_DATE, 12) < SYSDATE)
                THEN
                    INSERT INTO TBL_ACCOUNT_SUSPEND(ACCT_SUS_CODE, ACCT_SUS_DATE, WARNING_CODE)
                    VALUES ('AS'||ACCT_SUS_SEQ.NEXTVAL, SYSDATE, :NEW.WARNING_CODE);
                    
                --����ȵ����� ������Ʈ ��Ű��    
                ELSE
                    UPDATE TBL_ACCOUNT_SUSPEND
                    SET ACCT_SUS_DATE = SYSDATE
                    WHERE ACCT_SUS_CODE = V_SUSPEND_CODE;
                END IF;
            END IF;    
        
        -- �������� �̷��� �������� ������ ���� ���� ������ ���
        ELSE
            INSERT INTO TBL_ACCOUNT_SUSPEND(ACCT_SUS_CODE, ACCT_SUS_DATE, WARNING_CODE)
            VALUES ('AS'||ACCT_SUS_SEQ.NEXTVAL, SYSDATE, :NEW.WARNING_CODE);
        END IF;
        
    END IF;        
END;      
--==>> Trigger TRG_AFTER_INSERT_WARNING��(��) �����ϵǾ����ϴ�.
    
    

-- ���͵� ���� �� ������Ʈ�� ��� �������� ��� ���͵�� ������¥ NULL�� ������Ʈ
CREATE OR REPLACE TRIGGER TRG_AFTER_UPDATE_STUDY
AFTER 
UPDATE ON TBL_STUDY_OPEN
FOR EACH ROW
DECLARE    
BEGIN
--
--    --���� ��¥�� �������Ϸ� ������Ʈ�ƴٸ� �⼮��/�������� ������ �����
--    IF (:OLD.END_DATE != :NEW.END_DATE AND :NEW.END_DATE <= SYSDATE)
--    THEN
--        -- �������� �����
--        DELETE
--        FROM TBL_STUDY_SCHEDULE S 
--        WHERE EXISTS(
--            SELECT *
--            FROM TBL_STUDY_ATTEND A
--            WHERE A.ATTEND_CODE = S.ATTEND_CODE
--             AND A.ATTEND_DATE > :NEW.END_DATE
--        );
--        -- �⼮�� �����
--        DELETE
--        FROM TBL_STUDY_ATTEND
--        WHERE ATTEND_DATE > :NEW.END_DATE;
        
    -- ���۳�¥�� ���纸�� �����̸�(���� ���� ����) ���� ������ ���͵�� ��� ��û��¥ NULL�� ������Ʈ
    IF (:NEW.START_DATE < SYSDATE)
        THEN PRC_UPDATE_DATE_NULL(:NEW.STUDY_CODE); 
    END IF;
END;
--==>> Trigger TRG_AFTER_UPDATE_STUDY��(��) �����ϵǾ����ϴ�.


-- �� ����
CREATE OR REPLACE VIEW STUDY_CANCEL_VIEW
AS
SELECT C.CANCEL_CODE, C.AUTO_CANCEL, A.APPLY_CODE, O.USER_CODE AS FIRSTLEADER, A.USER_CODE, P.POSITION_CODE
     , O.START_DATE, O.STUDY_CODE, O.END_DATE, M.MEMNUM AS MINNUM, O.WRITE_DATE
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        JOIN TBL_MEMNUM M
        ON M.MEMNUM_CODE = O.MIN_MEM_CODE
            JOIN TBL_STUDY_CANCEL C
            ON C.APPLY_CODE = A.APPLY_CODE
                JOIN TBL_MEMNUM M2
                ON M2.MEMNUM_CODE = O.MAX_MEM_CODE
                    JOIN TBL_STUDY_POSITION P
                    ON A.POSITION_CODE = P.POSITION_CODE;
--==>> View STUDY_CANCEL_VIEW��(��) �����Ǿ����ϴ�.

SELECT *
FROM STUDY_CANCEL_VIEW;

-- ���͵����ó�� �μ�Ʈ Ʈ����
CREATE OR REPLACE TRIGGER TRG_AFTER_INSERT_CANCEL
AFTER 
INSERT ON TBL_STUDY_CANCEL
FOR EACH ROW
DECLARE
    V_STUDY TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_LEFT  NUMBER;
    V_MIN   TBL_MEMNUM.MEMNUM%TYPE;
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;
    V_END_DATE   TBL_STUDY_OPEN.END_DATE%TYPE;
    V_AUTO_CANCEL   TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE;
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
BEGIN
    -- ���͵� �ڵ� ��������
    SELECT STUDY_CODE INTO V_STUDY
    FROM STUDY_CANCEL_VIEW
    WHERE CANCEL_CODE = :NEW.CANCEL_CODE;
    
    -- �ش� ���͵� ���� ��� ����
    SELECT COUNT(*) INTO V_LEFT
    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
        ON A.APPLY_CODE = C.APPLY_CODE
    WHERE CANCEL_CODE IS NULL;
    
    -- �ּ��ο�, ���۳�¥, ���ᳯ¥, �ڵ����ó������, ������ڵ� ��������
    SELECT MINNUM, START_DATE, AUTO_CANCEL, USER_CODE, FIRSTLEADER
        INTO V_MIN, V_START_DATE, V_AUTO_CANCEL, V_USER_CODE, V_FIRSTLEADER
    FROM STUDY_CANCEL_VIEW
    WHERE APPLY_CODE = :NEW.APPLY_CODE;
        
    -- �ּ��ο����� ���� ���� ���
    IF (V_LEFT < V_MIN)
    THEN 
        -- ���͵� ���������� Ȯ��
        IF (V_START_DATE < SYSDATE)
        THEN
            -- ���ּ��ο��̸�, ������ : ���͵� �����Ŵ.(���ᳯ¥ ���÷�.)
            UPDATE TBL_STUDY_OPEN
            SET END_DATE = SYSDATE
            WHERE STUDY_CODE = V_STUDY;
        END IF;
    
    -- �ּ��ο����� ���� ���� ��� �ڹ����� ������ Ȯ��(�ڹ����̸� NULL, �ڵ���Ҹ� 1)
    ELSIF (V_AUTO_CANCEL IS NULL)
    THEN
        -- ���͵� ���������� Ȯ��
        IF (V_START_DATE < SYSDATE)
        THEN 
            -- ��������, ������, �ڹ��� : -200
            IF (V_FIRSTLEADER = V_USER_CODE)
            THEN
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, SYSDATE);
            
            -- ��������, ������X, �ڹ��� : -100
            ELSE
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
            
            END IF;
        ELSE
            -- ���ּ��ο��̻�, ������X : �������� NULL�� ����
            PRC_UPDATE_DATE_NULL(V_STUDY); 
            
            -- Ȯ���Ⱓ ������ 2������ Ȯ��
            IF (SYSDATE BETWEEN V_START_DATE-1 AND V_START_DATE-2)
            THEN
                -- ��Ȯ���Ⱓ ������2��, ������, �ڹ��� : -100
                IF (V_FIRSTLEADER = V_USER_CODE)
                THEN
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
                    
                -- ��Ȯ���Ⱓ ������2��, ������X, �ڹ��� : -30    
                ELSE
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, SYSDATE);
                END IF;
            END IF;            
        END IF;
    END IF;   
END;
--==>> Trigger TRG_AFTER_INSERT_CANCEL��(��) �����ϵǾ����ϴ�.

SELECT *
FROM TBL_STUDY_CANCEL;

CREATE OR REPLACE PROCEDURE PRC_INSERT_CANCEL
( V_APPLY_CODE    IN TBL_STUDY_APPLY.APPLY_CODE%TYPE
, V_CANCEL_DATE   IN TBL_STUDY_CANCEL.CANCEL_DATE%TYPE
, V_AUTO_CANCEL   IN TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE
)
IS
    V_CANCEL_CODE   TBL_STUDY_CANCEL.CANCEL_CODE%TYPE;
    V_STUDY TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_LEFT  NUMBER;
    V_MIN   TBL_MEMNUM.MEMNUM%TYPE;
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;
    V_END_DATE   TBL_STUDY_OPEN.END_DATE%TYPE;
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
BEGIN
    V_CANCEL_CODE := 'SC'|| STUDY_CANC_SEQ.NEXTVAL;
    INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
    VALUES(V_CANCEL_CODE, V_APPLY_CODE, TO_DATE('2020-12-14', 'YYYY-MM-DD'), V_AUTO_CANCEL);
    
    -- ���͵� �ڵ� ��������
    SELECT STUDY_CODE INTO V_STUDY
    FROM STUDY_CANCEL_VIEW
    WHERE CANCEL_CODE = V_CANCEL_CODE;
    
    -- �ش� ���͵� ���� ��� ����
    SELECT COUNT(*) INTO V_LEFT
    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
        ON A.APPLY_CODE = C.APPLY_CODE
    WHERE CANCEL_CODE IS NULL;
    
    -- �ּ��ο�, ���۳�¥, ���ᳯ¥, �ڵ����ó������, ������ڵ� ��������
    SELECT MINNUM, START_DATE, USER_CODE, FIRSTLEADER
        INTO V_MIN, V_START_DATE, V_USER_CODE, V_FIRSTLEADER
    FROM STUDY_CANCEL_VIEW
    WHERE APPLY_CODE = V_APPLY_CODE;
        
    -- �ּ��ο����� ���� ���� ���
    IF (V_LEFT < V_MIN)
    THEN 
        -- ���͵� ���������� Ȯ��
        IF (V_START_DATE < SYSDATE)
        THEN
            -- ���ּ��ο��̸�, ������ : ���͵� �����Ŵ.(���ᳯ¥ ���÷�.)
            UPDATE TBL_STUDY_OPEN
            SET END_DATE = SYSDATE
            WHERE STUDY_CODE = V_STUDY;
        END IF;
    
    -- �ּ��ο����� ���� ���� ��� �ڹ����� ������ Ȯ��(�ڹ����̸� NULL, �ڵ���Ҹ� 1)
    ELSIF (V_AUTO_CANCEL IS NULL)
    THEN
        -- ���͵� ���������� Ȯ��
        IF (V_START_DATE < SYSDATE)
        THEN 
            -- ��������, ������, �ڹ��� : -200
            IF (V_FIRSTLEADER = V_USER_CODE)
            THEN
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, SYSDATE);
            
            -- ��������, ������X, �ڹ��� : -100
            ELSE
            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
            
            END IF;
        ELSE
            -- ���ּ��ο��̻�, ������X : �������� NULL�� ����
            PRC_UPDATE_DATE_NULL(V_STUDY); 
            
            -- Ȯ���Ⱓ ������ 2������ Ȯ��
            IF (SYSDATE BETWEEN V_START_DATE-1 AND V_START_DATE-2)
            THEN
                -- ��Ȯ���Ⱓ ������2��, ������, �ڹ��� : -100
                IF (V_FIRSTLEADER = V_USER_CODE)
                THEN
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
                    
                -- ��Ȯ���Ⱓ ������2��, ������X, �ڹ��� : -30    
                ELSE
                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, SYSDATE);
                END IF;
            END IF;            
        END IF;
    END IF;   
END;