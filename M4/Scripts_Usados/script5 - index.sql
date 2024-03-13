use company;

create index idx_salary on employee(salary asc, employee_name asc);

drop index idx_salary on employee;