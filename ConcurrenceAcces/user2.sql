--1.1.1

insert into employe values(99, 'steve', 20, 1);

select * from employe;
commit;

--
--1.1.2

delete from employe where nuempl=99;

select * from employe;
commit;

--
--1.2.1

insert into employe values(99, 'steve', 20, 1);

commit;

delete from employe where nuempl=99;

commit;

--
--2.1.1

update employe set hebdo=0 where nuempl=99;

commit;
select * from employe;
--
--2.1.2

update employe set hebdo=0 where nuempl=99;

Commit;
select * from employe where nuempl=99;
--
--2.1.3

update travail set duree=7 where nuempl=39 and nuproj=135;
update travail set duree=7 where nuempl=23 and nuproj=135;

select * from travail where nuproj=135;
rollback;
--
--2.1.4

insert into travail values (17,135,5); 

select * from employe where nuempl=17;
commit;

select * from employe where nuempl=17;
select * from travail where nuempl=17;
--
--2.1.5

insert into travail values (17,135,5);

rollback;