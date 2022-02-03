-- 05.주문 테이블
create table orderTB (
order_no            number,
order_product_no    number not null,
member_no           number not null, -- 비회원 경우도 생각해야함 Member No
product_no          number not null,
volume_order        number not null,
add_sale            number not null,
name                varchar2(50) not null,  -- 수령인
phone           varchar2(50) not null,      -- 수령인 연락처
addr_no         number not null,            -- 배송지 우편번호
addr1           varchar2(100) not null,     -- 배송지1
addr2           varchar2(100),              -- 배송지2
addr3           varchar2(100),              -- 배송지3
request_term    varchar2(200),              -- 요구사항
status          varchar2(50) default '결제완료' not null,
order_date      date default sysdate not null,
primary key(order_product_no),
foreign key(member_no) references member(no),
foreign key(product_no) references product(no)
);
desc orderTB;

commit;
rollback;
drop table orderTB;

alter table orderTB
modify order_no number unique;

select * from orderTB order by order_date desc, order_product_no desc;

-- 회원별 주문일자&주문번호 조회
select to_char(order_date,'yyyy-MM'), order_no from orderTB
where member_no = '2'
group by order_date, order_no
order by order_date desc;

-- 주문번호 조회(주문성공여부 확인)
select max(order_no) as order_no from orderTB where member_no = '2';

-- 회원 주문 내역 row 수 조회(FOR AJAX)
select count(*) rowCnt from (select o.order_no, p.name, p.selling_price, p.sale_percent, p.maker, p.info_thumbImg, o.volume_order, o.status, o.order_date
from product p, orderTB o
where (p.no = o.product_no)
and o.member_no = '2'
and order_date between '19/12/14' and to_date('2021/12/14', 'YY/MM/DD') + 0.99999
order by order_date desc, order_no desc, o.order_product_no desc);

-- 회원 주문 내역 불러오기
select rownum, A.* from (select o.order_no, p.name, p.selling_price, p.sale_percent, p.maker, p.info_thumbImg, o.volume_order, o.status, o.order_date
from product p, orderTB o
where (p.no = o.product_no)
and o.member_no = '2'
and order_date between '19/12/14' and to_date('2021/12/14', 'YY/MM/DD') + 0.99999
order by order_date desc, order_no desc, o.order_product_no desc) A
where rownum between 1 and (5 * 1);

-- 주문내역 상세보기
select o.*, p.name product_name, p.*
from orderTB o, product p
where (o.product_no = p.no)
and o.order_no = '13' and phone = '010-4848-4848'
order by order_product_no;

-- 취소요청 상품 정보 조회
select o.order_product_no, p.name product_name, o.volume_order, o.status
from orderTB o, product p
where (o.product_no = p.no)
and o.order_product_no = '20006';

-- 주문/결제 처리 (장바구니 결제)
insert into orderTB
select
(select nvl(max(order_no),0)+1 from orderTB), -- 한꺼번에 변경
(select nvl(max(order_product_no),0)+1 from orderTB),
member_no, product_no, volume_order, add_sale,
'신민아', '010-2222-3333','37929', '경북 포항시 남구 호미곶면 고래마을길 6', '공진 세트', '감리집',
'빠른배송 부탁드립니다.', '결제완료', sysdate
from cart
where cart_no = '3';

-- 주문/결제 처리 (상품 상세보기 결제)
insert into orderTB values(
(select nvl(max(order_no),0)+1 from orderTB),
(select nvl(max(order_product_no),0)+1 from orderTB),
 '2', '1', '1', '0',
'신민아', '010-2222-3333','37929', '경북 포항시 남구 호미곶면 고래마을길 6', '공진 세트', '감리집',
'빠른배송 부탁드립니다.', '결제완료', sysdate
);

commit;
rollback;

-- 배송지 변경
update orderTB set
name = '지민짱', phone = '010-9999-8888', addr_no = '74010', addr1 = '1', addr2 = '2', addr3 = '3', request_term = '빠른배송'
where order_no = '6';

-- 주문 취소요청
update orderTB set status = '취소완료' where order_product_no = 6;

-- 구매확정 처리
update orderTB set status = '구매확정' where order_no between 1 and 6;

-- 탈퇴회원 주문변경
update orderTB set member_no = '0' where member_no = '9';

-- 주문내역 삭제
delete from orderTB where order_no in (15);
