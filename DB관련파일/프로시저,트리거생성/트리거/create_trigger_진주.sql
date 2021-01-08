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
    SELECT A.STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_PARTICIPANT P, TBL_STUDY_APPLY A
    WHERE P.APPLY_CODE = A.APPLY_CODE
      AND A.POSITION_CODE = 1; 
      
    SELECT CLOSE_DATE INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    IF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') <= TO_DATE(V_CLOSE_DATE, 'YYYY-MM-DD') )  -- <=?
        THEN UPDATE TBL_STUDY_OPEN
             SET CLOSE_DATE = SYSDATE
             WHERE STUDY_CODE = V_STUDY_CODE;
             
    END IF;
END;



--�� ���͵� ���� ���̺� INSERT ���� �� -> 
--  MAX_MEM�� MIN_MEM �̻����� üũ -> MIN_MEM���� ������ ���� �߻���Ŵ(�̿�)
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
    WHERE STUDY_CODE = :NEW.STUDY_CODE
      AND O.MIN_MEM_CODE = M.MEMNUM_CODE;
      
    SELECT M.MEMNUM AS MAX_MEM INTO V_MAX_MEM
    FROM TBL_STUDY_OPEN O, TBL_MEMNUM M
    WHERE STUDY_CODE = :NEW.STUDY_CODE
      AND O.MAX_MEM_CODE = M.MEMNUM_CODE;  
      
    IF ( V_MAX_MEM < V_MIN_MEM )
        THEN RAISE_APPLICATION_ERROR(-20003, '�ִ� �ο����� �ּ� �ο��� �̻��̾�� �մϴ�.');
    END IF;
END;
--==>> Trigger TRG_STD_OPEN_INSERT��(��) �����ϵǾ����ϴ�.



--�� Ż�� ���̺� INSERT ���� �� -> ȸ�� ��� ���̺��� ���� ����
CREATE OR REPLACE TRIGGER TRG_WDL_INSERT
    AFTER
    INSERT ON TBL_WITHDRAWAL_INFO
    FOR EACH ROW
DECLARE
BEGIN
    DELETE
    FROM TBL_USER_REGISTER
    WHERE USER_CODE = :NEW.USER_CODE;
END;
--==>> Trigger TRG_WDL_INSERT��(��) �����ϵǾ����ϴ�.




--�� ������̺� INSERT �� 		�� �� �� ��
-- -> ����������(START_DATE �������� ��������)üũ
-- -> ����(�ۼ���)���� üũ 
-- -> ������ �������̺� �����ִ� ����� �� ������ ���� ���� ����� ��å�� ������ ������Ʈ

CREATE OR REPLACE TRIGGER TRG_STD_CANC_INSERT
    AFTER
    INSERT ON TBL_STUDY_CANCEL
    FOR EACH ROW
DECLARE
    V_POSITION_CODE TBL_STUDY_POSITION.POSITION_CODE%TYPE;    -- ����� ������� POSITION_CODE
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE; -- ����� ������� USER_CODE
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;     -- ����� STUDY_CODE
    V_WRITER_CODE   TBL_USER_CODE_CREATE.USER_CODE%TYPE; -- ����� ���͵� �ۼ��� USER_CODE
    V_MAX_SCORE     TBL_SCORE.SCORE%TYPE;               -- ���͵� �����ִ� ����ڵ��� ���� �� ���� ���� ����
    V_NEW_LEADER    TBL_USER_CODE_CREATE.USER_CODE%TYPE; -- ���� ���� ������ ������� USER_CODE
