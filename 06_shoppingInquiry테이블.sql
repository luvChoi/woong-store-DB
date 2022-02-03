-- 06.문의 테이블

-- 문의테이블 생성
create table inquiry (
no          number not null,            -- 일련번호
order_no    number not null,            -- 주문번호
inq_prodNo  number not null,            -- 문의상품번호
member_no   number not null,            -- 회원번호
type_no     number not null,            -- 문의유형
subject     varchar2(50) not null,      -- 제목
content     varchar2(1000) not null,    -- 내용
ref         number not null,            -- 문의번호
ref_step    number not null,            -- 문의스텝(질문 또는 답변)
regi_date   Date default sysdate,       -- 등록일
primary key(no),
foreign key(inq_prodNo) references orderTB(order_product_no),
foreign key(type_no) references inquiryType(no),
foreign key(member_no) references member(no)
);
commit;
rollback;

-- 시퀀스 생성
create sequence seq_inquiry start with 1 increment by 1 nomaxvalue nocache;

-- 문의테이블
select * from inquiry;

-- 주문번호의 상품수 호출
select o.order_no, o.order_product_no, p.name from orderTB o, product p
where (o.product_no = p.no)
and order_no = '7'
order by o.order_product_no;

-- max(ref) 호출
select nvl(max(ref), 0) max_ref from inquiry;

-- 회원별 문의리스트 총 record 수(질의문답 한세트)
select count(*) totRecord from
(select ref from inquiry where (member_no = '2' and regi_date >= '21/01/01')
group by ref
having count(ref) in ('1','2')
order by ref desc);

-- 회원별 문의 리스트
select i.order_no, i.ref, i.ref_step, i_type.inquiry_type, i.subject, i.content, i.regi_date, p.no, p.name, p.maker, p.info_thumbimg
from inquiry i, orderTB o, inquiryType i_type, product p
where (i.type_no = i_type.no
and i.inq_prodNo = o.order_product_no
and o.product_no = p.no)
and ref in (select ref from (select rownum rnum, a.* from (select ref from inquiry
where member_no = '2'
and regi_date >= '21/01/01'
group by ref
having count(ref) in ('1','2')
order by ref desc) a)
where rnum between 1 and 2)
order by ref desc, ref_step;

-- 페이징 참고
select * from (select rownum rnum, a.* from (select ref from inquiry
where member_no = '2'
and regi_date >= '21/01/01'
group by ref
having count(ref) in ('1','2')
order by ref desc) a)
where rnum between 1 and 2;

-- 그룹화
select ref from inquiry
where regi_date < sysdate
group by ref
having count(ref) in 1;

-- 데이터 삽입
insert into inquiry values (
seq_inquiry.nextval,
'7',
'10',
'2',
'2',
'안장커버 문의',
'금일 바이크 및 안장커버 배송이 완료됐는데 안장커버는 따로 보이지 않는 것 같아 확인해주세요',
'1',
'1',
'22/01/11'
);

-- 데이터 수정
update inquiry set regi_date = '21/06/15' where ref = '1';

-- 데이터 삭제
delete from inquiry where member_no = '9';








