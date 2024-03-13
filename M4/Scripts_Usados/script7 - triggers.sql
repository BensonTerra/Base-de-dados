-- Triggers
use company;


drop table if exists logs;
CREATE TABLE `company`.`logs` 
(
  `user` VARCHAR(45) NOT NULL,
  `opdate` DATE NOT NULL,
  `optime` TIME NOT NULL,
  `operation` VARCHAR(45) NULL,
  PRIMARY KEY (`user`, `opdate`, `optime`)
);
  
ALTER TABLE `company`.`logs` 
ADD COLUMN `emp_id` INT NOT NULL AFTER `optime`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`user`, `opdate`, `optime`, `emp_id`);
;
  
select user(), curdate(), curtime();
delete FROM company.logs;
  
  
drop trigger if exists t1
delimiter $$
create trigger t1 after update on employee
for each row
begin
	insert into logs values (user(), curdate(), curtime(), old.employee_id,'update'); --  concat(old.salary,' - ',new.salary));
end$$
delimiter ;

update employee set salary=salary*1.1
where employee_name like "Maria%";

