SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id || ' oii' "ola galera" -- dessa maneira com || eu consigo concatenar valores
FROM                                     -- com '' aspas simples eu coloco a string, e com as simples é a unica forma 
    employees                            -- de lidar com datas ou string, com as aspas duplas, é onde vc determina o nome do campo
WHERE                                    -- podendo ser maiuscula e com espaço, se fosse sem aspas nao daria
    department_id =60;                    
    
    
SELECT    employee_id || ' ' || start_date || ' ' || end_date || ' ' || job_id || ' ' || department_id teste -- e voce pode juntar campos como bem entender
FROM            -- caso esteja com operador de concatenar, e no final o nome do campo amalgamado
    job_history;-- as aspas simples so estao ali para colocar espaço, mas nem precisava
    
    
-- operador like
    
SELECT
    first_name,
    last_name,
    job_id
FROM
    employees
WHERE 
    first_name LIKE 'Sa%'; -- porcent (%) substitui qualquer caracter e uma quantidade indefinida

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees
WHERE 
    first_name LIKE '_a%'; -- underline (_) só substitui um caracter podendo ser qualquer um
                           -- possivel leitura do codigo (um caracter qualquer, 
                                                        --seguido de 'a minusculo'
                                                        --n caracteres quaisquer)
 
SELECT
    employee_id,
    first_name,
    last_name,
    commission_pct
FROM
    employees
WHERE 
    commission_pct = null; -- qualquer comparação com nulo, nao retorna absolutamente nada

SELECT
    employee_id,
    first_name,
    last_name,
    commission_pct
FROM
    employees
WHERE 
    commission_pct is null; -- porem se utilizado desse operador 'IS NULL', ele funciona
    

-- AND - retorna TRUE se ambas as condições forem verdadeiras

SELECT
    employee_id,
    job_id,
    salary
FROM
    employees 
WHERE
    salary >= 5000
AND 
    job_id = 'IT_PROG';
    
-- OR  - retorna TRUE se pelo menos uma das condições for verdadeira

SELECT
    employee_id,
    job_id,
    salary
FROM
    employees
WHERE
    salary >= 5000
    OR job_id = 'IT_PROG';
    
-- NOT - retorna a negação da condição, se TRUE vira false, se FALSE vira TRUE, e se NULL permanece NULL

SELECT
    employee_id,
    job_id,
    salary
FROM
    employees
WHERE
    job_id NOT IN ( 'IT_PROG', 'FI_ACCOUNT', 'SA_REP' );-- o operador IN faz vc comparar com uma outra lista
                                                       -- imagino que possa ser com uma subconsulta tambem
                                                       
-- REGRAS DE PRECEDENCIA
-- (DA ESQUERDA PARA A DIREITA)

--1. Operador aritmético
--2. Operador de concatenação 
--3. Condições de comparação (ex: job_id = 'SA_REP')
--4. IS [NOT] NULL, LIKE, [NOT] IN
--5. [NOT] BETWEEN
--6. NOT EQUAL TO
--7. NOT condição logica
--8. AND condição logica
--9. OR condição logica

SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    job_id = 'SA_REP'
    OR job_id = 'IT_PROG'
    AND salary > 10000;

-- aqui, ele iria resolver na seguinte sequencia:

--Condições de comparação:
-- job_id = 'SA_REP'
-- job_id = 'IT_PROG'
-- salary > 10000;

--AND condição logica
-- job_id = 'IT_PROG' AND salary > 10000;

--OR condição logica
--  OR (job_id = 'IT_PROG' AND salary > 10000;)

-- a leitura fica basicamente o seguinte:
-- OPERADOR DE COMPARAÇÃO: pega todos os 'SA_REP'
-- AND(precisa de dois valores para comparar): depois verifca todos IT_PROG que tiverem o salario maior que 10000
-- OR: dai mostra todos os SA_REP, ou o IT_PROG que tiver o salario maior que 10000 


-- POREM PARA SOBREPOR AS REGRAS DE PRECEDENCIA, UTILIZE PARENTESES!!!!!

SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    (job_id = 'SA_REP'
    OR job_id = 'IT_PROG')
    AND salary > 10000;
    
-- Nesse caso, ele vai pegar ou o SA_REP ou o IT_PROG, que tiverem o salario maior que 10000
-- e não, todos os SA_REP, e só os IT_PROG que tiverem o salario mais que 10000
-- forma alternativa "WHERE job_id IN ('SA_REP', 'IT_PROG') AND salary > 10000;"


-- ORDER BY

