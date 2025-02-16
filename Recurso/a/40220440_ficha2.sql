select * from employee e join postal p on e.postalCode=p.code;
select * from employee e left join postal p on e.postalCode=p.code;
select * from employee e right join postal p on e.postalCode=p.code;
select * from departament;
select * from employee_postalcode.employee;

/*
	1) selecting the postal codes not referred by any employee
	2) employees with non-existing postal codes
*/
select * from employee;

SELECT * FROM employee e LEFT JOIN postal p ON e.postalCode = p.code WHERE p.code IS NULL;