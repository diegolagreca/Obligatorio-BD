DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS permisos;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS usuario_tiene_rol;
DROP TABLE IF EXISTS rol_tiene_permiso;

-- https://www.postgresql.org/docs/9.2/ddl-constraints.html

CREATE TABLE roles
(
	id_rol SERIAL PRIMARY KEY,
	nombre_rol VARCHAR(255) NOT NULL
);

CREATE TABLE permisos
(
	id_permiso SERIAL PRIMARY KEY,
	nombre_permiso VARCHAR(255) NOT NULL,
	FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
);

CREATE TABLE usuarios
(
	id_usuario SERIAL PRIMARY KEY,
	usuario VARCHAR(255) NOT NULL,
	contraseña VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	documento INT NOT NULL,
	direccion VARCHAR(255),
	telefono INT
);

CREATE TABLE usuario_tiene_rol
(
	id_usuario_tiene_rol SERIAL PRIMARY KEY,
	id_usuario INT,
	id_rol INT,
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

CREATE TABLE rol_tiene_permiso
(
	id_rol_tiene_permiso SERIAL PRIMARY KEY,
	id_rol INT,
	id_permiso INT,
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
	FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso)
);

INSERT INTO roles
	(nombre_rol)
VALUES
	('Administrador'),
	('Mesa de Ayuda'),
	('Financiero'),
	('Supervisor Operaciones'),
	('Operador'),
	('Invitado');

INSERT INTO permisos
	(nombre_permiso)
VALUES
	('Administración del Sistema'),
	('Alta y baja de Usuarios'),
	('Sistema Contable'),
	('Alta y baja de Operadores'),
	('Pantalla Operaciones');

INSERT INTO usuarios
	(usuario, contraseña, nombre, apellido, documento, direccion, telefono)
VALUES
	('jadmin', '111', 'Juan', 'Admin', 11111111, 'Av. Juansito 111', 099555666),
	('shelpdesk', '222', 'Segundo', 'Helpdesk', 22222222, 'Av. Juansito 222', 098555666),
	('tcontador', '333', 'Tercero', 'Contador', 33333333, 'Av. Juansito 333', 097555666),
	('csupervisor', '444', 'Cuarto', 'Supervisor', 44444444, 'Av. Juansito 444', 096555666),
	('qoperador', '555', 'Quinto', 'Operador', 55555555, 'Av. Juansito 555', 095555666),
	('soperador', '666', 'Sexto', 'Operador', 66766666, 'Av. Juansito 666', 099455666),
	('multirol', '777', 'Muchos', 'Roles', 77777777, 'Av. Juansito 777', 099777777),
	('eliminame', '222', 'muerte', 'ufff', 66766666, 'Av. Juansito aaaa', 666);


INSERT INTO rol_tiene_permiso
	(id_rol, id_permiso)
VALUES
	(1, 1),
	(1, 2),
	(2, 2),
	(3, 3),
	(4, 4),
	(4, 5),
	(5, 5);

INSERT INTO usuario_tiene_rol
	(id_usuario, id_rol)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(7, 3),
	(7, 4),
	(7, 5),
	(6, 5);

-- Insert de testing

INSERT INTO usuarios
	(usuario, contraseña, nombre, apellido, documento, direccion, telefono)
VALUES
	('actualizame', 'xxx', 'nombbbb', 'apellll', 123123, 'Av. Juansito 123', 321321);

--  Update de testing

UPDATE usuarios
SET nombre = 'he sido actualizado!' 
WHERE usuario = 'actualizame';


SELECT *
FROM roles;

SELECT *
FROM permisos;

SELECT *
FROM usuarios;

SELECT *
FROM usuario_tiene_rol;

SELECT *
FROM rol_tiene_permiso;

-- Join para obtener Roles del Usuario para configurar la sesión 

SELECT roles.nombre_rol, usuarios.usuario
FROM roles, usuarios, usuario_tiene_rol
WHERE usuario_tiene_rol.id_usuario = usuarios.id_usuario
	AND usuario_tiene_rol.id_rol = roles.id_rol;

-- JOIN para obtener Permisos del Rol para configurar la sesión

SELECT roles.nombre_rol, permisos.nombre_permiso
FROM roles, permisos, rol_tiene_permiso
WHERE rol_tiene_permiso.id_permiso = permisos.id_permiso
	AND rol_tiene_permiso.id_rol = roles.id_rol;

-- Obtengo los roles del Usuario jadmin

SELECT roles.nombre_rol, usuarios.usuario
FROM roles, usuarios, usuario_tiene_rol
WHERE usuario_tiene_rol.id_usuario = usuarios.id_usuario
	AND usuario_tiene_rol.id_rol = roles.id_rol
	AND usuarios.usuario = 'jadmin';

-- Obtengo los permisos del Rol Administrador

SELECT roles.nombre_rol, permisos.nombre_permiso
FROM roles, permisos, rol_tiene_permiso
WHERE rol_tiene_permiso.id_permiso = permisos.id_permiso
	AND rol_tiene_permiso.id_rol = roles.id_rol
	AND roles.nombre_rol = 'Administrador';

-- Obtengo el Usuario con rol Administrador y listo sus Permisos

SELECT roles.nombre_rol, permisos.nombre_permiso, usuarios.usuario
FROM roles, permisos, rol_tiene_permiso, usuarios, usuario_tiene_rol
WHERE rol_tiene_permiso.id_permiso = permisos.id_permiso
	AND rol_tiene_permiso.id_rol = roles.id_rol
	AND roles.nombre_rol = 'Administrador'
	AND usuario_tiene_rol.id_usuario = usuarios.id_usuario
	AND usuario_tiene_rol.id_rol = roles.id_rol;