SELECT
    last_name,
    job_id,
    hire_date
FROM
    employees
ORDER BY
    hire_date desc; -- o ASC(ascendente/crescente) vc pode omitir, é por padrão, mas o DESC(descrecente) precisa por

-- consigo referenciar o alias no order by ou a propria expressão "ORDER BY salary*12"

SELECT
    last_name,
    job_id,
    salary*12 salario_anual
FROM
    employees
ORDER BY
    salario_anual; 

-- tambem é possivel ordenar pela posição da coluna, porem é paia

SELECT
    last_name,
    job_id,
    salary*12 salario_anual
FROM
    employees
ORDER BY 3; 


-- consigo ordenar por mais de uma coluna


SELECT
    last_name,
    department_id,
    salary
FROM
    employees
ORDER BY department_id, salary desc; -- primeiro é por departamento, depois dentro de cada faixa de departamento
                                     -- ele vai ordenar o salario


-- VARIAVEIS DE SUBSTITUIÇÃO =======================================

-- com um & antes do campo, ele me pede um valor

SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE 
    department_id = &department_id;                                    

-- com dois & antes do campo, ele me pede um valor apenas na primeira execução, depois ele meio que salva o valor

SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE 
    department_id = &&department_id;       
    
-- variavel de substituição com campo character ou date 
    
SELECT
    last_name,
    department_id,
    job_id,
    salary
FROM
    employees
WHERE 
    job_id = '&job_id'; 
    
    
-- comando DEFINE, definição de variavel =================================

DEFINE employee_id = 101; -- define o valor (deve ser executado para pegar o valor, SE EXECUTAR A LINHA ELE PEGA OS COMENTARIOS KKKK)

SELECT
    employee_id,
    last_name,
    department_id,
    job_id,
    salary
FROM
    employees
WHERE 
    employee_id = &employee_id; 
    
DEFINE employee_id; -- mostra o valor 

UNDEFINE employee_id; -- remove o valor da veriavel


-- FUNÇÕES SINGLE ROW ======================================================

-- atuam sobre cada linha da tabela

-- CONVERSAO DE MINUSCULO E MAIUSCULO

SELECT LOWER('TESTE')
FROM DUAL;

SELECT UPPER('TESTE')
FROM DUAL;
    
SELECT INITCAP('TESTE')
FROM DUAL;    

SELECT employee_id, last_name, department_id
FROM employees
WHERE UPPER(last_name) = 'KING'; -- obs, a busca é case sensitive

-- MANIPULAÇÃO DE CARACTERES

SELECT CONCAT('Curso: ', 'Introdução ORACLE 19C')
FROM DUAL;

SELECT SUBSTR('Introdução ORACLE 19C', 1,11 ) -- arg(string, inicio, fim)
FROM DUAL;

SELECT LENGTH('Introdução ORACLE 19C')
FROM DUAL;

SELECT INSTR('Introdução ORACLE 19C', 'ORACLE')
FROM DUAL;

SELECT LPAD('Introdução ORACLE 19C', 30, '*') -- args(string, qtd de caracteres que precisam ser preenchidos no total, caracter para completar)
FROM DUAL;

SELECT RPAD('Introdução ORACLE 19C', 30, '*')
FROM DUAL;

SELECT REPLACE('Introdução ORACLE 12C', '12C', '19C')
FROM DUAL;

SELECT TRIM(' ' FROM '              Introdução ORACLE 12C               ') -- remove o respectivo caracter da string (TRIM, de ambos os lados)
FROM DUAL;

SELECT RTRIM('Introdução ORACLE 12C      *', '*') -- remove o respectivo caracter da string (RTRIM, da direita)
FROM DUAL;

SELECT LTRIM('          Introdução ORACLE 12C', ' ') -- remove o respectivo caracter da string (LTRIM, da esquerda)
FROM DUAL;


-- FUNÇÕES DO TIPO NUMBER

SELECT ROUND(45.923,2), ROUND(45.923,0) -- arredonda para o valor mais proximo
FROM DUAL;

SELECT TRUNC(45.923,2), TRUNC(45.923,0) -- não arredonda
FROM DUAL;

SELECT MOD(1300,600) RESTO --resto de divisão
FROM DUAL;

SELECT ABS(-9), SQRT(9) -- valor absoluto e raiz quadrada
FROM DUAL;

-- FUNÇÕES DO TIPO DATE

SELECT sysdate
FROM DUAL; 

-- data - numero = data ou data + numero = data
SELECT sysdate, sysdate + 30, sysdate +60, sysdate -30
FROM dual;

