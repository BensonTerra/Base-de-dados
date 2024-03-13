use company;

select user(),curdate(),curtime();

drop trigger if exists t1;
delimiter $$
create trigger t1 after update on employee
for each row
begin
	insert into logs values (user(),curdate(),curtime(),old.employee_id,'update');
end $$
delimiter ;


drop trigger if exists t2;
delimiter $$
create trigger t2 after insert on employee
for each row
begin
	insert into logs values (user(),curdate(),curtime(),new.employee_id,'insert');
end $$
delimiter ;


select employee_id,employee_name from employee;

select * from logs;