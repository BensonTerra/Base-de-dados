select id,name, Age, Salary, Phone, postalCode from employee;
select * from employee;
select name, Age, Salary, postalCode from employee where Salary>150000;
select * from employee order by postalCode desc, Name;
select distinct code, city from postal;
select id, name, postalCode, city from employee, postal 
	where employee.postalCode=postal.Code 
    order by name;
/*
•Nome, salário e idade de todas as pessoas com idades compreendidas entre 30 e 40 anos
•Nome, salário e idade de todas as pessoas com idades não compreendidas entre 30 e 40 anos
•Todos os códigos postais de lisboa e do porto
•Nomes das pessoas sem telephone
•Nomes dos funcionários cujo último nome começa por “W”
•Cidades dos funcionários cujo último nome começa por “W”
•Nome e idade dos funcionários que moram em Tomar ou Coimbra
•Cidades e idade dos funcionários com menos de 30 anos
*/;
select name, salary, age from employee where age between 30 and 40 order by age;
select name, salary, age from employee where age not between 30 and 40 order by age;
select code from postal where (city like "Lisboa" or city like "Porto") order by city;
select name from employee order by name;
select name from employee where name like '% W%';
select distinct name from employee, postal where name like '% W%' and employee.postalCode=postal.code;
select distinct name, age, postalCode from employee, postal where postal.code=postalCode and (postal.city like "Tomar" or postal.city like "Coimbra");
select distinct age, city from employee, postal where employee.postalCode=postal.code and age<30