-- data - data = numero 
SELECT last_name, ROUND((SYSDATE - hire_date)/7, 2) "SEMANAS DE TRABALHO"
FROM employees;

-- calcula qtd de meses entre datas

SELECT first_name, last_name, ROUND(MONTHS_BETWEEN(sysdate, hire_date), 2) "MESES DE TRABALHO"
FROM employees;

-- adiciona meses relativo a data inserida | pega o proximo dia inserido | pega o ultimo dia do mes

SELECT sysdate, ADD_MONTHS(SYSDATE, 3), NEXT_DAY(SYSDATE, 'DOMINGO'), LAST_DAY(SYSDATE)
FROM dual;
    
-- ROUND(SYSDATE,'MONTH') arredonda a data para cima ou baixo dependendo se for metade do mes ou nao
-- e é a mesma coisa para as outras coisas
-- o TRUNCH(SYSDATE,'MONTH') faz a mesma coisa

-- TRUNC(SYSDATE)  CASO SEJA NECESSARIO COMPARAR DUAS DATAS QUE ESTEJA NO COMPLETO 00 HORAS MM E SS

SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), ROUND(SYSDATE, 'YEAR'),
        TRUNC(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'YEAR')
FROM DUAL;

-- O TRUNC VAI ZERAR, E O ROUND TAMBEM, POREM O ROUND VAI LEVAR PARA O PROXIMO DIA CASO JA ESTEJA NA METADE DO DIA
SELECT SYSDATE, TO_CHAR(TRUNC(SYSDATE), 'DD/MM/YYYY HH24:MI:SS'),  TO_CHAR(ROUND(SYSDATE), 'DD/MM/YYYY HH24:MI:SS')
FROM DUAL;   


-- FUNÇÕES DE CONVERSÃO ======================================================


-- NUMBER <-> CHARACTER (TO_NUMBER, TO_CHAR)
-- CHARACTER <-> DATE (TO_DATE, TO_CHAR)

SELECT 
    TO_CHAR(SYSDATE, 'FMDAY FMMONTH YYYY') AS "ESCRITO", 
    TO_CHAR(SYSDATE, 'DD-MON-YYYY') AS "ABREVIADO", 
    TO_CHAR(SYSDATE, 'DD/MM/YY') AS "NORMAL",
    TO_CHAR(SYSDATE, 'DY') AS "DIA DA SEMANA",
    TO_CHAR(SYSDATE, 'D') AS "DIA DA SEMANA (1-7)",
    TO_CHAR(SYSDATE, 'CC') AS "SÉCULO",
    TO_CHAR(SYSDATE, 'AD') AS "ERA (AD/BC)",
    TO_CHAR(SYSDATE, 'HH12') AS "HORA (1-12)",
    TO_CHAR(SYSDATE, 'HH24') AS "HORA (0-23)",
    TO_CHAR(SYSDATE, 'MI') AS "MINUTO",
    TO_CHAR(SYSDATE, 'SS') AS "SEGUNDO"
FROM DUAL;


-- formatacao de numero

SELECT first_name, last_name, TO_CHAR(salary, 'L99G999G999D99') SALARIO
FROM employees;

SELECT TO_NUMBER('10020,50')
FROM DUAL;

SELECT TO_DATE('06/02/2025','DD/MM/YYYY') DATA
FROM DUAL;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = TO_DATE('17/06/2003', 'DD/MM/YYYY');


-- funcoes aninhadas 
SELECT first_name, last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date), 0) NUMERO_MESES
FROM employees
WHERE hire_date = TO_DATE('17/06/2003', 'DD/MM/YYYY');


-- funcao NVL função generica, parece que de substituicao

SELECT last_name, salary, NVL(commission_pct, 0), salary*12 SALARIO_ANUAL,
       (salary*12) + (salary*12*NVL(commission_pct, 0)) REMUNERACAO_ANUAL
FROM employees;

-- COALESCE retorna a primeira coisa que for diferente de nulo

SELECT COALESCE(NULL, NULL, 'Expressão 3'), COALESCE(NULL, 'Expressão 2', 'Expressão 3'), COALESCE('Expressão 1', 'Expressão 2', 'Expressão3')
FROM dual;

SELECT
    last_name,
    employee_id,
    commission_pct,
    manager_id,
    coalesce(to_char(commission_pct),to_char(manager_id),
    'Sem percentual de comissão e sem gerente')
FROM
    employees;  


-- NVL2 (coluna, se diferente de nulo, se nulo)

