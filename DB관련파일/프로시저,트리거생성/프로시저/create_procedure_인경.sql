--���� ���ν���(PROCEDURE) ���� ����--

CREATE OR REPLACE PROCEDURE ���ν�����(
-- �����

)
IS
BEGIN

END;


--�� ���͵� ���۳�¥�� �������̺� �μ�Ʈ ���� ���� ����� -> ��� ���̺� �μ�Ʈ

-- ����
-- 1. ���� ��¥ = ���͵� ���� ��¥
-- 2. TBL_STUDY_APPLY���� APPLY_CODE�� �ִµ� TBL_STUDY_PARTICIPANT �� APPLY_CODE�� ����.

CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
IS
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;            -- ���͵� ������
    V_PARTI_CODE TBL_STUDY_PARTICIPANT.PARTI_CODE%TYPE;     -- ���͵� �����ڵ� ���� ����
    V_APPLY_CODE TBL_STUDY_APPLY.APPLY_CODE%TYPE;           -- ���͵� ���� �ڵ�
    V_CANCEL_CODE TBL_STUDY_CANCEL.CANCEL_CODE%TYPE;        -- ���͵� ��� �ڵ�
    V_STUDY_CODE TBL_STUDY_OPEN.STUDY_CODE%TYPE;            -- �ش� ���͵� �ڵ�
    V_TODAY DATE;                                           -- ���� ��¥ 
    V_I  NUMBER;                                            -- FOR ī����
    V_MEMCNT NUMBER;                                        -- ���͵� ������û �ο���  
    

BEGIN
    
  
    SELECT COUNT(*) INTO V_MEMCNT     -- ���͵� ���� ��û�� �� �ο� ��
    FROM TBL_STUDY_APPLY
    WHERE STUDY_CODE = (SELECT STUDY_CODE FROM TBL_STUDY_OPEN);
    
    
    SELECT START_DATE     -- ���͵� ������
        INTO V_START_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = (SELECT STUDY_CODE FROM TBL_STUDY_APPLY);
     
                     
    V_TODAY := CURRENT_DATE(); -- ���� ��¥
    
    FOR V_I IN 1.. V_MEMCNT LOOP
        SELECT PPC , AAC INTO V_PARTI_CODE, V_APPLY_CODE
        FROM (SELECT ROWNUM, A.APPLY_CODE AAC, A.USER_CODE AUC,P.PARTI_CODE PPC   
              FROM TBL_STUDY_APPLY A, TBL_STUDY_PARTICIPANT P
              WHERE A.APPLY_CODE = P.APPLY_CODE(+) 
              AND P.APPLY_CODE IS NULL)   
        WHERE ROWNUM = V_I;
        
        IF V_PARTI_CODE IS NULL AND (V_START_DATE = V_TODAY)
            THEN INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE, APPLY_CODE, CANCEL_DATE, AUTO_CANCEL)
                        VALUES('CC'||STUDY_CANC_SEQ.NEXTVAL,V_APPLY_CODE,SYSDATE,1);
        END IF;
        
    END LOOP;
    
END;
--==>>Procedure PRC_SC_INSERT��(��) �����ϵǾ����ϴ�.




--�� ȸ�����Խ� ȸ�� �ڵ� ���� + ȸ�� ��� 
CREATE OR REPLACE PROCEDURE PRC_UC_REG_INSERT(                      -- ��������� �޾ƿ��� ��
  V_ID IN TBL_USER_REGISTER.ID%TYPE                                 -- ID
 ,V_PW IN TBL_USER_REGISTER.PW%TYPE                                 -- PW
 ,V_SSN IN TBL_USER_REGISTER.SSN%TYPE                               -- SSN    
 ,V_PW_SRCH_QUE_CODE IN TBL_USER_REGISTER.PW_SRCH_QUE_CODE%TYPE     -- ��й�ȣ ã�� �����ڵ�
 ,V_PW_SRCH_QUE_ANS IN TBL_USER_REGISTER.PW_SRCH_QUE_ANS%TYPE       -- ��й�ȣ ã�� ����
 ,V_INTEREST_MC_CODE IN TBL_USER_REGISTER.INTEREST_MC_CODE%TYPE     -- ���ɺо� �ߺз� �ڵ�
 ,V_LOC_MC_CODE IN TBL_USER_REGISTER.LOC_MC_CODE%TYPE               -- ���� �ߺз� �ڵ�
 ,V_JOB_MC_CODE IN TBL_USER_REGISTER.JOB_MC_CODE%TYPE               -- ���� �ߺз� �ڵ�
 ,V_EMAIL IN TBL_USER_REGISTER.EMAIL%TYPE                           -- �̸���
 ,V_NAME IN TBL_USER_REGISTER.NAME%TYPE                             -- �̸�
 ,V_STUDY_TYPE_CODE IN TBL_USER_REGISTER.STUDY_TYPE_CODE%TYPE       -- ���� ���͵� ����
)
IS
    V_USER_CODE TBL_USER_CODE_CREATE.USER_CODE%TYPE;                -- ����� �ڵ�
    
