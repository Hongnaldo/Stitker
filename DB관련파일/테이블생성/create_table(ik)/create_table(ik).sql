--�� ȸ�� �ڵ� ���� ���̺� ����
CREATE TABLE TBL_USER_CODE_CREATE
(USER_CODE   VARCHAR2(10)                   -- ȸ���ڵ�(PK)
,CONSTRAINT USER_CODE_CREATE_UC_PK PRIMARY KEY(USER_CODE)
);
  
            
--�� ��й�ȣ ã�� ���� ���̺� ����
CREATE TABLE TBL_PW_SEARCH_QUE
(PW_SRCH_QUE_CODE  VARCHAR2(5)              -- ��й�ȣ ã�� ���� �ڵ�(PK)
,PW_SRCH_QUE       VARCHAR2(200) NOT NULL   -- ��й�ȣ ã�� ����
,CONSTRAINT PW_SRCH_QUE_PSQC_PK PRIMARY KEY(PW_SRCH_QUE_CODE)
);


--�� ���� ���� ��з� ���̺� ����
CREATE TABLE TBL_JOB_LC
(JOB_LC_CODE   VARCHAR2(10)                 -- ���� ��з� �ڵ�(PK)
,JOB_LC        VARCHAR2(100) NOT NULL       -- ����
,CONSTRAINT JOB_LC_JLC_PK PRIMARY KEY(JOB_LC_CODE)
);


--�� ���� ���� �ߺз� ���̺� ����
CREATE TABLE TBL_JOB_MC
(JOB_MC_CODE  VARCHAR2(10)                   -- ���� �ߺз� �ڵ�(PK)
,JOB_MC       VARCHAR2(100) NOT NULL         -- ����
,JOB_LC_CODE  VARCHAR2(10)  NOT NULL         -- ���� ��з� �ڵ�(FK)
,CONSTRAINT JOB_MC_JMC_PK PRIMARY KEY(JOB_MC_CODE)
,CONSTRAINT JOB_MC_JLC_FK FOREIGN KEY(JOB_LC_CODE)
            REFERENCES TBL_JOB_LC(JOB_LC_CODE)
);


--�� ���� ���� ��� ���̺� ����
CREATE TABLE TBL_ACCOUNT_SUSPEND
(ACCT_SUS_CODE   VARCHAR2(10)                       -- ���� ���� �ڵ�(PK)
,ACCT_SUS_DATE   DATE  DEFAULT SYSDATE NOT NULL     -- ���� ���� ����
,WARNING_CODE    VARCHAR2(15) NOT NULL              -- ��� ��� �ڵ�(FK)
,CONSTRAINT ACCT_SUS_ASC_PK PRIMARY KEY(ACCT_SUS_CODE)
,CONSTRAINT ACCT_SUS_WC_FK FOREIGN KEY(WARNING_CODE)
            REFERENCES TBL_WARNING(WARNING_CODE)
);


--�� Ż�� ī�װ� ���̺� ����
CREATE TABLE TBL_WITHDRAWAL_CATEGORY
(WDL_CTG_CODE   VARCHAR2(5)                 -- Ż�� ī�װ� �ڵ�(PK)
,WDL_CTG        VARCHAR2(50) NOT NULL       -- Ż�� ī�װ� �׸�
,CONSTRAINT WDL_CTG_WCC_PK PRIMARY KEY(WDL_CTG_CODE)
);


--�� Ż�� ��� �� �������� ���� ���̺� ����
CREATE TABLE TBL_WITHDRAWAL_INFO
(WDL_CODE       VARCHAR2(10)                        -- Ż�� �ڵ�(PK)
,WDL_DATE       DATE  DEFAULT SYSDATE NOT NULL      -- Ż�� ����
,WDL_CTG_CODE   VARCHAR2(5)   NOT NULL              -- Ż�� ī�װ� �ڵ�(FK)
,SSN            VARCHAR2(13)  NOT NULL              -- Ż���� �ֹι�ȣ
,USER_CODE      VARCHAR2(10)  NOT NULL              -- ����� �ڵ�
,WDL_REASON     VARCHAR2(200) NOT NULL              -- Ż�� ����
,CONSTRAINT WDL_INFO_WC_PK PRIMARY KEY(WDL_CODE)
,CONSTRAINT WDL_INFO_WCC_FK FOREIGN KEY(WDL_CTG_CODE)
            REFERENCES TBL_WITHDRAWAL_CATEGORY(WDL_CTG_CODE)
);


--�� ȸ�� ��� ���̺� ����          
CREATE TABLE TBL_USER_REGISTER
(USER_CODE         VARCHAR2(10)                     -- ����� �ڵ�(PK)
, ID               VARCHAR2(30)          NOT NULL   -- ���̵�
, PW               VARCHAR2(20)          NOT NULL   -- ��й�ȣ
, SSN              VARCHAR2(20)          NOT NULL   -- �ֹι�ȣ
, PW_SRCH_QUE_CODE VARCHAR2(5)           NOT NULL   -- ��й�ȣ ã�� ���� �ڵ�(FK)
, PW_SRCH_QUE_ANS  VARCHAR2(50)          NOT NULL   -- ��й�ȣ ã�� �亯
, INTEREST_MC_CODE VARCHAR2(5)           NOT NULL   -- ���� �о� �ߺз� �ڵ�(FK)
, LOC_MC_CODE      VARCHAR2(5)           NOT NULL   -- ���� �ߺз� �ڵ�(FK)
, JOB_MC_CODE      VARCHAR2(10)          NOT NULL   -- ���� ���� �ߺз� �ڵ�(FK)
, EMAIL            VARCHAR2(30)          NOT NULL   -- �̸���
, NAME             VARCHAR2(30)          NOT NULL   -- �̸�
, REGDATE          DATE  DEFAULT SYSDATE NOT NULL   -- ��������
, STUDY_TYPE_CODE  VARCHAR2(5)           NOT NULL   -- ���͵� ���� �ڵ�(FK)
,CONSTRAINT USER_REG_UC_PK PRIMARY KEY(USER_CODE)
,CONSTRAINT USER_REG_UC_FK FOREIGN KEY(USER_CODE)
            REFERENCES TBL_USER_CODE_CREATE(USER_CODE)
,CONSTRAINT USER_REG_PSQC_FK FOREIGN KEY(PW_SRCH_QUE_CODE)
            REFERENCES TBL_PW_SEARCH_QUE(PW_SRCH_QUE_CODE)
,CONSTRAINT USER_REG_IMC_FK FOREIGN KEY(INTEREST_MC_CODE)
            REFERENCES TBL_INTEREST_MC(INTEREST_MC_CODE)
,CONSTRAINT USER_REG_JMC_FK FOREIGN KEY(JOB_MC_CODE)
            REFERENCES TBL_JOB_MC(JOB_MC_CODE)
,CONSTRAINT USER_REG_STC_FK FOREIGN KEY(STUDY_TYPE_CODE)
            REFERENCES TBL_STUDY_TYPE(STUDY_TYPE_CODE)            
);