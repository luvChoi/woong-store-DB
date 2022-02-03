-- 02-2.상품업체 테이블

-- 테이블 생성
create table makerList (
no      number not null,
maker_name  varchar2(50) not null,
primary key(no),
unique(maker_name)
);

-- 시퀀스 생성
create sequence seq_makerList start with 1 increment by 1 nomaxvalue nocache;

-- 데이터 삽입
insert into makerList (no, maker_name) values ('1', '삼성전자');
insert into makerList (no, maker_name) values ('2', 'LG전자');
insert into makerList (no, maker_name) values ('3', '기타');

-- 테이블 검색
select * from makerList order by no;
commit;

