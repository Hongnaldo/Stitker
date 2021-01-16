--���� Ʈ����(TRIGGER) ���� ����--

CREATE[OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE | AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��(���� ��� ���̺�)
    [FOR EACH ROW [WHEN TRIGGER ����]] --> �� ���� �پ������� ROW, ������ STATEMENT Ʈ����.
    [DECLARE]
        -- ���� ����;
    BEGIN
        -- ���౸��;
    END;    
    
    
--���͵� ���� BEFORE Ʈ���� : �Ű� 1���� ������ ����, ������ ���� ���͵�� ���� ����.
CREATE OR REPLACE TRIGGER TRG_STUDY_OPEN
    BEFORE
    UPDATE ON TBL_STUDY_OPEN 
    FOR EACH ROW 
DECLARE
 V_CLOSE_DATE TBL_STUDY_OPEN.CLOSE_DATE%TYPE;  -- ������ 
 V_REG_NUM    NUMBER;                          -- �Ű��
 V_ERROR_MSG  VARCHAR2(50);                    -- ����MSG
BEGIN
    
    SELECT COUNT(*) INTO V_REG_NUM         -- ���͵� �Ű�� 
    FROM TBL_STUDY_ACCUSE
    WHERE STUDY_CODE = :NEW.STUDY_CODE;
    
    SELECT CLOSE_DATE INTO V_CLOSE_DATE                     -- ���͵� ������
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = :NEW.STUDY_CODE;

    IF V_REG_NUM >1
        THEN DBMS_OUTPUT.PUT_LINE('�Ű�� �Խñ��� ������ �� �����ϴ�.');
    ELSIF SYSDATE > V_CLOSE_DATE 
          THEN DBMS_OUTPUT.PUT_LINE('�������� ���� �Խñ��� ������ �� �����ϴ�.');
   /*        
    ELSE 
         UPDATE TBL_STUDY_OPEN
         SET STUDY_TYPE_CODE = :NEW.STUDY_TYPE_CODE , INTEREST_MC_CODE = :NEW.INTEREST_MC_CODE
            ,END_DATE = :NEW.END_DATE , MAX_MEM_CODE = :NEW.MAX_MEM_CODE , STUDY_NAME = :NEW.STUDY_NAME
            ,STUDY_DESC = :NEW.STUDY_DESC, LOC_MC_CODE = :NEW.LOC_MC_CODE
         WHERE STUDY_CODE = :NEW.STUDY_CODE;
    */ 
    ELSE 
        DBMS_OUTPUT.PUT_LINE('���� ����');
    END IF;  
    
END;    


--DESC TBL_STUDY_ACCUSE;
--==>>Trigger TRG_STUDY_OPEN��(��) �����ϵǾ����ϴ�.


UPDATE TBL_STUDY_OPEN
SET STUDY_NAME ='���� �Ⱦƿ�'
WHERE STUDY_CODE = 'SO9';


SELECT *
FROM TBL_STUDY_OPEN;

SELECT COUNT(*) AS COUNT
FROM TBL_STUDY_ACCUSE
WHERE STUDY_CODE = 'SO27';