SELECT last_name, salary, commission_pct, NVL2(commission_pct, 10, 0) PERCENTUAL_ALTERADO
FROM employees;

-- NULLIF(arg1, arg2) = se igual, retorna nulo, se diferente retorna o primeiro campo)

SELECT NULLIF(1000,1000), NULLIF(1000,2000)
FROM DUAL;

-- estrutura condicional 
-- COM CASE

SELECT
    last_name,
    job_id,
    salary,
    CASE job_id
        WHEN 'IT_PROG'  THEN
            1.10 * salary
        WHEN 'ST_CLERK' THEN
            1.15 * salary
        WHEN 'SA_REP'   THEN
            1.20 * salary
        ELSE
            salary
    END "NOVO SALARIO"
FROM
    employees;

-- COM DECODE

SELECT
    last_name,
    job_id,
    salary,
    decode(job_id, 'IT_PROG',  1.10 * salary, 
                   'ST_CLERK', 1.15 * salary,
                   'SA_REP',   1.20 * salary, 
                                      salary) "NOVO SALARIO"
FROM 
    employees;
    
    
-- AGRUPANDO DADOS ===================================

-- funções de grupo ignoram valores NULOS!!!!!!!!!!
--avg e sum
SELECT AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES;

-- min e max
SELECT MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES;

SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
FROM EMPLOYEES;

-- count
SELECT COUNT(*) -- isso aqui conta todas as linhas, ignorando valores, inclusive nulls
FROM EMPLOYEES;

SELECT COUNT(commission_pct) ,COUNT(*)
FROM EMPLOYEES;

SELECT COUNT(NVL(commission_pct,0 )) ,COUNT(*)
FROM EMPLOYEES;

SELECT COUNT(DISTINCT department_id), COUNT(DEPARTMENT_ID)
FROM EMPLOYEES;

SELECT AVG(NVL(COMMISSION_PCT, 0)) "Média correta", AVG(COMMISSION_PCT) "Média errada pq tava ignorando os valores nulos"
FROM EMPLOYEES;


-- SEQUENCIA LOGICA

-- 1.0 FROM
-- 1.1 WHERE - SELECIONA LINHAS A SEREM RECUPERADAS (OU SEJA CASO NAO TENHA WHERE, ELE ESTA PEGANDO TODAS AS LINHAS)
-- 2. GROUP BY - FORMA GRUPOS
-- 3. HAVING - SELECIONA GRUPOS A SEREM RECUPERADOS
-- 4. EXIBE COLUNAS OU EXPRESSOES DO SELECT ORDENANDO POR ORDER BY

-- cometi um erro nessa expressao pq tentei usar alias no group by sendo que ele processa antes do SELECT
SELECT NVL(department_id, 0) oi, AVG(salary)
FROM employees
GROUP BY oi;

-- maneira correta
SELECT NVL(department_id, 0), AVG(salary)
FROM employees
GROUP BY NVL(department_id, 0);

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- todas as colunas do select caso nao estejam em uma funcao de grupo, devem estar no group by


SELECT department_id, job_id, AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

-- se nao da erro

SELECT department_id, job_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, AVG(salary)
FROM employees;


-- NÃO PODE UTILIZAR WHERE PARA RESTRINGIR GRUPOS PQ QUANDO O WHERE FOR EXECUTADO
-- SE FOR OLHAR A SEQUENCIA, OS GRUPOS NEM FORAM FORMADOS AINDA
-- SENDO NECESSARIO USAR HAVING
 
--EXEMPLO (ERRADO)

SELECT department_id, MAX(SALARY)
FROM EMPLOYEES
WHERE MAX(SALARY) > 10000
GROUP BY DEPARTMENT_ID;

--EXEMPLO (CERTO)

SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 10000;

SELECT JOB_ID, SUM(SALARY) TOTAL
FROM EMPLOYEES
WHERE JOB_ID <> 'SA_REP'
GROUP BY JOB_ID
HAVING SUM(SALARY) > 10000;


-- SEQUENCIA LOGICA

-- 1. FROM - RECUPERA A TABELA
-- 2. WHERE - SELECIONA LINHAS A SEREM RECUPERADAS
-- 3. GROUP BY - FORMA GRUPOS
-- 4. HAVING - SELECIONA GRUPOS A SEREM RECUPERADOS
-- 5. EXIBE COLUNAS OU EXPRESSOES DO SELECT ORDENANDO PELO CRITERIO DO ORDER BY

-- ANINHANDO FUNCAO DE GRUPO

SELECT MAX(AVG(SALARY))
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
