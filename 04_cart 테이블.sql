-- 04.장바구니 테이블

create table cart (
cart_no  number not null,
member_no  number not null, -- 비회원 경우도 생각해야함 Member No
product_no number not null,
volume_order    number not null,
add_sale    number not null,
regi_date   date default sysdate,
primary key(cart_no),
foreign key(member_no) references member(no),
foreign key(product_no) references product(no)
);

create sequence seq_cart start with 1 increment by 1 nomaxvalue nocache;

-- 장바구니 추가
insert into cart(cart_no, member_no, product_no, volume_order, add_sale, regi_date) values(
(select nvl(max(cart_no),0)+1 from cart), -- 장바구니 번호
'2', -- 회원번호
'7', -- 상품번호
'1', -- 주문량
'0', -- 추가 할인
sysdate
);
commit;
rollback;

-- 장바구니 max(cart_no) 호출
select nvl(max(cart_no), 0) maxCartNo from cart;

-- 장바구니 수량 조회
select count(*) cnt_cartOfMember from cart where member_no = '2';

-- 장바구니 목록 조회
select * from cart;

-- 장바구니 목록보기
select cart_no, product_no, volume_order, add_sale, name, maker, selling_price, sale_percent, info_thumbImg 
from cart c inner join product p
on c.product_no = p.no
where member_no = '2' and cart_no in (20005,20004) order by c.regi_date desc;

-- 장바구니 목록삭제
delete from cart where cart_no in ('20005');
rollback;

-- 수업내용
select c.cartNo, c.volume_order,
    m.name member_name, m.no member_no,
    p.name product_name, p.no product_no, p.price product_price
from cart c, member m, product p
where c.id = m.id and c.product_code = p.no;

-- 장바구니 목록수정
update cart set volume_order = '1'
where cart_no='20005';

delete from cart where member_no = '9';
rollback;
