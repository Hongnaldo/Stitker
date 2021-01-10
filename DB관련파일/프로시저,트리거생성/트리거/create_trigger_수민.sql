--���� Ʈ����(TRIGGER) ���� ����--

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
        
    -- ���۳�¥�� ���纸�� �̷���(���� ���� ����) ���� ������ ���͵�� ��� ��û��¥ NULL�� ������Ʈ
    IF (:NEW.START_DATE > SYSDATE AND :NEW.HITCOUNT = :OLD.HITCOUNT)
        THEN PRC_UPDATE_DATE_NULL(:NEW.STUDY_CODE); 
    END IF;
END;
--==>> Trigger TRG_AFTER_UPDATE_STUDY��(��) �����ϵǾ����ϴ�.



-- �� ����
CREATE OR REPLACE VIEW STUDY_CANCEL_VIEW
AS
SELECT O.STUDY_CODE ���͵��ڵ�, A.APPLY_CODE �����ڵ�, A.USER_CODE ������, C.CANCEL_CODE ����ڵ�, C.CANCEL_DATE ��ҳ�¥, C.AUTO_CANCEL �ڵ���ҿ���, P.POSITION_CODE ��å, O.USER_CODE AS ������ 
     , O.START_DATE ������, O.END_DATE ������, M.MEMNUM AS �ּ��ο�, O.WRITE_DATE �ۼ���
FROM TBL_STUDY_APPLY A JOIN TBL_STUDY_OPEN O
    ON A.STUDY_CODE = O.STUDY_CODE
        JOIN TBL_MEMNUM M
        ON M.MEMNUM_CODE = O.MIN_MEM_CODE
            LEFT JOIN TBL_STUDY_CANCEL C
            ON C.APPLY_CODE = A.APPLY_CODE
                JOIN TBL_MEMNUM M2
                ON M2.MEMNUM_CODE = O.MAX_MEM_CODE
                    JOIN TBL_STUDY_POSITION P
                    ON A.POSITION_CODE = P.POSITION_CODE;
--==>> View STUDY_CANCEL_VIEW��(��) �����Ǿ����ϴ�.


---- ���͵����ó�� �μ�Ʈ Ʈ����
--CREATE OR REPLACE TRIGGER TRG_AFTER_INSERT_CANCEL
--AFTER 
--INSERT ON TBL_STUDY_CANCEL
--FOR EACH ROW
--DECLARE
--    V_STUDY TBL_STUDY_OPEN.STUDY_CODE%TYPE;
--    V_LEFT  NUMBER;
--    V_MIN   TBL_MEMNUM.MEMNUM%TYPE;
--    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;
--    V_END_DATE   TBL_STUDY_OPEN.END_DATE%TYPE;
--    V_AUTO_CANCEL   TBL_STUDY_CANCEL.AUTO_CANCEL%TYPE;
--    V_USER_CODE     TBL_USER_CODE_CREATE.USER_CODE%TYPE;
--    V_FIRSTLEADER   TBL_USER_CODE_CREATE.USER_CODE%TYPE;
--BEGIN
--    -- ���͵� �ڵ� ��������
--    SELECT STUDY_CODE INTO V_STUDY
--    FROM STUDY_CANCEL_VIEW
--    WHERE CANCEL_CODE = :NEW.CANCEL_CODE;
--    
--    -- �ش� ���͵� ���� ��� ����
--    SELECT COUNT(*) INTO V_LEFT
--    FROM TBL_STUDY_APPLY A LEFT JOIN TBL_STUDY_CANCEL C
--        ON A.APPLY_CODE = C.APPLY_CODE
--    WHERE CANCEL_CODE IS NULL;
--    
--    -- �ּ��ο�, ���۳�¥, ���ᳯ¥, �ڵ����ó������, ������ڵ� ��������
--    SELECT MINNUM, START_DATE, AUTO_CANCEL, USER_CODE, FIRSTLEADER
--        INTO V_MIN, V_START_DATE, V_AUTO_CANCEL, V_USER_CODE, V_FIRSTLEADER
--    FROM STUDY_CANCEL_VIEW
--    WHERE APPLY_CODE = :NEW.APPLY_CODE;
--        
--    -- �ּ��ο����� ���� ���� ���
--    IF (V_LEFT < V_MIN)
--    THEN 
--        -- ���͵� ���������� Ȯ��
--        IF (V_START_DATE < SYSDATE)
--        THEN
--            -- ���ּ��ο��̸�, ������ : ���͵� �����Ŵ.(���ᳯ¥ ���÷�.)
--            UPDATE TBL_STUDY_OPEN
--            SET END_DATE = SYSDATE
--            WHERE STUDY_CODE = V_STUDY;
--        END IF;
--    
--    -- �ּ��ο����� ���� ���� ��� �ڹ����� ������ Ȯ��(�ڹ����̸� NULL, �ڵ���Ҹ� 1)
--    ELSIF (V_AUTO_CANCEL IS NULL)
--    THEN
--        -- ���͵� ���������� Ȯ��
--        IF (V_START_DATE < SYSDATE)
--        THEN 
--            -- ��������, ������, �ڹ��� : -200
--            IF (V_FIRSTLEADER = V_USER_CODE)
--            THEN
--            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -200, SYSDATE);
--            
--            -- ��������, ������X, �ڹ��� : -100
--            ELSE
--            INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
--            
--            END IF;
--        ELSE
--            -- ���ּ��ο��̻�, ������X : �������� NULL�� ����
--            PRC_UPDATE_DATE_NULL(V_STUDY); 
--            
--            -- Ȯ���Ⱓ ������ 2������ Ȯ��
--            IF (SYSDATE BETWEEN V_START_DATE-1 AND V_START_DATE-2)
--            THEN
--                -- ��Ȯ���Ⱓ ������2��, ������, �ڹ��� : -100
--                IF (V_FIRSTLEADER = V_USER_CODE)
--                THEN
--                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -100, SYSDATE);
--                    
--                -- ��Ȯ���Ⱓ ������2��, ������X, �ڹ��� : -30    
--                ELSE
--                    INSERT INTO TBL_SCORE VALUES('SR'||STUDY_SCOR_SEQ.NEXTVAL, V_USER_CODE, -30, SYSDATE);
--                END IF;
--            END IF;            
--        END IF;
--    END IF;  
--    
--END;
----==>> Trigger TRG_AFTER_INSERT_CANCEL��(��) �����ϵǾ����ϴ�.
--
--DROP TRIGGER TRG_AFTER_INSERT_CANCEL;


