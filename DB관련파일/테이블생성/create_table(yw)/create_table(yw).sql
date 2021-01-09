-- 영욱

--○ 스터디 신고 등록 테이블 생성
CREATE TABLE TBL_STUDY_ACCUSE
( ACCUSE_CODE        VARCHAR(20)     NOT NULL
, STUDY_CODE          VARCHAR(10)     NOT NULL
, USER_CODE            VARCHAR(10)     NOT NULL
, ACCUSE_DATE         DATE      DEFAULT SYSDATE  NOT NULL
, ACCUSE_REASON     VARCHAR(300)     NOT NULL
, POST_REPORT_CTG_CODE   VARCHAR(10)     NOT NULL
, CONSTRAINT STUDY_ACCUSE_AC_PK PRIMARY KEY(ACCUSE_CODE)
, CONSTRAINT STUDY_ACCUSE_SC_FK FOREIGN KEY(STUDY_CODE)
                     REFERENCES TBL_STUDY_OPEN(STUDY_CODE)
, CONSTRAINT STUDY_ACCUSE_UC_FK FOREIGN KEY(USER_CODE)
                     REFERENCES TBL_USER_CODE_CREATE(USER_CODE)            
, CONSTRAINT STUDY_ACCUSE_PRCC_FK FOREIGN KEY(POST_REPORT_CTG_CODE)
                     REFERENCES TBL_POST_REPORT_CTG(POST_REPORT_CTG_CODE)                    
);


--○ 스터디 신고 등록 테이블 (복제) 생성
CREATE TABLE TBL_STUDY_ACCUSE2
( ACCUSE_CODE        VARCHAR(20)     NOT NULL
, STUDY_CODE          VARCHAR(10)     NOT NULL
, USER_CODE            VARCHAR(10)     NOT NULL
, ACCUSE_DATE         DATE      DEFAULT SYSDATE  NOT NULL
, ACCUSE_REASON     VARCHAR(300)     NOT NULL
, POST_REPORT_CTG_CODE   VARCHAR(10)     NOT NULL
);


DROP TABLE TBL_STUDY_ACCUSE;
--○ 스터디 신고처리 테이블 생성
CREATE TABLE TBL_STUDY_ACCUSE_HANDLE
( ACCUSE_HANDLE_CODE        VARCHAR(20)     NOT NULL
, ACCUSE_CODE                    VARCHAR(20)     NOT NULL
, HANDLE_RESULT_CODE         VARCHAR(10)
, ACCUSE_HANDLE_DATE         DATE
, CONSTRAINT STUDY_ACCUSE_HANDLE_AHC_PK PRIMARY KEY(ACCUSE_HANDLE_CODE)
, CONSTRAINT STUDY_ACCUSE_HANDLE_AC_FK FOREIGN KEY(ACCUSE_CODE)
                     REFERENCES TBL_STUDY_ACCUSE(ACCUSE_CODE)
, CONSTRAINT STUDY_ACCUSE_HANDLE_HRC_FK FOREIGN KEY(HANDLE_RESULT_CODE)
                     REFERENCES TBL_HANDLE_RESULT(HANDLE_RESULT_CODE)  
);


--○ 욕설 테이블 생성
CREATE TABLE TBL_CURSE
( CURSE_CODE                  VARCHAR(20)     NOT NULL
, CURSE_KIND                   VARCHAR(300)     NOT NULL
, CONSTRAINT CURSE_CC_PK PRIMARY KEY(CURSE_CODE)
);


--○ 고객센터(1:1문의) 테이블 생성
CREATE TABLE TBL_ASK
( ASK_CODE                    VARCHAR(20)     NOT NULL 
, USER_CODE                   VARCHAR(10)     NOT NULL 
, ASK_TITLE                     VARCHAR(300)     NOT NULL  
, ASK_CONTENT               VARCHAR(4000)     NOT NULL 
, ASK_DATE                   DATE      DEFAULT SYSDATE  NOT NULL
, ASK_ANSWER                VARCHAR(4000)
, ASK_ANSWER_DATE       DATE
, ADMIN_CODE               VARCHAR(20)
, CONSTRAINT ASK_AC_PK PRIMARY KEY(ASK_CODE)
, CONSTRAINT ASK_UC_FK FOREIGN KEY(USER_CODE)
                     REFERENCES TBL_USER_CODE_CRATE(USER_CODE)
, CONSTRAINT ASK_HRC_FK FOREIGN KEY(ADMIN_CODE)
                     REFERENCES TBL_ADMIN(ADMIN_CODE)
);


--○ 고객센터(공지사항) 테이블 생성
CREATE TABLE TBL_NOTICE
( NOTICE_CODE                    VARCHAR(20)     NOT NULL 
, NOTICE_DATE                     DATE      DEFAULT SYSDATE  NOT NULL
, NOTICE_TITLE                     VARCHAR(300)     NOT NULL  
, NOTICE_CONTENT               VARCHAR(4000)     NOT NULL 
, ADMIN_CODE                    VARCHAR(20)     NOT NULL 
, HITCOUNT                        NUMBER DEFAULT 0
, CONSTRAINT NOTICE_NC_PK PRIMARY KEY(NOTICE_CODE)
, CONSTRAINT NOTICE_AC_FK FOREIGN KEY(ADMIN_CODE)
                     REFERENCES TBL_ADMIN(ADMIN_CODE)
);


--○ 관리자 테이블 생성
CREATE TABLE TBL_ADMIN
( ADMIN_CODE                    VARCHAR(20)     NOT NULL 
, ADMIN_ID                         VARCHAR(20)     NOT NULL 
, ADMIN_PW                       VARCHAR(20)     NOT NULL 
, CONSTRAINT ADMIN_AC_PK PRIMARY KEY(ADMIN_CODE)
);