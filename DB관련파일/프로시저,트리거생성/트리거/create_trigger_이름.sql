--■■■ 트리거(TRIGGER) 생성 ■■■--

CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명(장착 대상 테이블)
    [FOR EACH ROW [WHEN TRIGGER 조건]] --> 이 구문 붙어있으면 ROW, 없으면 STATEMENT 트리거.
    [DECLARE]
        -- 선언 구문;
    BEGIN
        -- 실행구문;
    END;    
    
    
--○ 출석부 업데이트 -> 퇴실시간 존재하는지 체크 -> 지각체크해서 지각이면 5점감점,
--                                                조퇴체크해서 조퇴면 5점 감점

CREATE [OR REPLACE] TRIGGER TRI
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명(장착 대상 테이블)
    [FOR EACH ROW [WHEN TRIGGER 조건]] --> 이 구문 붙어있으면 ROW, 없으면 STATEMENT 트리거.
    [DECLARE]
        -- 선언 구문;
    BEGIN
        -- 실행구문;
    END; 
