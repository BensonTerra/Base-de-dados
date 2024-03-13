use company;

CREATE USER 'jlima'@'localhost' IDENTIFIED BY 'JLima123';
grant all on company.* to 'jlima'@'localhost';


select * from employee where employee_name like "Maria%";
START TRANSACTION;
update employee set salary=salary*1.1
where employee_name like "Maria%";
Commit;

rollback;