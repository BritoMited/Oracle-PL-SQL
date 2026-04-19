-- função dos joins

SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    d.department_name
FROM
         employees e
    JOIN departments d ON e.department_id = d.department_id;
    
-- NATURAL JOIN

SELECT
    department_id,
    department_name,
    location_id,
    city
FROM
         departments
    NATURAL JOIN locations;

----USING

SELECT
    e.employee_id,
    e.last_name,
    department_id,
    d.department_name
FROM
         employees e
    JOIN departments d USING ( department_id );
    
    
-------MULTIPLAS TABELAS

SELECT
    e.employee_id,
    j.job_title,
    d.department_name,
    l.city,
    l.state_province,
    l.country_id
FROM
         employees e
    JOIN jobs        j ON e.job_id = j.job_id
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations   l ON d.location_id = l.location_id
ORDER BY
    e.employee_id;
  
  --- COM CLAUSULA WHERE  

SELECT
    e.employee_id,
    e.last_name,
    e.salary,
    e.department_id,
    d.department_name
FROM
         employees e
    JOIN departments d ON e.department_id = d.department_id
WHERE
    e.salary BETWEEN 10000 AND 15000;

--- AND

SELECT
    e.employee_id,
    e.last_name,
    e.salary,
    e.department_id,
    d.department_name
FROM
         employees e
    JOIN departments d ON e.department_id = d.department_id
                          AND e.salary BETWEEN 10000 AND 15000;

-- SELF JOIN

SELECT
    empregado.employee_id "Id empregado",
    empregado.last_name   "Sobrenome empregado",
    gerente.employee_id   "Id gerente",
    gerente.last_name     "Sobrenome gerente"
FROM
         employees empregado
    JOIN employees gerente ON empregado.manager_id = gerente.employee_id
ORDER BY
    empregado.employee_id;

SELECT
    e.employee_id,
    e.salary,
    j.grade_level,
    j.lowest_sal,
    j.highest_sal
FROM
         employees e
    JOIN job_grades j ON nvl(e.salary, 0) BETWEEN j.lowest_sal AND j.highest_sal -- CONDIÇÃO DE LIGAÇÃO!!!!!!!
ORDER BY
    e.salary;

SELECT
    e.employee_id,
    e.salary,
    j.grade_level,
    j.lowest_sal,
    j.highest_sal
FROM
         employees e
    JOIN job_grades j ON nvl(e.salary, 0) >= j.lowest_sal
                         AND nvl(e.salary, 0) <= j.highest_sal
ORDER BY
    e.salary;


-- outer join <- estudar melhor a logica disso, nao sei se peguei direto

SELECT
    e.first_name,
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON ( e.department_id = d.department_id )
ORDER BY
    d.department_id;



-- sintaxe oracle


SELECT
    e.employee_id,
    j.job_title,
    d.department_name,
    l.city,
    l.state_province,
    l.country_id
FROM
    employees   e,
    jobs        j,
    departments d,
    locations   l
WHERE
        e.job_id = j.job_id
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND e.salary >= 1000 -- adição de condição
ORDER BY
    e.employee_id;
    
-- nonequijoin na sintaxe oracle

SELECT
    e.employee_id,
    e.salary,
    j.grade_level,
    j.lowest_sal,
    j.highest_sal
FROM
    employees e,
    job_grades j
WHERE
    nvl(e.salary, 0) BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY
    e.salary;
    
    
-- outer join, utiliza um (+) na coluna que possivelmente nao tem valor

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e,
     departments d
WHERE e.department_id(+) = d.department_id -- um departamento que nao tenha funcionario
ORDER BY d.department_id;

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e,
     departments d
WHERE e.department_id = d.department_id(+) -- um funcionario que nao tenha departamento
ORDER BY d.department_id;

-- self join

-- quer pegar as informações do empregado e do gerente, porem como o gerente tambem é um empregado, ele usa self join nesse caso

select empregado.employee_id "Id empregado", empregado.last_name "Sobrenome empregado",
    gerente.employee_id "Id gerente", gerente.last_name "Sobrenome gerente"
FROM employees empregado,
    employees gerente
WHERE (empregado.manager_id = gerente.employee_id)
ORDER BY empregado.last_name;


-- exemplo de selfjoin com outer pq nesse caso pode ter um empregado sem gerencia, que é o proprio chefe

select empregado.employee_id "Id empregado", empregado.first_name "Nome empregado", empregado.last_name "Sobrenome empregado",
    gerente.employee_id "Id gerente", gerente.first_name "Nome gerente", gerente.last_name "Sobrenome gerente"
FROM employees empregado,
    employees gerente
WHERE (empregado.manager_id = gerente.employee_id(+))
ORDER BY empregado.last_name;



    
    
    
    
    
    
    
    
    
    
    