DROP TABLE IF EXISTS usuario_tiene_rol;
DROP TABLE IF EXISTS rol_tiene_permiso;
DROP TABLE IF EXISTS solicitudes_aprobacion;
DROP TABLE IF EXISTS registro_usuarios;
DROP TABLE IF EXISTS registro_personas;
DROP TABLE IF EXISTS registro_roles;
DROP TABLE IF EXISTS registro_permisos;
DROP TABLE IF EXISTS registro_modulos;
DROP TABLE IF EXISTS registros;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS permisos;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS modulos;

CREATE TABLE modulos
(
	id_modulo SERIAL PRIMARY KEY,
	nombre_modulo VARCHAR(255)
);

CREATE TABLE roles
(
	id_rol SERIAL PRIMARY KEY,
	nombre_rol VARCHAR(255) NOT NULL
);

CREATE TABLE permisos
(
	id_permiso SERIAL PRIMARY KEY,
	nombre_permiso VARCHAR(255) NOT NULL,
	id_modulo INT NOT NULL,
	FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
);

CREATE TABLE personas
(
	documento INT,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	direccion VARCHAR(255),
	telefono INT,
	correo VARCHAR(255),
	PRIMARY KEY (documento)
);

CREATE TABLE usuarios
(
	id_usuario SERIAL PRIMARY KEY,
	usuario VARCHAR(255) NOT NULL,
	contraseña VARCHAR(255) NOT NULL,
	documento INT NOT NULL,
	FOREIGN KEY (documento) REFERENCES personas(documento)
);

CREATE TABLE registros
(
	id_registro SERIAL PRIMARY KEY,
	fecha_creacion TIMESTAMP,
	id_usuario INT NOT NULL,
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
	estado CHAR,
	PRIMARY KEY(id_registro, id_solicitud_aprobacion)
);

CREATE TABLE registro_usuarios
(
	id_registro INT,
	id_usuario INT,
	FOREIGN KEY (id_registro) REFERENCES registros(id_registro),
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	PRIMARY KEY (id_registro, id_usuario)
);

CREATE TABLE registro_personas
(
	id_registro INT,
	documento_persona INT,
	FOREIGN KEY (id_registro) REFERENCES registros(id_registro),
	FOREIGN KEY (documento_persona) REFERENCES personas(documento),
	PRIMARY KEY (id_registro, documento_persona)
);

CREATE TABLE registro_roles
(
	id_registro INT,
	id_rol INT,
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
	FOREIGN KEY (id_registro) REFERENCES registros(id_registro),
	PRIMARY KEY (id_registro, id_rol)
);

CREATE TABLE registro_permisos
(
	id_registro INT,
	id_permiso INT,
	FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso),
	FOREIGN KEY (id_registro) REFERENCES registros(id_registro),
	PRIMARY KEY (id_registro, id_permiso)
);

CREATE TABLE registro_modulos
(
	id_registro INT,
	id_modulo INT,
	FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo),
	FOREIGN KEY (id_registro) REFERENCES registros(id_registro),
	PRIMARY KEY (id_registro, id_modulo)
);

-- Inserts para testear

INSERT INTO modulos
	(nombre_modulo)
VALUES
	('Administración del Sistema'),
	('Administración de Usuarios'),
	('Administración Contable'),
	('Operaciones');

INSERT INTO roles
	(nombre_rol)
VALUES
	('Administrador'),
	('Mesa de Ayuda'),
	('Contador'),
	('Supervisor Operaciones'),
	('Operador'),
	('Invitado');

INSERT INTO permisos
	(nombre_permiso, id_modulo)
VALUES
	('Configuración del Sistema', 1),
	('Alta Usuarios', 2),
	('Baja Usuarios', 2),
	('Modificar Usuarios', 2),
	('Desbloquear Usuario', 2),
	('Bloquear Usuario', 2),
	('Asiento Contable', 3),
	('Operar', 4);

INSERT INTO personas
	(documento, nombre, apellido, direccion, telefono, correo)
VALUES
	(11111111, 'Pepito', 'Rodriguez', 'Falso 123', 08006666, 'pepito@correo.com'),
	(22222222, 'Pepita', 'Rodriguez', 'Falso 122', 08005555, 'pepita@correo.com');




-- borrar
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
-- borrar
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

--  Update de testing
