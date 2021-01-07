--���� Ʈ����(TRIGGER) ���� ����--
/*
"���3ȸ -> ���������� �����;��� :  ���������� �μ�Ʈ
                  ���������� ������ ���� : ���� �ֱ� ���������ڵ��� ����������¥�� 1���� ������ -> ���������� �μ�Ʈ
                                                           ���� �ֱ� ���������ڵ��� ����������¥ sysdate�� ������Ʈ"
"���ó���� �μ�Ʈ -> �ּ��ο��̸� -> ���͵����ᳯ¥�� ���÷� ����(������Ʈ)
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
CREATE OR REPLACE TRIGGER AFTER_INSERT_WARNING_TRG
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
        IF(WARNING_COUNT >= 3)
        
        THEN
            -- �������� ���� �����ϱ�
            SELECT COUNT(*) INTO V_SUSPEND_COUNT
            FROM TBL_WARNING W LEFT JOIN TBL_ACOUNT_SUSPEND S
                ON W.WARNING_CODE = S.WARNING_CODE
            WHERE W.USER_CODE = :NEW.USER_CODE AND S.ACCT_SUS_CODE IS NOT NULL;
            
            -- �������� �̷��� �����ϸ� �ֱ� �������� ���� ���� ����
            IF (V_SUSPEND_COUNT > 0)
            THEN
                -- ���� �ֱ� �������� �ڵ� ����
                SELECT MAX(S.ACCT_SUS_CODE) INTO V_SUSPEND_CODE
                FROM TBL_WARNING W LEFT JOIN TBL_ACOUNT_SUSPEND S
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
    
    
/*
"���͵������Ʈ -> (sysdate ���͵����ᳯ¥���� �̷�)  �⼮��,�������� �����(����������� �̷��� �����͵鸸 ��� ����)
                               (�������۾ȵ�) -> ���� ������ ���͵�� ��� ��û��¥ null�� ������Ʈ(�Լ�/���ν��� ȣ��)"
*/    
CREATE OR REPLACE TRIGGER AFTER_UPDATE_STUDY_TRG
    AFTER 
    UPDATE ON TBL_STUDY_OPEN
    FOR EACH ROW
    DECLARE
    
    BEGIN
        --���� ��¥�� �������Ϸ� ������Ʈ�ƴٸ� �⼮��/�������� ������ �����
        IF (:OLD.END_DATE != :NEW.END_DATE AND :NEW.END_DATE <= SYSDATE)
        THEN
            -- �������� �����
            DELETE
            FROM TBL_STUDY_SCHEDULE S 
            WHERE EXISTS(
                SELECT *
                FROM TBL_STUDY_ATTEND A
                WHERE A.ATTEND_CODE = S.ATTEND_CODE
                 AND A.ATTEND_DATE > :NEW.END_DATE
            );
            
            -- �⼮�� �����
            DELETE
            FROM TBL_STUDY_ATTEND
            WHERE ATTEND_DATE > :NEW.END_DATE;
            
        -- ���۳�¥�� ���纸�� �����̸�(���� ���� ����) ���� ������ ���͵�� ��� ��û��¥ NULL�� ������Ʈ
        ELSIF (:NEW.START_DATE < SYSDATE)
            THEN 
        END IF;
    
    
    END;





    







































    