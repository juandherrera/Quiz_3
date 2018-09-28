--QUIZ TEMA 2

--1. Cree un tablespace con el nombre 'quiz_manana' y tres archivos de datos. Cada archivo de datos de 30Mb.
CREATE TABLESPACE quiz_manana 
DATAFILE 'tbs01.dbf' SIZE 30MB,
     'tbs02.dbf' SIZE 30MB,
     'tbs03.dbf' SIZE 30MB;
    

-- 2. Cree un perfil con tiempo de inactividad de 15 minutos, el nombre del perfil debe ser 'estudiante_quiz'            
 CREATE PROFILE estudiante_quiz LIMIT 
  IDLE_TIME 15;
 
--3. Cree un usuario llamado "carlos_2" con la contraseña "carlos_2". 
	-- El usuario debería poder conectarse
	-- El usuario debe tener el perfil "estudiante_quiz"
	-- El usuario debe estar asociado al tablespace "quiz_manana"
	-- El usuario debería poder crear tablas SIN USAR EL ROL DBA.              
  CREATE USER carlos_2
    IDENTIFIED BY carlos_2
    DEFAULT TABLESPACE quiz_manana
    QUOTA UNLIMITED ON quiz_manana;
    GRANT CREATE SESSION TO carlos_2;
    GRANT CREATE TABLE TO carlos_2;
    
    ALTER USER carlos_2 PROFILE estudiante_quiz;

--4. Cree un usuario llamado "usuario2" con la contraseña "usuario2"
	-- El usuario debería poder conectarse
	-- El usuario debe tener el perfil "estudiante_quiz"
	-- El usuario debe estar asociado al tablespace "quiz_manana"
	-- El usuario no debería poder crear tablas.    
    
    CREATE USER usuario_2
    IDENTIFIED BY usuario_2
    DEFAULT TABLESPACE quiz_manana;
    GRANT CREATE SESSION TO usuario_2;
    
    ALTER USER usuario_2 PROFILE estudiante_quiz;
    
-- PARTE II

--1. Con carlos_2 crea la siguiente tabla (NO CAMBIE EL NOMBRE DE LA MESA NI LAS COLUMNAS:    
    
    
    CREATE TABLE icfes (
	tipo_documento varchar2 (255),
	nacionalidad varchar2 (255),
	genero varchar2 (255),
    fecha_nacimiento DATE ,
	período varchar2 (255),
	consecutivo varchar2 (255),
	departamento_residencia varchar2 (255),
	codigo_departamento_residencia entero,
	municipio_residencia varchar2 (255),
	codigo_municipio_residencia varchar2 (255),
	estrato varchar2 (255),
	educacion_padre varchar2 (255),
	educacion_madre varchar2 (255),
	tiene_internet varchar2 (255),
	tiene_tv varchar2 (255),
	tiene_lavadora varchar2 (255),
	tiene_horno_micro_o_gas varchar2 (255),
	tiene_automovil varchar2 (255),
	tiene_motocicleta varchar2 (255),
	tiene_consola_videojuegos varchar2 (255),
	colegio_codigo_icfes varchar2 (255),
	colegio_codigo_dane varchar2 (255),
	colegio_nombre varchar2 (255),
	puntaje_lectura_critica INTEGER,
	puntaje_matematicas INTEGER,
	puntaje_ciencias_naturales INTEGER,
	puntaje_sociales INTEGER,
	puntaje_estero INTEGER,
	desempeno_ingles varchar2 (255),
	puntaje_global INTEGER
);

--2. Importe esta información: https://www.datos.gov.co/api/views/w42r-j8f9/rows.csv?accessType=DOWNLOAD
--3. Dar permiso para ver la tabla "icfes" del usuario2 (selecciona)

GRANT SELECT ON icfes TO usuario_2

--PARTE III

--Consultas: 

--1. MOSTRAR EL GÉNERO, FECHA DE NACIMIENTO, SECUENCIA (CONSECUTIVO), MUNICIPIO, PUNTUACIÓN GLOBAL (PUNTAJE GLOBAL) DEL ESTUDIANTE MÁS ANTIGUO
--2. MOSTRAR EL GÉNERO, FECHA DE NACIMIENTO, SECUENCIA (CONSECUTIVO), MUNICIPIO, PUNTUACIÓN GLOBAL (PUNTAJE GLOBAL) DE LOS ESTUDIANTES QUE TIENEN UN B1 EN DESEMPEÑO DE INGLÉS
--3. CUENTE EL NÚMERO COLEGIO_NOMBRE SIN REPETICIÓN (VALORES ÚNICOS) DE LOS ESTUDIANTES
--4. CUENTA EL NÚMERO DE ESTUDIANTES QUE ESTÁN UBICADOS EN PASTO

--1
SELECT genero, fecha_nacimiento,consecutivo,municipio,puntaje_global
FROM icfes
WHERE consecutivo = MIN(consecutivo);

--2
SELECT genero,fecha_nacimiento,consecutivo,municipio,puntaje_global
FROM icfes
WHERE desempeño_ingles like 'B1%';

--3
SELECT COUNT(distinct colegio_nombre)
FROM icfes;

--4
SELECT COUNT (*)
FROM icfes
WHERE municipio_residencia like 'Pasto%' ;

    