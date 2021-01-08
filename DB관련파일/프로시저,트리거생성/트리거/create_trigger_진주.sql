--���� Ʈ����(TRIGGER) ���� ����--

--�� ���͵� ���� ���̺� INSERT -> ���������� ������ INSERT�ƴ��� üũ
-- -> ������ ���͵𰳼� ���̺��� ������������ UPDATE

CREATE OR REPLACE TRIGGER TRG_STD_PARTI_INSERT
    AFTER
    INSERT ON TBL_STUDY_PARTICIPANT
DECLARE
    V_STUDY_CODE TBL_STUDY_OPEN.STUDY_CODE%TYPE;
    V_CLOSE_DATE TBL_STUDY_OPEN.CLOSE_DATE%TYPE;
BEGIN
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_PARTICIPANT P, TBL_STUDY_APPLY A
    WHERE P.APPLY_CODE = A.APPLY_CODE
      AND A.POSITION_CODE = 1;
      
    SELECT CLOSE_DATE INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    IF ( SYSDATE < V_CLOSE_DATE )
        THEN UPDATE TBL_STUDY_OPEN
             SET CLOSE_DATE = SYSDATE
             WHERE STUDY_CODE = V_STUDY_CODE;
             
    END IF;
END;

--==>> Trigger TRG_STD_PARTI_INSERT��(��) �����ϵǾ����ϴ�.



--�� ���͵� ���� ���̺� INSERT ���� �� -> MAX_MEM�� MIN_MEM �̻����� üũ -> MIN_MEM���� ������ ���� �߻���Ŵ(�̿�)
CREATE OR REPLACE TRIGGER TRG_STD_OPEN_INSERT
    BEFORE
    INSERT ON TBL_STUDY_OPEN
    FOR EACH ROW
DECLARE
    V_MIN_MEM TBL_MEMNUM.MEMNUM%TYPE;
    V_MAX_MEM TBL_MEMNUM.MEMNUM%TYPE;    
BEGIN 
    SELECT M.MEMNUM AS MIN_MEM INTO V_MIN_MEM
    FROM TBL_STUDY_OPEN O, TBL_MEMNUM M
    WHERE STUDY_CODE = INSERT�� ���͵��ڵ�
      AND O.MIN_MEM_CODE = M.MEMNUM_CODE;
      
    SELECT M.MEMNUM AS MAX_MEM INTO V_MAX_MEM
    FROM TBL_STUDY_OPEN O, TBL_MEMNUM M
    WHERE STUDY_CODE = INSERT�� ���͵��ڵ� -- :NEW.STUDY_CODE �ȵ�.
      AND O.MAX_MEM_CODE = M.MEMNUM_CODE;  
      
    IF ( V_MAX_MEM < V_MIN_MEM )
        THEN RAISE_APPLICATION_ERROR(-20003, '�ִ� �ο����� �ּ� �ο��� �̻��̾�� �մϴ�.');
    END IF;
END;



























--�� ���������Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_INFOM_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_INFORM
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_INFORM
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0) -- �׳� V_REG_CNT = 0 ���??
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_INFORM (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); -- ó������� 'ó����'���� �ǹ̷� �־���ҰŰ���
    END IF;
END;


--�� ����,�ڵ��׽�Ʈ �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_INTEV_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_INTERVIEW
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_INTERVIEW
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_INTERVIEW (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;


--�� ������/���̳� �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_SEMIN_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_SEMINAR
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_SEMINAR
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_SEMINAR (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;


--�� ���� �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_FREE_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_FREE
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_FREE
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_FREE (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;


--�� �亯 �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_QUE_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_QUESTION
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_QUESTION
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_QUESTIONE (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;


--�� ���� �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_ANS_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_ANSWER
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_ANSWER
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_ANSWER (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;


--�� ���͵� �ı� �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_RPT_REG_STDREV_INSERT
    AFTER
    INSERT ON TBL_REPORT_REG_STUDYREVIEW
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_REPORT_REG_STUDYREVIEW
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_STUDYREVIEW (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;


--�� ���͵� ���� �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
CREATE OR REPLACE TRIGGER TRG_STD_ACCU_INSERT
    AFTER
    INSERT ON TBL_STUDY_ACCUSE
    FOR EACH ROW
DECLARE
    V_REG_CNT NUMBER;   -- Ư�� �Խù��� �Ű� ���� ���� 
BEGIN
    -- V_REG_CNT �ʱ�ȭ
    SELECT COUNT(*) AS CNT INTO V_REG_CNT
    FROM TBL_STUDY_ACCUSE
    WHERE POST_CODE = :NEW.POST_CODE
    
    -- �Ű� 5ȸ �׿�����(5�� ���) üũ�� ó��
    IF ( TRUNC(V_REG_CNT/5) = 0)
        THEN 
        INSERT INTO TBL_STUDY_ACCUSE_HANDLE (�Ű�ó���ڵ�, �Ű����ڵ�, ó�����) 
                    VALUES (�Ű�ó���ڵ�SEQ, �Ű����ڵ�, ó�����); 
    END IF;
END;