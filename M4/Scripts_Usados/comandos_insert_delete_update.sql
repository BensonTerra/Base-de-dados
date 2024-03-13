select * from employee where employee_name like "Maria%";

SET SQL_SAFE_UPDATES = 0;

start transaction;
update employee set salary=salary*1.1 
where employee_name like "Maria%";
commit;

