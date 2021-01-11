--���� Ʈ����(TRIGGER) ���� ����--

--�� ���͵� ���� ���̺� INSERT -> ���������� ������ INSERT�ƴ��� üũ
-- -> ������ ���͵𰳼� ���̺��� ������������ UPDATE
CREATE OR REPLACE TRIGGER TRG_STD_PARTI_INSERT
    AFTER
    INSERT ON TBL_STUDY_PARTICIPANT
    FOR EACH ROW
DECLARE
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE; -- ������ ���͵� �ڵ�
    V_CLOSE_DATE    TBL_STUDY_OPEN.CLOSE_DATE%TYPE; -- �� ���͵��� ���� ���� ������
BEGIN
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = :NEW.APPLY_CODE
      AND POSITION_CODE = 'SP1'; 
      
    SELECT CLOSE_DATE INTO V_CLOSE_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    IF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') < TO_DATE(V_CLOSE_DATE, 'YYYY-MM-DD') )
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

    SELECT MEMNUM AS MIN_MEM INTO V_MIN_MEM
    FROM TBL_MEMNUM 
    WHERE MEMNUM_CODE = :NEW.MIN_MEM_CODE;

    SELECT MEMNUM AS MAX_MEM INTO V_MAX_MEM
    FROM TBL_MEMNUM
    WHERE MEMNUM_CODE = :NEW.MAX_MEM_CODE;  

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




--�� ������̺� INSERT ��
-- -> ����������(START_DATE �������� ��������)üũ
-- -> ����(�ۼ���)���� üũ 
-- -> ������ �������̺� �����ִ� ����� �� ������ ���� ���� ����� ��å�� ������ ������Ʈ

-- ���� �� : EXEC PRC_STD_CANC_INSERT(��û�ڵ�)
-- ���� �� : EXEC PRC_STD_CANC_INSERT(��û�ڵ�, ����ĵ����)

CREATE OR REPLACE PROCEDURE PRC_STD_CANC_INSERT
( V_APPLY_CODE    IN TBL_STUDY_APPLY.APPLY_CODE%TYPE
--, V_AUTO_CANCEL   IN TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE
)
IS
    V_POSITION_CODE TBL_STUDY_POSITION.POSITION_CODE%TYPE;  -- ����� ������� POSITION_CODE
    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- ����� ������� USER_CODE
    V_STUDY_CODE    TBL_STUDY_OPEN.STUDY_CODE%TYPE;         -- ����� STUDY_CODE
    V_WRITER_CODE   TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- ����� ���͵� �ۼ��� USER_CODE
    V_START_DATE    TBL_STUDY_OPEN.START_DATE%TYPE;         -- ���͵� ������
    V_NEW_LEADER    TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- ������, ���� ���� ������ ������� USER_CODE
    P_NEW_LEADER    TBL_USER_CODE_CREATE.USER_CODE%TYPE;    -- ������, ���� ���� ������ ������� USER_CODE   
    

