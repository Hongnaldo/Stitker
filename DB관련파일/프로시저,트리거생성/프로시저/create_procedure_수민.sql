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
