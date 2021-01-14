
����������� �Ű� ��� ���⼭ ������ ���� 5ȸ�̸��̸� ������ ��¥�� ���� ����
--�� it, ������� ���� �Ű� ���� 

EXEC PRC_REPORT_REG_INFORM('GI58',5);


SELECT * 
FROM TBL_BOARD_INFORM;

SELECT * 
FROM TBL_REPORT_REG_INFORM;


TBL_REPORT_REG_INFORM
--�� �̸� �ش� �Խù��� �Ű� ������ 5ȸ�̸����� �Ǵ�
CREATE OR REPLACE PROCEDURE PRC_REPORT_REG_INFORM 
(  POST_CODE IN TBL_BOARD_INFORM.POST_CODE%TYPE )
IS

-- �Ű� ���� Ȯ�ο� 
V_POST_COUNT    NUMBER;
BEGIN
        -- ���� Ȯ��
        SELECT COUNT(*) AS T INTO V_POST_COUNT
        FROM TBL_REPORT_REG_INFORM R
        WHERE R.POST_CODE = POST_CODE;
        
        -- �Ű� ���� 5���̸��̸�
        IF(V_POST_COUNT <5)
        THEN
        CUR_REPORT_REG_INFORM(POST_CODE);
        END IF;
END;




--�� Ŀ���� �̿��� �Ű� ����
CREATE OR REPLACE PROCEDURE CUR_REPORT_REG_INFORM
(V_POST_CODE IN VARCHAR2
,V_KICK_NUM      NUMBER)
IS
    V_REPORT_DATE       DATE;
    
    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����)
    -- CURSOR Ŀ����
    
    CURSOR CUR_REPORT_REG_INFORM
    IS
    SELECT REPORT_DATE
    FROM TBL_REPORT_REG_INFORM
    WHERE POST_CODE = V_POST_CODE;
    
BEGIN
    -- Ŀ�� ����
    OPEN CUR_REPORT_REG_INFORM;
    
    -- Ŀ�� ���� �� ����������� �����͵� ó��(��Ƴ���)
    LOOP
            -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��FETCH��
            FETCH CUR_REPORT_REG_INFORM INTO V_REPORT_DATE;
            
            -- �Ű�¥�� 3���� �������� ����
            IF (ADD_MONTHS(V_REPORT_DATE, 36) <= SYSDATE)
            THEN 
                DELETE 
                FROM TBL_REPORT_REG_INFORM R
                WHERE R.POST_CODE = V_POST_CODE AND R.REPORT_DATE = V_REPORT_DATE;
            END IF;  
            
            
            -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����... NOTFOUND
            EXIT WHEN CUR_REPORT_REG_INFORM%NOTFOUND;
            
            
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_REPORT_REG_INFORM;
    
END;

--------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM TBL_STUDY_APPLY
ORDER BY STUDY_CODE
;
CREATE OR REPLACE PROCEDURE PRG_KICK_HANDLE_STUDY_CANCEL
( V_PARTI_KICKED_CODE   IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
, V_PARTI_KICK_CODE     IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
)
IS
    V_MEM_KICK_REG_CODE VARCHAR(15);
    V_TOT_APPLY_NUM NUMBER;             -- �� ��û�� ��
    V_CANCEL_NUM     NUMBER;             -- ����� ��� ��
    V_APPLY_NUM    NUMBER;                --  (�� ��û�� �� - ����� ��� ��)
    V_KICK_NUM      NUMBER;
    V_STUDY_CODE   VARCHAR2(15);
    V_APPLY_CODE    VARCHAR2(15);
