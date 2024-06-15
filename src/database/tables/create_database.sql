use <database_name>;

-- permite quitar las tablas si existen
DROP TABLE CUENTA_TIENE_EQUIPADO_MANOS;
DROP TABLE CUENTA_TIENE_EQUIPADO_COLLAR;
DROP TABLE CUENTA_TIENE_EQUIPADO_ZAPATOS;
DROP TABLE CUENTA_TIENE_EQUIPADO_TORSO;
DROP TABLE CUENTA_TIENE_EQUIPADO_MASCARA;
DROP TABLE CUENTA_TIENE_EQUIPADO_LENTES;
DROP TABLE CUENTA_TIENE_EQUIPADO_CASCO;
DROP TABLE CUENTA_TIENE_LOGROS;
DROP TABLE CUENTA_TIENE_EQUIPO;
DROP TABLE CUENTA_PUEDE_ACCEDER_A;
DROP TABLE COMERCIO_PERMITE_OBTENER;
DROP TABLE COMERCIO_PERMITE_VENDER;
DROP TABLE RECETA_NECESITA_MATERIAL;
DROP TABLE RECETA_PERMITE_FABRICAR;
DROP TABLE PERSONA_JUEGA_EN;
DROP TABLE EDIFICIO;
DROP TABLE MAPA;
DROP TABLE LOGROS;
DROP TABLE CONSOLA;
DROP TABLE CUENTA;
DROP TABLE EQUIPO;
DROP TABLE MATERIALES;
DROP TABLE COMERCIO;
DROP TABLE RECETAS;
DROP TABLE AREA;
DROP TABLE PERSONA;

-- Crear las tablas

CREATE TABLE PERSONA (
	Correo VARCHAR(255),
		CONSTRAINT PK_PERSONA PRIMARY KEY (Correo),
	Nombre VARCHAR(255)
);

CREATE TABLE CUENTA (
	NombreUsuario VARCHAR(255),
		CONSTRAINT PK_CUENTA PRIMARY KEY (NombreUsuario),
	Correo VARCHAR(255),
		CONSTRAINT FK_CUENTA FOREIGN KEY (Correo) REFERENCES PERSONA(Correo),
	Contrasena VARCHAR(255),
	Ataque FLOAT, 
	Defensa FLOAT
);

CREATE TABLE CONSOLA (
	NOMBRE VARCHAR(255),
		CONSTRAINT PK_CONSOLA PRIMARY KEY (Nombre),
	Compania VARCHAR(255),
	AnnoSalida DATE
);

CREATE TABLE LOGROS (
	idLogro UNIQUEIDENTIFIER  PRIMARY KEY,
	NombreConsola VARCHAR(255),
		CONSTRAINT FK_LOGROS FOREIGN KEY (NombreConsola) REFERENCES CONSOLA(NOMBRE),
	NombreLogro VARCHAR(255),
	Descricion VARCHAR(255)--,
	--Imagen VARBINARY(MAX)
);

-- EQUIPO se usara para guardar los equipos que se pueden usar en el juego
-- por ejemplo, solo existe una entidad oro, pero se pueden tener varios equipos oro, mediante la tabla CUENTA_TIENE_EQUIPO
CREATE TABLE EQUIPO (
	NombreEquipo VARCHAR(255) PRIMARY KEY,
	Lugar VARCHAR(255),
	Color VARCHAR(255),
	Ataque FLOAT,
	Defensa FLOAT,
	--EsEquipado BIT, -- esEquipado se usaba para saber si el equipo estaba equipado o no, no se va a usar en las implementaciones de la parte 2 y 3 porque usara una mejor implementacion
	Descricion VARCHAR(255)--,
	--Imagen VARBINARY(MAX)
);

CREATE TABLE RECETAS (
	NombreReceta VARCHAR(255) PRIMARY KEY
);

CREATE TABLE COMERCIO (
	NombreComercio VARCHAR(255) PRIMARY KEY
);

CREATE TABLE MATERIALES (
	NombreMaterial VARCHAR(255) PRIMARY KEY,
	-- add tipo ?
	--Textura VARBINARY(MAX),
	Descricion VARCHAR(255)
);

CREATE TABLE AREA (
	NombreArea VARCHAR(255),
		CONSTRAINT PK_AREA PRIMARY KEY (NombreArea)
);

CREATE TABLE MAPA (
	NombreArea VARCHAR(255) PRIMARY KEY,
		CONSTRAINT FK_MAPA FOREIGN KEY (NombreArea) REFERENCES AREA(NombreArea)
);

CREATE TABLE EDIFICIO (
	NombreEdificio VARCHAR(255) PRIMARY KEY,
	NombreArea VARCHAR(255),
		CONSTRAINT FK_EDIFICIO FOREIGN KEY (NombreArea) REFERENCES AREA(NombreArea),
	--Imagen VARBINARY(MAX),
	Descricion VARCHAR(255),
	Interactuable BIT
);

CREATE TABLE PERSONA_JUEGA_EN (
    Correo VARCHAR(255),
    	CONSTRAINT FK_PERSONA_JUEGA_EN_Correo FOREIGN KEY (Correo) REFERENCES PERSONA(Correo),
    Consola VARCHAR(255),
    	CONSTRAINT FK_PERSONA_JUEGA_EN_Consola FOREIGN KEY (Consola) REFERENCES CONSOLA(NOMBRE)
);

