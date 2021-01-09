--���� Ʈ����(TRIGGER) ���� ����--

CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE | AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��(���� ��� ���̺�)
    [FOR EACH ROW [WHEN TRIGGER ����]] --> �� ���� �پ������� ROW, ������ STATEMENT Ʈ����.
    [DECLARE]
        -- ���� ����;
    BEGIN
        -- ���౸��;
    END;    

--�� �⼮�� ������Ʈ -> ��ǽð� �����ϴ��� üũ -> ���� üũ�ؼ� �����̸� 5�� ����.
--                                                ���� üũ�ؼ� ����� 5�� ����.
--                                                �Ἦ�ϸ� 10�� ����....
-- USER_CODE  

-- �⼮��ư ������ �⼮ / ��ǹ�ư ������ ��� 
-- �⼮���ϰ� ��� �� �ϸ� �Ἦó��. 

CREATE OR REPLACE TRIGGER TRG_STD_ATND_INSERT
    AFTER
    INSERT ON TBL_STUDY_ATTEND
DECLARE
      V_CLOCK_IN TBL_STUDY_ATTEND.CLOCK_IN%TYPE;       -- �⼮�ð�
      V_CLOCK_OUT TBL_STUDY_ATTEND.CLOCK_OUT%TYPE;     -- ��ǽð�
      V_APPLY_CODE TBL_STUDY_APPLY.USER_CODE%TYPE;     -- ����� �ڵ� 
      V_SCORE TBL_SCORE.SCORE%TYPE;                    -- ����� ����
      V_START_TIME TBL_STUDY_MEETDAY.START_TIME%TYPE;  -- ���͵� ���� �ð�
      V_END_TIME TBL_STUDY_MEETDAY.END_TIME%TYPE;      -- ���͵� ���� �ð�
      
BEGIN
  
     SELECT AP.USER_CODE INTO V_USER_CODE              -- ����� �ڵ�
     FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
     ON A.PARTI_CODE = P.PARTI_CODE
        JOIN TBL_STUDY_APPLY AP 
        ON P.APPLY_CODE = AP.APPLY_CODE;

-- �� ���� 
 CREATE OR REPLACE VIEW STUDY_TIME_VIEW
 AS
 SELECT M.START_TIME, M.END_TIME 
 FROM TBL_STUDY_ATTEND A JOIN TBL_STUDY_PARTICIPANT P
     ON A.PARTI_CODE = P.PARTI_CODE
        JOIN TBL_STUDY_APPLY AP 
        ON P.APPLY_CODE = AP.APPLY_CODE
            JOIN TBL_STUDY_OPEN O
            ON AP.STUDY_CODE = O.STUDY_CODE
                JOIN TBL_STUDY_MEETDAY M
                ON O.STUDY_CODE = M.STUDY_CODE 
 WHERE M.WEEKDAY_CODE = (SELECT 'WD'||TO_CHAR(SYSDATE, 'D') FROM DUAL);
 --==>>View STUDY_TIME_VIEW��(��) �����Ǿ����ϴ�.
 
-- ���͵� ���Ϻ� ���۽ð� , ����ð�    
 SELECT START_TIME INTO V_START_TIME
 FROM STUDY_TIME_VIEW;
 
 SELECT END_TIME INTO V_END_TIME
 FROM STUDY_TIME_VIEW;
  
--SELECT * FROM TBL_WEEKDAY; --> �������� 1�� ������... �̤�
-- ������ ����(1:��, 2:��, 3:ȭ, 4:��, 5:��, 6:��, 7:��) : SELECT TO_CHAR(SYSDATE, 'D')FROM DUAL;
 
 
    SELECT CLOCK_IN INTO V_CLOCK_IN     -- �⼮ �ð�
    FROM TBL_STUDY_ATTEND 
    WHERE V_PARTI_CODE = :NEW.PARTI_CODE;
    
    SELECT CLOCK_OUT INTO V_CLOCK_OUT   -- ��ǽð�
    FROM TBL_STUDY_ATTEND
    WHERE V_PARTI_CODE = :NEW.PARTI_CODE;

     IF
       ��ǽð� IS NULL 
            THEN  IF(V_CLOCK_IN > ���͵���۽ð�)    -- ����üũ
                    THEN UPDATE TBL_SCORE
                    SET SCORE = :OLD.USER_SCORE -5;
                    WHERE USER_CODE = V_USER_CODE;
                  END IF;
     ELSE 
        V_CLOCK_OUT < ���͵� ����ð�                   -- ����
        THEN UPDATE TBL_SCORE
             SET SCORE =:OLD.USER_SCORE -5;
             WHERE USER_CODE = V_USER_CODE;
    END IF;  
    
    
END;

