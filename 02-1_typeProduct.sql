-- 02-1.상품분류 테이블

-- 테이블 생성
create table productType (
no      number not null,
product_type  varchar2(50) not null,
primary key(no),
unique(product_type)
);

-- 시퀀스 생성
create sequence seq_productType start with 1 increment by 1 nomaxvalue nocache;

-- 데이터 삽입
insert into productType (no, product_type) values ('1', 'TV/AV');
insert into productType (no, product_type) values ('2', '주방가전');
insert into productType (no, product_type) values ('3', '생활가전');
insert into productType (no, product_type) values ('4', '에어컨/에어케어');
insert into productType (no, product_type) values ('5', '컴퓨터');

-- 테이블 검색
select * from productType order by no;
commit;