BEGIN

    
    -- ���� ĵ�� ���� �Է¹޾ƾ� �ϸ� �Է� ������ �̰� ����
    --INSERT INTO TBL_STUDY_CANCEL (CANCEL_CODE, APPLY_CODE, AUTO_CANCEL)
    --VALUES ('SC'|| STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, V_AUTO_CANCEL);
    
    -- ���͵� ���
    INSERT INTO TBL_STUDY_CANCEL (CANCEL_CODE, APPLY_CODE)
    VALUES ('SC'|| STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE);
    
    
    -- V_POSITION_CODE, V_USER_CODE 
    SELECT POSITION_CODE, USER_CODE INTO V_POSITION_CODE, V_USER_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = V_APPLY_CODE;  
    
    -- V_STUDY_CODE 
    SELECT STUDY_CODE INTO V_STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = V_APPLY_CODE;
    
    -- V_WRITER_CODE
    SELECT USER_CODE INTO V_WRITER_CODE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
    -- V_START_DATE
    SELECT START_DATE INTO V_START_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = V_STUDY_CODE;
    
   -- V_NEW_LEADER 
    SELECT USER_CODE INTO V_NEW_LEADER  
    FROM ( SELECT A.USER_CODE, SUM(S.SCORE) AS SCORESUM
           FROM TBL_STUDY_APPLY A, TBL_SCORE S
           WHERE STUDY_CODE = V_STUDY_CODE
             AND A.USER_CODE = S.USER_CODE
             AND A.USER_CODE NOT IN (   -- ��û���̺� ������ ����� ������� USER_CODE
                                        SELECT USER_CODE
                                        FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
                                        WHERE A.STUDY_CODE =V_STUDY_CODE
                                          AND A.APPLY_CODE IN ( SELECT APPLY_CODE
                                                                FROM TBL_STUDY_CANCEL)
                                          AND C.APPLY_CODE IN (SELECT APPLY_CODE
                                                                FROM TBL_STUDY_APPLY
                                                                WHERE STUDY_CODE =V_STUDY_CODE)
                                        GROUP BY USER_CODE) 
           GROUP BY A.USER_CODE
           ORDER BY SCORESUM DESC )
    WHERE ROWNUM=1;
    
    -- P_NEW_LEADER
    SELECT USER_CODE INTO P_NEW_LEADER
    FROM 
    (   SELECT T.USER_CODE, SUM(S.SCORE) AS MAX_SCORE
        FROM 
        ( SELECT A.APPLY_CODE, A.STUDY_CODE, A.USER_CODE, A.POSITION_CODE
          FROM TBL_STUDY_APPLY A, TBL_STUDY_PARTICIPANT P
          WHERE A.APPLY_CODE = P.APPLY_CODE
            AND A.USER_CODE NOT IN (    -- ��û���̺� ������ ����� ������� USER_CODE
                                        SELECT USER_CODE
                                        FROM TBL_STUDY_CANCEL C , TBL_STUDY_APPLY A
                                        WHERE A.STUDY_CODE =V_STUDY_CODE
                                          AND A.APPLY_CODE IN ( SELECT APPLY_CODE
                                                                FROM TBL_STUDY_CANCEL)
                                          AND C.APPLY_CODE IN (SELECT APPLY_CODE
                                                                FROM TBL_STUDY_APPLY
                                                                WHERE STUDY_CODE =V_STUDY_CODE)
                                        GROUP BY USER_CODE)   
        ) T, TBL_SCORE S
        WHERE T.USER_CODE = S.USER_CODE
        GROUP BY T.USER_CODE
        ORDER BY MAX_SCORE DESC
    )
    WHERE ROWNUM=1;
    
    -- ������
    IF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') < TO_DATE(V_START_DATE, 'YYYY-MM-DD') )
        THEN            
        -- ��û ���̺� �ִ� ����� �߿� ���� ���� ������ ���� ����� ������
        IF ( V_POSITION_CODE = 'SP1' ) -- ����� ����� �����̸�
            THEN UPDATE TBL_STUDY_APPLY
                 SET POSITION_CODE = 'SP1'
                 WHERE USER_CODE = V_NEW_LEADER
                 AND STUDY_CODE = V_STUDY_CODE;
        END IF;
    
    -- ������  
    ELSIF ( TO_DATE(SYSDATE, 'YYYY-MM-DD') > TO_DATE(V_START_DATE, 'YYYY-MM-DD') ) -- ������
            THEN 
            -- ���� ���̺� �ִ� ����� �߿� ���� ���� ������ ���� ����� ������
            IF ( V_POSITION_CODE = 'SP1' ) -- ����� ����� �����̸�
            THEN UPDATE TBL_STUDY_APPLY
                 SET POSITION_CODE = 'SP1'
                 WHERE USER_CODE = P_NEW_LEADER
                 AND STUDY_CODE = V_STUDY_CODE;
            END IF;   
            
    END IF;
    
    -- Ŀ��
    COMMIT;
    
END;






