-- 07-1.취소사유 테이블

-- 테이블 생성
create table cancelType (
no      number not null,
cancel_type  varchar2(50) not null,
primary key(no)
);

-- 시퀀스 생성
create sequence seq_cancelType start with 1 increment by 1 nomaxvalue nocache;

-- 데이터 삽입
insert into cancelType (no, cancel_type) values ('1', '단순변심');
insert into cancelType (no, cancel_type) values ('2', '상품품절');
insert into cancelType (no, cancel_type) values ('3', '기타');

-- 테이블 검색
select * from cancelType order by no;
commit;