BEGIN

    V_MEM_KICK_REG_CODE := 'KR'||MEM_KR_SEQ.NEXTVAL;
    
    -- �� �������� ���
    INSERT INTO TBL_MEM_KICK_REG
    (MEM_KICK_REG_CODE, PARTI_KICKED_CODE, PARTI_KICK_CODE, MEM_KICK_REG_DATE)
    VALUES(V_MEM_KICK_REG_CODE, V_PARTI_KICKED_CODE, V_PARTI_KICK_CODE, SYSDATE);
    
    -- ���͵� �ڵ� �޾ƿ���
    SELECT T.STUDY_CODE, T.APPLY_CODE INTO V_STUDY_CODE, V_APPLY_CODE
    FROM
    (
    SELECT A.STUDY_CODE, A.APPLY_CODE, K.PARTI_KICKED_CODE, K.MEM_KICK_REG_CODE
    FROM TBL_MEM_KICK_REG K JOIN TBL_STUDY_PARTICIPANT P
     ON K.PARTI_KICKED_CODE = P.PARTI_CODE
        JOIN TBL_STUDY_APPLY A
        ON A.APPLY_CODE = P.APPLY_CODE
    ) T
    WHERE T.PARTI_KICKED_CODE = V_PARTI_KICKED_CODE AND T.MEM_KICK_REG_CODE = V_MEM_KICK_REG_CODE;
    
    -- �� �ο�, �������� �� �ο�
    SELECT T.TOT_APPLY_NUM, T.CANCEL_NUM INTO V_TOT_APPLY_NUM, V_CANCEL_NUM
    FROM
    (
    SELECT COUNT(A.APPLY_CODE) TOT_APPLY_NUM, COUNT(C.CANCEL_CODE) CANCEL_NUM, A.STUDY_CODE STUDY_CODE
    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
       ON A.APPLY_CODE = C.APPLY_CODE
    GROUP BY A.STUDY_CODE
    ) T
    WHERE T.STUDY_CODE = V_STUDY_CODE;
    
    -- �� (�� ���͵� ��� - ����� ��� )���� ���͵� ������ �� Ȯ��
    V_APPLY_NUM := V_TOT_APPLY_NUM - V_CANCEL_NUM;
    
    -- �� �������� ���� �� Ȯ��
    SELECT COUNT(*) INTO V_KICK_NUM
    FROM TBL_MEM_KICK_REG
    WHERE PARTI_KICKED_CODE = V_PARTI_KICKED_CODE;
       
    
    IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- �������� ó��
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('KH'||MEM_KH_SEQ.NEXTVAL, V_MEM_KICK_REG_CODE, SYSDATE);
        
        -- ���͵� ��� ó��
        PRC_INSERT_CANCEL(V_APPLY_CODE, SYSDATE, 1);
        
        ELSE
        dbms_output.put_line('�����̴�');
    END IF;
    

END;










--------------------------------------
����
CREATE OR REPLACE PROCEDURE PRG_KICK_HANDLE_STUDY_CANCEL
( V_MEM_KICK_REG_CODE IN TBL_MEM_KICK_REG.MEM_KICK_REG_CODE%TYPE
, V_PARTI_KICKED_CODE   IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
)
IS
    V_APPLY_NUM    NUMBER;
    V_KICK_NUM      NUMBER;
    V_APPLY_CODE   VARCHAR2(15);
