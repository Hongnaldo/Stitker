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
    
    
--�� �⼮�� ������Ʈ -> ��ǽð� �����ϴ��� üũ -> ����üũ�ؼ� �����̸� 5������,
--                                                ����üũ�ؼ� ����� 5�� ����

CREATE [OR REPLACE] TRIGGER TRI
    [BEFORE | AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��(���� ��� ���̺�)
    [FOR EACH ROW [WHEN TRIGGER ����]] --> �� ���� �پ������� ROW, ������ STATEMENT Ʈ����.
    [DECLARE]
        -- ���� ����;
    BEGIN
        -- ���౸��;
    END; 
