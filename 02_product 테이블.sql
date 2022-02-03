-- 02.상품 테이블

-- 테이블 생성
create table product (
no              number not null,
classification  varchar2(50) not null,
name            varchar2(50) not null,
maker           varchar2(50) not null,
purchase_price  number not null,
selling_price   number not null,
sale_percent    number not null,
stock           number not null,
info_thumbImg   varchar2(1000) not null,
description     clob not null,
delivery_charge number default '0' not null,
regi_date       date default sysdate not null,
upd_date        date default sysdate not null,
primary key(no),
foreign key(classification) references productType(product_type),
foreign key(maker) references makerList(maker_name)
);
desc product;

-- 상품 목록
select * from product order by no desc;

-- 상품 상세보기
select * from product where classification = 'TV/AV' order by selling_price desc;

-- 상품등록
insert into product
(no, classification, name, maker, purchase_price, selling_price, sale_percent, stock, info_thumbImg, description, regi_date)
values 
('5','1','1','1','1','1','1','1','1','1',sysdate);

-- 상품 수정
update product set info_thumbimg = '-|-|-'
where no in (2,3,4);

select nvl(max(no),0)+1 from product;
rollback;
commit;

-- 삭제
delete from product where no='4';

------------------------------------ 쇼핑몰 -------------------------------------

-- 신상 목록 호출
select * from (select rownum rnum, a.* from (select * from  product
where regi_date >= '21/12/01' order by regi_date desc) a)
where rnum between 1 and 6;

-- 베스트 상품 호출
select * from (select rownum rnum, tb.* from (select o.salesVol, p.* from product p,
(select product_no, sum(volume_order) salesVol from orderTB
where status != '취소완료' and order_date >= '21/06/01' group by product_no) o
where p.no = o.product_no
order by o.salesVol desc, p.regi_date) tb) tbtb
where rnum between 1 and 6;

------------------------------------ 구분별 -------------------------------------
-- 제품구분별 total record
select count(*) totalRecord from product where classification = 'TV/AV';

-- 제품구분별 목록
select * from (select rownum rnum, a.* from (select * from (select (selling_price * (100 - sale_percent)) last_price, p.* from product p)
where classification = 'TV/AV'
order by last_price desc) a)
where rnum between 1 and 6;

------------------------------------ 검색 -------------------------------------
-- 검색결과 totalRecord
select count(*) from product
where name like '%삼성%' or description like '%삼성%';

-- 검색결과
select * from (
    select rownum rnum, a.* from (
        select * from (select (selling_price * (100 - sale_percent)) last_price, p.* from product p)
        where description like '%삼성%' or description like '%삼성%'
    order by regi_date desc) a
)
where rnum between 1 and 8;
