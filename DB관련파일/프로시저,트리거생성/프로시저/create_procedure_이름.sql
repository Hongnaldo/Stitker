--���� ���ν���(PROCEDURE) ���� ����--

CREATE OR REPLACE PROCEDURE ���ν�����(
-- �����

)
IS
BEGIN

END;

-- ������ ��ȸ
select * from user_sequences;

SET SERVEROUTPUT ON;
--=============================================== ���⼭ ���� �������ּ���~~


--�� ���͵� ���࿡ �ν�Ʈ���� �� -> �⼮�� + ��������(���� �⼮���ڵ常)�� �̸� ������ �μ�Ʈ
CREATE OR REPLACE PROCEDURE PRC_AC_INSERT(
 -- �����
 
)
IS



BEGIN



END;


--�� ���͵� ���۳�¥�� ���࿡ �μ�Ʈ ���� ���� ����� -> ��� ���̺� �μ�Ʈ
-- ����
-- 1. ���� ��¥�� ���͵� ���� ��¥�̴�.
-- 2. TBL_STUDY_APPLY���� APPLY_CODE�� �ִµ� TBL_STUDY_PARTICIPANT�� APPLY_CODE�� ����.


CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
IS
    V_START_DATE TBL_STUDY_OPEN.START_DATE%TYPE;     -- ���͵� ������
    V_APPLY_CODE TBL_STUDY_APPLY.APPLY_CODE%TYPE;    -- ���͵� ���� �ڵ�
    V_CALCEL_DATE TBL_STUDY_CALCEL.CANCEL_DATE%TYPE; -- ��� ó���� ��¥
    V_CANCEL_CODE TBL_STUDY_CALCEL.CANCEL_CODE%TYPE; -- ���͵� ��� �ڵ�
    V_STUDY_CODE TBL_STUDY_OPEN.STUDY_CODE%TYPE;     -- �ش� ���͵� �ڵ�
    V_TODAY DATE;                                    -- ���� ��¥ 

BEGIN

    SELECT START_DATE     -- ���͵� ������
        INTO V_START_DATE
    FROM TBL_STUDY_OPEN
    WHERE STUDY_CODE = (SELECT STUDY_CODE FROM TBL_STUDY_APPLY);
    
    SELECT APPLY_CODE     -- ���͵� ���� �ڵ�
        INTO V_APPLY_CODE    
    FROM TBL_STUDY_APPLY
    WHERE STUDY_CODE = V_STUDY_CODE; 

    V_TODAY := CURRENT_DATE(); -- ���� ��¥
    
    LOOP
    IF (V_START_DATE = V_TODAY) AND (SELECT COUNT(*)
                                  FROM TBL_STUDY_PARTICIPANT
                                  WHERE APPLY_CODE = V_APPLY_CODE)=0   
        THEN INSERT INTO TBL_STUDY_CANCEL(CANCEL_CODE,APPLY_CODE,CANCEL_DATE) 
             VALUES(SC||STUDY_CANC_SEQ.NEXTVAL, V_APPLY_CODE, SYSDATE);
    END IF;  
        EXIT WHEN V_APPLY_CODE = MAX(V_APPLY_CODE);
    END LOOP;
END;


--�� ȸ�����Խ� ȸ���ڵ���� + ȸ����� 
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

/*-- TEST
SELECT *
FROM TAB;

SELECT COUNT(*)
FROM TBL_CURSE;

SELECT *
FROM TBL_CURSE;
*/

SELECT *
FROM USER_SEQUENCES;