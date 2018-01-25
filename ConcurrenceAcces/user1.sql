--1.1.1
select * from employe;

select * from employe;

select * from employe;
--
--1.1.2
select * from employe;

select * from employe;

select * from employe;
--
--1.2.1
set transaction read only;
select * from employe;

select * from employe;

select * from employe;

select * from employe;

select * from employe;
commit;
select * from employe;
--
--2.1.1
insert into employe values(99, 'steve', 20, 1);

Commit; 

--
--2.1.2
delete from employe where nuempl=99;

Commit;

select * from employe where nuempl=99;
--
--2.1.3
update travail set duree=5 where nuempl=23 and nuproj=135;

update travail set duree= 5 where nuempl=39 and nuproj=135;
rollback;

--
--2.1.4
delete from employe where nuempl=17; 

select * from employe where nuempl=17; 

commit;
select * from employe where nuempl=17;
select * from travail where nuempl=17;
--
--2.1.5
alter table travail add constraint trav_empl foreign key (nuempl) references employe;
delete from travail where nuempl=17;
alter table travail add constraint trav_empl foreign key (nuempl) references employe;
insert into employe values (17, 'sophie', 35, 2);
commit;
delete from employe where nuempl=17;

commit;