CREATE TABLE RECETA_PERMITE_FABRICAR (
    NombreReceta VARCHAR(255),
    	CONSTRAINT FK_RECETA_PERMITE_FABRICAR_Receta FOREIGN KEY (NombreReceta) REFERENCES RECETAS(NombreReceta),
    NombreEquipo VARCHAR(255),
    	CONSTRAINT FK_RECETA_PERMITE_FABRICAR_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo)
);

CREATE TABLE RECETA_NECESITA_MATERIAL (
    NombreReceta VARCHAR(255),
    	CONSTRAINT FK_RECETA_NECESITA_MATERIAL_Receta FOREIGN KEY (NombreReceta) REFERENCES RECETAS(NombreReceta),
    NombreMaterial VARCHAR(255),
    	CONSTRAINT FK_RECETA_NECESITA_MATERIAL_Material FOREIGN KEY (NombreMaterial) REFERENCES MATERIALES(NombreMaterial),
    Cantidad INT
);

CREATE TABLE COMERCIO_PERMITE_VENDER (
    NombreComercio VARCHAR(255),
		CONSTRAINT FK_COMERCIO_PERMITE_VENDER_Comercio FOREIGN KEY (NombreComercio) REFERENCES COMERCIO(NombreComercio),
    NombreEquipo VARCHAR(255),
		CONSTRAINT FK_COMERCIO_PERMITE_VENDER_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo)
);

CREATE TABLE COMERCIO_PERMITE_OBTENER (
    NombreComercio VARCHAR(255),
		CONSTRAINT FK_COMERCIO_PERMITE_OBTENER_Comercio FOREIGN KEY (NombreComercio) REFERENCES COMERCIO(NombreComercio),
    NombreMaterial VARCHAR(255),
		CONSTRAINT FK_COMERCIO_PERMITE_OBTENER_Material FOREIGN KEY (NombreMaterial) REFERENCES MATERIALES(NombreMaterial),
    Cantidad INT
);

CREATE TABLE CUENTA_PUEDE_ACCEDER_A (
    NombreUsuario VARCHAR(255),
		CONSTRAINT FK_CUENTA_PUEDE_ACCEDER_A_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreArea VARCHAR(255),
		CONSTRAINT FK_CUENTA_PUEDE_ACCEDER_A_Area FOREIGN KEY (NombreArea) REFERENCES AREA(NombreArea)
);

CREATE TABLE CUENTA_TIENE_EQUIPO (
	NombreUsuario VARCHAR(255),
		CONSTRAINT FK_CUENTA_TIENE_EQUIPO_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
	NombreEquipo VARCHAR(255),
		CONSTRAINT FK_CUENTA_TIENE_EQUIPO_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
	Cantidad INT
);

CREATE TABLE CUENTA_TIENE_LOGROS (
	Correo VARCHAR(255),
		CONSTRAINT FK_CUENTA_TIENE_LOGROS_Correo FOREIGN KEY (Correo) REFERENCES PERSONA(Correo),
	idLogro UNIQUEIDENTIFIER,
		CONSTRAINT FK_CUENTA_TIENE_LOGROS_Logro FOREIGN KEY (idLogro) REFERENCES LOGROS(idLogro)
);


-- Recreate the tables with UNIQUE constraints on NombreUsuario
CREATE TABLE CUENTA_TIENE_EQUIPADO_CASCO (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_CASCO_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_CASCO_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_CASCO UNIQUE (NombreUsuario)
);

CREATE TABLE CUENTA_TIENE_EQUIPADO_LENTES (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_LENTES_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_LENTES_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_LENTES UNIQUE (NombreUsuario)
);

CREATE TABLE CUENTA_TIENE_EQUIPADO_MASCARA (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_MASCARA_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_MASCARA_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_MASCARA UNIQUE (NombreUsuario)
);

CREATE TABLE CUENTA_TIENE_EQUIPADO_TORSO (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_TORSO_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_TORSO_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_TORSO UNIQUE (NombreUsuario)
);

CREATE TABLE CUENTA_TIENE_EQUIPADO_ZAPATOS (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_ZAPATOS_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_ZAPATOS_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_ZAPATOS UNIQUE (NombreUsuario)
);

CREATE TABLE CUENTA_TIENE_EQUIPADO_COLLAR (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_COLLAR_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_COLLAR_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_COLLAR UNIQUE (NombreUsuario)
);

CREATE TABLE CUENTA_TIENE_EQUIPADO_MANOS (
    NombreUsuario VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_MANOS_Usuario FOREIGN KEY (NombreUsuario) REFERENCES CUENTA(NombreUsuario),
    NombreEquipo VARCHAR(255),
    CONSTRAINT FK_CUENTA_TIENE_EQUIPADO_MANOS_Equipo FOREIGN KEY (NombreEquipo) REFERENCES EQUIPO(NombreEquipo),
    CONSTRAINT UQ_CUENTA_TIENE_EQUIPADO_MANOS UNIQUE (NombreUsuario)
);