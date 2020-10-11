DROP TABLE IF EXISTS usuario_tiene_rol;
DROP TABLE IF EXISTS rol_tiene_permiso;
DROP TABLE IF EXISTS solicitudes_aprobacion;
DROP TABLE IF EXISTS registros;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS permisos;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS menus;
DROP TABLE IF EXISTS aplicaciones;

CREATE TABLE aplicaciones
(
	id_aplicacion SERIAL PRIMARY KEY,
	nombre_aplicacion VARCHAR(255),
	estado CHAR NOT NULL
);

CREATE TABLE menus
(
	id_menu SERIAL PRIMARY KEY,
	id_aplicacion INT NOT NULL,
	estado CHAR NOT NULL,
	nombre_menu VARCHAR(255),
	FOREIGN KEY (id_aplicacion) REFERENCES aplicaciones(id_aplicacion)
);

CREATE TABLE roles
(
	id_rol SERIAL PRIMARY KEY,
	estado CHAR NOT NULL,
	nombre_rol VARCHAR(255) NOT NULL
);

CREATE TABLE permisos
(
	id_permiso SERIAL PRIMARY KEY,
	nombre_permiso VARCHAR(255) NOT NULL,
	id_menu INT NOT NULL,
	estado CHAR NOT NULL,
	FOREIGN KEY (id_menu) REFERENCES menus(id_menu)
);

CREATE TABLE personas
(
	documento INT,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	direccion VARCHAR(255),
	telefono INT,
	correo VARCHAR(255),
	estado CHAR NOT NULL,
	PRIMARY KEY (documento)
);

CREATE TABLE usuarios
(
	id_usuario SERIAL PRIMARY KEY,
	usuario VARCHAR(255) NOT NULL,
	contraseña VARCHAR(255) NOT NULL,
	documento INT NOT NULL,
	estado CHAR NOT NULL,
	FOREIGN KEY (documento) REFERENCES personas(documento)
);

CREATE TABLE registros
(
	id_registro SERIAL PRIMARY KEY,
	fecha_creacion TIMESTAMP,
	id_usuario INT NOT NULL,
	estado CHAR NOT NULL,
	tipo VARCHAR(255) NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	descripcion VARCHAR (255)
);

CREATE TABLE usuario_tiene_rol
(
	id_usuario INT,
	id_rol INT,
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
	PRIMARY KEY (id_usuario, id_rol)
);

CREATE TABLE rol_tiene_permiso
(
	id_rol INT,
	id_permiso INT,
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
	FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso),
	PRIMARY KEY (id_rol, id_permiso)
);

CREATE TABLE solicitudes_aprobacion
(
	id_solicitud_aprobacion SERIAL,
	id_registro INT,
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	FOREIGN KEY (id_registro) REFERENCES registros(id_registro),
	fecha_aprobacion TIMESTAMP,
	estado CHAR NOT NULL,
	PRIMARY KEY(id_registro, id_solicitud_aprobacion)
);

-- Inserts para testear

INSERT INTO aplicaciones
	(nombre_aplicacion, estado)
VALUES
	('Aplicación - App 1', 'A'),
	('Aplicación - App 2', 'A'),
	('Aplicación - App 3', 'A'),
	('Aplicación - App 4', 'A');

INSERT INTO menus
	(id_aplicacion, nombre_menu, estado)
VALUES
	(1, 'App 1 - Menú Principal', 'A'),
	(1, 'App 1 - Menú de Gestión de Usuarios', 'A'),
	(2, 'App 2 - Menú Contable', 'A'),
	(3, 'App 3 - Menú de Operaciones', 'A');
	
INSERT INTO roles
	(nombre_rol, estado)
VALUES
	('Administrador', 'A'),
	('Mesa de Ayuda', 'A'),
	('Contador', 'A'),
	('Supervisor Operaciones', 'A'),
	('Operador', 'A');

INSERT INTO permisos
	(nombre_permiso, id_menu, estado)
VALUES
	('Configuración del Sistema', 1, 'A'),
	('Alta Usuarios', 2, 'A'),
	('Baja Usuarios', 2, 'A'),
	('Modificar Usuarios', 2, 'A'),
	('Desbloquear Usuario', 2, 'A'), 
	('Bloquear Usuario', 2, 'A'),
	('Asiento Contable', 3, 'A'),
	('Operar', 4, 'A');

