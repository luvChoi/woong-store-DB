-- 06-1.문의유형 테이블

-- 테이블 생성
create table inquiryType (
no      number not null,
inquiry_type  varchar2(50) not null,
primary key(no)
);

-- 시퀀스 생성
create sequence seq_inquiryType start with 1 increment by 1 nomaxvalue nocache;

-- 데이터 삽입
insert into inquiryType (no, inquiry_type) values ('1', '상품');
insert into inquiryType (no, inquiry_type) values ('2', '배송');
insert into inquiryType (no, inquiry_type) values ('3', '반품');
insert into inquiryType (no, inquiry_type) values ('4', '교환');
insert into inquiryType (no, inquiry_type) values ('5', '환불');
insert into inquiryType (no, inquiry_type) values ('6', '기타');

-- 테이블 검색
select * from inquiryType order by no;
commit;