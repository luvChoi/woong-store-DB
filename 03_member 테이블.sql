-- 03.회원관리 테이블

-- 테이블 생성
create table member (
no      number not null,
id      varchar2(50) not null,
passwd  varchar2(50) not null,
name    varchar2(50) not null,
birth   date not null,
gender  char(6) check (gender in('남자', '여자')) not null,
email   varchar2(100) not null,
phone   varchar2(50) not null,
addr_no    number not null,
addr1    varchar2(100) not null,
addr2    varchar2(100) not null,
addr3    varchar2(100),
regi_date      date default sysdate not null,
pwdUpd_date    date default sysdate not null,
unique(no),
unique(phone),
primary key(id)
);
commit;

-- sequence 생성
create sequence seq_member start with 1 increment by 1 nomaxvalue nocache;

-- 회원목록
select * from member order by no desc;

-- 회원등록
insert into member
(no, id, passwd, name, birth, gender, email, phone, addr_no, addr1, addr2, addr3, regi_date, pwdUpd_date)
values(
seq_member.nextval,
'nonMember', '00798', '비회원', '2000/01/01', '남자', 'nonmember@store.com', '000-0000-0000',
'00000', '-', '-', '-', '21/11/01', '21/11/01'
);

-- 회원정보 수정
update member set 
name='한지민', birth='1982-11-05', gender='여자', email='han1234@naver.com', phone='010-1111-2222',
addr_no='6035', addr1='서울 강남구 가로수길 5', addr2='예쁜집', addr3='-'
where no='2';

-- 로그인
select no, name, trunc(sysdate - pwdUpd_date) passChg_period,
(select count(member_no) from cart where member_no = (select no from member where id='han' and passwd = '1234')) cart_cnt
from member where id='han' and passwd='1234';

-- 아이디 찾기
select * from member
where name = '한지민' and birth = '1982-11-05' and phone = '010-1111-2222';

-- 비밀번호 찾기
select count(*) checkNo from member
where id='han' and phone='010-1111-2222';

-- 비밀번호 재설정
update member set passwd = '1111'
where id = 'han';

-- 비밀번호 변경
update member set passwd = '1234'
where no = '9' and passwd = '1111';

-- 회원탈퇴
delete from member where no = '9';

