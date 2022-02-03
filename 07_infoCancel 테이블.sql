-- 07.주문취소 사유 테이블

-- 테이블 생성
create table infoCancel (
no                  number not null,
order_product_no    number not null,
cancel_type         number not null,
cancel_reason       varchar2(1000) not null,
cancel_date         date default sysdate not null,
primary key(no),
foreign key(order_product_no) references orderTB(order_product_no),
foreign key(cancel_type) references cancelType(no)
);
commit;

-- 테이블 조회
select i.no, i.order_product_no, c.cancel_type, i.cancel_reason, i.cancel_date
from infoCancel i, cancelType c
where i.cancel_type = c.no;

-- 취소정보 호출
select i.order_product_no, p.name product_name, o.volume_order, o.status, c.cancel_type, i.cancel_reason
from infoCancel i, cancelType c, orderTB o, product p
where (i.order_product_no = o.order_product_no
and i.cancel_type = c.no
and o.product_no = p.no)
and o.order_product_no = '20006';

-- 데이터 입력
insert into infoCancel(no, order_product_no, cancel_type, cancel_reason) values (
(select nvl(max(no), 0) + 1 from infoCancel),
'20006',
'3',
'용량이 큰 제품으로 구매하고 싶어요.'
);

-- 데이터 수정
update infoCancel set order_product_no = '20007' where no = '3';