BEGIN
    
    V_USER_CODE := 'UC'||USER_CODE_CRE_SEQ.NEXTVAL; 
    
    INSERT INTO TBL_USER_CODE_CREATE(USER_CODE)                     -- ȸ�� �ڵ� ���� ���̺� �μ�Ʈ
    VALUES(V_USER_CODE);
    
    INSERT INTO TBL_USER_REGISTER(USER_CODE,ID,PW,SSN               -- ȸ�� ��� ���̺� �μ�Ʈ
    ,PW_SRCH_QUE_CODE, PW_SRCH_QUE_ANS,INTEREST_MC_CODE
    ,LOC_MC_CODE,JOB_MC_CODE,EMAIL,NAME, REGDATE, STUDY_TYPE_CODE)
    VALUES(V_USER_CODE, V_ID,V_PW,V_SSN
    ,V_PW_SRCH_QUE_CODE,V_PW_SRCH_QUE_ANS,V_INTEREST_MC_CODE
    ,V_LOC_MC_CODE, V_JOB_MC_CODE, V_EMAIL, V_NAME, SYSDATE, V_STUDY_TYPE_CODE);
    
    COMMIT;    -- Ŀ��
    
END;
--==>> Procedure PRC_UC_REG_INSERT��(��) �����ϵǾ����ϴ�.





--======================�������� �μ�Ʈ ���ν��� ���� ==========================

--�� ���͵� ���࿡ �ν�Ʈ���� �� -> �������� ���̺� �̸� ������ �μ�Ʈ
-- �⼮ ��ư, ��� ��ư ����.

/*

 
CREATE OR REPLACE PROCEDURE PRC_SP_INSERT
IS
    V_SCHEDUE_DATE TBL_STUDY_SCHEDULE.DATE%TYPE;
    V_PARTI_CODE TBL_STUDY_PARTICEPANT.PARTI_CODE%TYPE;  -- ���͵� ���� �ڵ�
    V_APPLY_CODE TBL_STUDY_PARTICIPANT.APPLY_CODE%TYPE;  -- ���͵� ���ڰ� �ڵ�
    V_ATTEND_CODE TBL_STUDY_ATTEND.ATTEND_CODE%TYPE;     -- �⼮�� �ڵ�
    CLOCK_IN TBL_STUDY_ATTEND.CLOCK_IN%TYPE;             -- �Խ� �ð�
    CLOCK_OUT TBL_STUDY_ATTEND.CLOCK_OUT%TYPE;           -- ��� �ð�
    SCHEDULE TBL_STUDY_SCHEDULE.SCHEDULE%TYPE;           -- ���͵� �������� 
    V_STUDY_CODE TBL_STUDY_APPLY.STUDY_CODE%TYPE;        -- ���͵� �ڵ�
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;        -- ���͵� ���۳�¥
    V_END_DATE TBL_STUDY_OPEN.END_DATE%TYPE;             -- ���͵� ���ᳯ¥

BEGIN
    
    -- �ش� ���͵��� ��¥, ���� ���ؿ��� 
     SELECT O.START_DATE , D.END_DATE INTO V_START_DATE , V_END_DATE
     FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
         ON A.PARTI_CODE = P.PARTI_CODE
            JOIN TBL_STUDY_APPLY AP 
            ON P.APPLY_CODE = AP.APPLY_CODE
                JOIN TBL_STUDY_OPEN O
                ON AP.STUDY_CODE = O.STUDY_CODE;
 
  
    SELECT STUDY_CODE
    FROM TBL_STUDY_APPLY
    WHERE APPLY_CODE = (SELECT APPLY_CODE
                        FROM TBL_STUDY_PARTICIPANT);
                        
    
    V_ATTEND_CODE
    
    -- ���͵� �������� ���̺� ������ �Է�
    INSERT INTO TBL_STUDY_SCHEDULE(ATTEND_CODE, SCHEDULE)
    VALUES();
    
    -- �⼮�� ���̺� ������ �Է�
    FOR V_I 1..���͵��ѳ�¥
        INSERT INTO TBL_STUDY_ATTEND(ATTEND_CODE, PARTI_CODE, ATTEND_DATE,CLOCK_IN,CLOCK_OUT)
        VALUES('SA'||STUDY_ATT_SEQ.NEXTVAL,�����ڵ�,ù°��,NULL,NULL);
    END LOOP;
    
END;
*/

SELECT *
FROM TAB;

SELECT *
FROM USER_SEQUENCES;