BEGIN
    -- �� ���͵� ������ �� Ȯ��
    SELECT COUNT(*) INTO V_APPLY_NUM
    FROM TBL_STUDY_PARTICIPANT
    WHERE PARTI_CODE = V_PARTI_KICKED_CODE;
    
    -- �� �������� ���� �� Ȯ��
    SELECT COUNT(*) INTO V_KICK_NUM
    FROM TBL_MEM_KICK_REG
    WHERE PARTI_KICKED_CODE = V_PARTI_KICKED_CODE;
    
    -- �� ���͵� ������ �ڵ� Ȯ��
    SELECT APPLY_CODE INTO V_APPLY_CODE
    FROM TBL_STUDY_PARTICIPANT
    WHERE PARTI_CODE = V_PARTI_KICKED_CODE;
    
    
    IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- �������� ó��
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('KH'||MEM_KH_SEQ.NEXTVAL, V_MEM_KICK_REG_CODE, SYSDATE);
        
        -- ���͵� ��� ó��
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('CC'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
        
        ELSE
        dbms_output.put_line('�����̴�');
    END IF;


END;
/*
--�� �������� ����Ҷ� üũ�ؼ� 50% �Ѿ����� ��������ó�� �μ�Ʈ+���ó���� �μ�Ʈ
CREATE OR REPLACE PROCEDURE PRG_KICK_HANDLE_STUDY_CANCEL
( V_MEM_KICK_REG_CODE IN TBL_MEM_KICK_REG.MEM_KICK_REG_CODE%TYPE
, V_PARTI_KICKED_CODE   IN TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE 
)
IS
    V_APPLY_NUM    NUMBER;
    V_KICK_NUM      NUMBER;
    V_APPLY_CODE   VARCHAR2(15);
BEGIN
    PRG_V_APPLY_NUM(V_PARTI_KICKED_CODE, V_APPLY_NUM);
    PRG_V_KICK_NUM(V_PARTI_KICKED_CODE, V_KICK_NUM);
    PRG_V_APPLY_CODE(V_PARTI_KICKED_CODE, V_APPLY_CODE);
    
    IF( V_KICK_NUM / V_APPLY_NUM >= 0.5 )
     THEN
        -- �������� ó��
        INSERT INTO TBL_MEM_KICK_HANDLE
        (MEM_KICK_HANDLE_CODE, MEM_KICK_REG_CODE, MEM_KICK_HANDLE_DATE)
        VALUES
        ('KH'||MEM_KH_SEQ.NEXTVAL, V_MEM_KICK_REG_CODE, SYSDATE);
        
        -- ���͵� ��� ó��
        INSERT INTO TBL_STUDY_CANCEL
        (CANCEL_CODE, APPLY_CODE, CANCEL_DATE)
        VALUES('CC'||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
        
        ELSE
        dbms_output.put_line('�����̴�');
    END IF;


END;
*/






















/*
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






-- �� 2�� �̿��µ� 1������ ��
/*
����������� �Ű� ��� ���⼭ ������ ���� 5ȸ�̸��̸� ������ ��¥�� ���� ����
--�� it, ������� ���� �Ű� ���� Ŀ�� ����
--�� Ŀ�� �̿� �� ��Ȳ
DECLARE
    V_REPORT_DATE       DATE;
    V_POST_CODE         VARCHAR2(10);
    V_POST_COUNT        NUMBER;
    
    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����)
    -- CURSOR Ŀ����
    
    -- �Խù� �ڵ� Ŀ��
    CURSOR CUR_POST_CODE
    IS
    SELECT POST_CODE
    FROM TBL_REPORT_REG_INFORM;
    
    -- ��¥ Ŀ��
    CURSOR CUR_REPORT_DATE
    IS
    SELECT REPORT_DATE
    FROM TBL_REPORT_REG_INFORM
    WHERE POST_CODE = V_POST_CODE;
    
    
BEGIN
        --  �Խù� Ŀ�� ����
        OPEN CUR_POST_CODE;
        
        -- 1��° Ŀ�� ���� �� ����������� �����͵� ó��(��Ƴ���)
        LOOP
               -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��FETCH��
                FETCH CUR_POST_CODE INTO V_POST_CODE; 
                
                -- �Ű� ������ 5�� �̸����� Ȯ��
                SELECT COUNT(*) INTO V_POST_COUNT
                FROM TBL_REPORT_REG_INFORM
                WHERE POST_CODE = V_POST_CODE;
                
                IF( V_POST_COUNT <5)
                THEN
                
                
                        -- ��¥ Ŀ�� ����
                        OPEN CUR_REPORT_DATE;
                        
                        -- 2��° Ŀ�� ���� �� ����������� �����͵� ó��(��Ƴ���)
                        LOOP
                                -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��FETCH��
                                FETCH CUR_REPORT_DATE INTO V_REPORT_DATE;
                                
                                -- �Ű�¥�� 3���� �������� ����
                                IF (ADD_MONTHS(V_REPORT_DATE, 36) <= SYSDATE)
                                THEN 
                                    DELETE 
                                    FROM TBL_REPORT_REG_INFORM R
                                    WHERE R.POST_CODE = V_POST_CODE AND R.REPORT_DATE = V_REPORT_DATE;
                                END IF;  
                                
                                
                                -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����... NOTFOUND
                                EXIT WHEN CUR_REPORT_DATE%NOTFOUND;
                                
                                
                        END LOOP; -- END 2��° �ݺ���
                        
                        -- Ŀ�� Ŭ����
                        CLOSE CUR_REPORT_DATE;
                
                END IF; -- END IF��
        
         -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����... NOTFOUND
        EXIT WHEN CUR_POST_CODE%NOTFOUND;        
                
        END LOOP -- END 1��° �ݺ��� 
    
END;
*/