INSERT INTO personas
	(documento, nombre, apellido, direccion, telefono, correo, estado)
VALUES
	(11111111, 'Pepito', 'Muchos Usuarios', 'Falso 111', 08001111, 'pepito@correo.com', 'A'),
	(22222222, 'Pepita', 'Mesera de Ayuda', 'Falso 222', 08002222, 'pepita@correo.com', 'A'),
	(33333333, 'Robertito', 'El Contador', 'Falso 333', 08003333, 'robertito@correo.com', 'A'),
	(44444444, 'Robertita', 'Supervisora de Operaciones', 'Falso 444', 08004444, 'robertita@correo.com', 'A'),
	(55555555, 'Mafalda', 'Muchos Roles', 'Falso 555', 08005555, 'mafalda@correo.com', 'A'),
	(66666666, 'Un', 'Inutil', 'Falso 000', 08000000, 'uninutil@correo.com', 'A'),
	(77777777, 'Una', 'Inutil', 'Falso 000', 08000001, 'unainutil@correo.com', 'A');

INSERT INTO usuarios
	(usuario, contraseña, documento, estado)
VALUES
	('pepitoAdmin', '1234', 11111111, 'A'),
	('pepitoMesa', '1234', 11111111, 'A'),
	('pepitoConta', '1234', 11111111, 'A'),
	('pepitoSuper', '1234', 11111111, 'A'),
	('pepitoOper', '1234', 11111111, 'A'),
	('pepita', '1234', 22222222, 'A'),
	('robertito', '1234', 33333333, 'A'),
	('robertita', '1234', 44444444, 'A'),
	('mafalda', '1234', 55555555, 'A');

INSERT INTO usuario_tiene_rol
	(id_usuario, id_rol)
VALUES
	(1, 1),
	-- u: pepitoAdmin 	r: Administrador
	(2, 2),
	-- u: pepitoMesa	r: Mesa de Ayuda
	(3, 3),
	-- u: pepitoConta 	r: Contador
	(4, 4),
	-- u: pepitoSuper	r: Supervisor Operaciones
	(5, 5),
	-- u: pepitoOper	r: Operador
	(6, 2),
	-- u: pepita		r: Mesa de Ayuda
	(7, 3),
	-- u: robertito		r: Contador
	(8, 4),
	-- u: robertita		r: Supervisor Operaciones
	(8, 5),
	-- u: robertita		r: Operador
	(9, 1),
	-- u: mafalda		r: Administrador
	(9, 2),
	-- u: mafalda		r: Mesa de Ayuda
	(9, 3),
	-- u: mafalda		r: Contador
	(9, 4),
	-- u: mafalda		r: Supervisor Operaciones
	(9, 5);
-- u: mafalda		r: Operador

INSERT INTO rol_tiene_permiso
	(id_rol, id_permiso)
VALUES
	(1, 1),
	-- r: Administrador				p: Configuración del Sistema
	(1, 2),
	-- r: Administrador				p: Alta Usuarios
	(1, 3),
	-- r: Administrador				p: Baja Usuarios
	(1, 4),
	-- r: Administrador				p: Modificar Usuarios
	(1, 5),
	-- r: Administrador				p: Desbloquear Usuario
	(1, 6),
	-- r: Administrador				p: Bloquear Usuario
	(2, 2),
	-- r: Mesa de Ayuda				p: Alta Usuarios
	(2, 5),
	-- r: Mesa de Ayuda				p: Desbloquear Usuario
	(2, 6),
	-- r: Mesa de Ayuda				p: Bloquear Usuario
	(3, 7),
	-- r: Contador					p: Desbloquear Usuario
	(4, 5),
	-- r: Supervisor Operaciones 			p: Desbloquear Usuario
	(4, 6),
	-- r: Supervisor Operaciones 			p: Bloquear Usuario
	(4, 8),
	-- r: Supervisor Operaciones 			p: Operar
	(5, 8);
	-- r: Operador					p: Operar