BEGIN

    -- V_POSITION_CODE, V_USER_CODE 
    SELECT POSITION_CODE, USER_CODE INTO V_POSITION_CODE, V_USER_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = :NEW.APPLY_CODE;
    
    -- V_STUDY_CODE 
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = :NEW.APPLY_CODE;
    
    -- V_WRITER_CODE
    SELECT USER_CODE INTO V_WRITER_CODE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    -- V_MAX_SCORE
    SELECT MAX(SCORESUM) INTO V_MAX_SCORE
    FROM ( SELECT USER_CODE, SUM(SCORE) AS SCORESUM
           FROM TBL_STUDY_APPLY A, TBL_SCORE S
           WHERE STUDY_CODE = V_STUDY_CODE
             AND A.USER_CODE = S.USER_CODE
           GROUP BY USER_CODE);
    
    -- V_NEW_LEADER
    SELECT USER_CODE INTO V_NEW_LEADER
    FROM ( SELECT USER_CODE, SUM(SCORE) AS SCORESUM
           FROM TBL_STUDY_APPLY A, TBL_SCORE S
           WHERE STUDY_CODE = V_STUDY_CODE
             AND A.USER_CODE = S.USER_CODE
           GROUP BY USER_CODE)
    WHERE SCORESUM = V_MAX_SCORE;
    
    
    -- ������
    IF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') < TO_DATE(V_START_DATE, 'YYYY-MM-DD') )  --�� <= ??
        THEN            
        -- ��û ���̺� �ִ� ����� �߿� ���� ���� ������ ���� ����� ������
        IF ( V_USER_CODE = V_WRITER_CODE ) -- ����� ����� �ۼ��ڸ�
            THEN UPDATE TBL_STUDY_APPLY
                 SET POSITION_CODE = 1
                 WHERE USER_CODE = V_NEW_LEADER
                   AND STUDY_CODE = V_STUDY_CODE;
        ELSIF ( V_POSITION_CODE = 1 ) -- ����� ����� �����̸�
            THEN UPDATE TBL_STUDY_APPLY
                 SET POSITION_CODE = 1
                 WHERE USER_CODE = V_NEW_LEADER
                 AND STUDY_CODE = V_STUDY_CODE;
        END IF;
        
    ELSIF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') > TO_DATE(V_START_DATE, 'YYYY-MM-DD) )
            THEN 
            
              -- ���� ���̺�, ��û���̺� �Ѵ� �ִ� ����� �߿� ���� ���� ������ ���� ����� ������
            
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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5) 
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_INFORM (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('HI'||RPT_HD_INFORM_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); -- ó������ڵ�� NULL, ó�����ڴ� ����Ʈ SYSDATE
    END IF;
END;
--==>> Trigger TRG_RPT_REG_INFOM_INSERT��(��) �����ϵǾ����ϴ�.



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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5) 
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_INTERVIEW (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('HV'||RPT_HD_INTERVIEW_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_RPT_REG_INTEV_INSERT��(��) �����ϵǾ����ϴ�.



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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5) 
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_SEMINAR (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE)  
                    VALUES ('HS'||RPT_HD_SEMINAR_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_RPT_REG_SEMIN_INSERT��(��) �����ϵǾ����ϴ�.



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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_FREE (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('HF'||RPT_HD_FREE_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_RPT_REG_FREE_INSERT��(��) �����ϵǾ����ϴ�.



--�� ���� �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_QUESTION (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('HQ'||RPT_HD_QUESTION_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_RPT_REG_QUE_INSERT��(��) �����ϵǾ����ϴ�.



--�� �亯 �Խ��� �Ű� ��� ���̺� INSERT �� -> 5ȸ �׿����� üũ -> ������ �Ű�ó���� �μ�Ʈ
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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_ANSWER (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('HA'||RPT_HD_ANSWER_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_RPT_REG_ANS_INSERT��(��) �����ϵǾ����ϴ�.



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
    WHERE POST_CODE = :NEW.POST_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5)
        THEN 
        INSERT INTO TBL_REPORT_HANDLE_STUDYREVIEW (REPORT_HANDLE_CODE, POST_REPORT_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('HR'||RPT_HD_STUDYREVIEW_SEQ.NEXTVAL, :NEW.POST_REPORT_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_RPT_REG_STDREV_INSERT��(��) �����ϵǾ����ϴ�.



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
    WHERE STUDY_CODE = :NEW.STUDY_CODE;
    
    -- �Ű� 5ȸ �׿����� üũ�� ó��
    IF ( V_REG_CNT = 5)
        THEN 
        INSERT INTO TBL_STUDY_ACCUSE_HANDLE (ACCUSE_HANDLE_CODE, ACCUSE_CODE, HANDLE_RESULT_CODE) 
                    VALUES ('AH'||STUDY_ACC_HAN_SEQ.NEXTVAL, :NEW.ACCUSE_CODE, NULL); 
    END IF;
END;
--==>> Trigger TRG_STD_ACCU_INSERT��(��) �����ϵǾ����ϴ�.









