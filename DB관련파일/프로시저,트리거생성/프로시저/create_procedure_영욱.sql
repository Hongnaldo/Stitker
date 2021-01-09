
����������� �Ű� ��� ���⼭ ������ ���� 5ȸ�̸��̸� ������ ��¥�� ���� ����
--�� it, ������� ���� �Ű� ���� 

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
(V_POST_CODE IN VARCHAR2 )
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