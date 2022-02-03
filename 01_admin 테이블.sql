-- 01.admin 테이블

-- 테이블 생성
create table admin (
no    number not null,
id    varchar2(30) not null,
passwd      varchar2(30) not null,
name        varchar2(30) not null,
dep_name    varchar2(30) not null,
level_staff varchar2(30) not null,
phone       varchar2(30) not null,
authority   varchar2(30) default '일반' not null,
regi_date   date default sysdate not null,
upd_date    date default sysdate not null,
primary key(id),
unique(no)
);

drop table admin;

-- 관리자 로그인 정보 호출
select admin.*, trunc(sysdate - upd_date) passChg_period from admin
where id='luvchoi' and passwd='1111';


-- 관리자 등록
insert into admin
(no, id, passwd, name, dep_name, level_staff, phone, authority, regi_date, upd_date)
values (
(select nvl(max(no), 0)+1 from admin),
'luvchoi', 
'1111',
'최성웅',
'개발팀',
'사원',
'010-7435-3233',
'일반',
sysdate,
sysdate
);

select * from admin;
commit;

-- 관리자 수정
update admin set authority='운영자' where no = '1';








