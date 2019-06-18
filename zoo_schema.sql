DROP SCHEMA IF EXISTS zoo;
CREATE SCHEMA zoo;
USE zoo;

CREATE TABLE AREA_TEMATICA ( 
	NOME  VARCHAR(20)  NOT NULL,
	last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (NOME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ALLOGGIO (
	NUMERO INT NOT NULL,
	NOME  VARCHAR(40) NOT NULL,
	TIPO  VARCHAR(40),
	NOME_AREA  VARCHAR(20)  NOT NULL,
	last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (NUMERO),
	FOREIGN KEY (NOME_AREA) REFERENCES AREA_TEMATICA(NOME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ANIMALE (
	ID VARCHAR(10) NOT NULL, 
	NOME VARCHAR(20),
	SPECIE VARCHAR(30) NOT NULL,
	HABITAT enum('Calotta polare','Tundra','Taiga','Foresta decidua','Steppa e prateria','Foresta pluviale temperata','Foresta pluviale tropicale','Macchia mediterranea','Giungla','Deserto sabbioso','Deserto roccioso','Deserto semiarido','Steppa arida','Savana erbosa','Savana alberata','Foresta subtropicale secca','Tundra alpina','Vegetazione alpina') DEFAULT NULL,
	PESO INT UNSIGNED,
	ETA INT UNSIGNED, 	
	SESSO ENUM('M', 'F'),
	last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
CREATE TABLE MALATTIA (
	ID INT NOT NULL,
	ID_ANIMALE VARCHAR(10) NOT NULL,
	TIPO VARCHAR(20) NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (ID),
	FOREIGN KEY (ID_ANIMALE) REFERENCES ANIMALE (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE RISIEDE (
	ID_ANIMALE VARCHAR(10) NOT NULL,
    NUMERO INT NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ID_ANIMALE, NUMERO),
	FOREIGN KEY (ID_ANIMALE) REFERENCES ANIMALE (ID),
    FOREIGN KEY (NUMERO) REFERENCES ALLOGGIO (NUMERO)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE VETERINARIO (
	CF VARCHAR(15) NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	COGNOME VARCHAR(30) NOT NULL,
    TELEFONO VARCHAR(15),
    EMAIL VARCHAR(30),
    INDIRIZZO VARCHAR(50),
	H_INIZIO time,
	H_FINE TIme,
	GIORNO_LIBERO ENUM('Lunedì','Martedì','Mercoledì','Giovedì','Venerdì','Sabato','Domenica'),
	TIPOLOGIA_ANIMALE ENUM('Piccoli','Medi','Grandi'),
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
CREATE TABLE VISITA_VETERINARIA(
	CODICE INT NOT NULL,
	IMPORTANZA ENUM('Bianco','Verde','Giallo','Rosso'),
	DATA DATETIME,
	ID_ANIMALE VARCHAR(10) NOT NULL,
	CF VARCHAR(15) NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(CODICE),
	FOREIGN KEY (ID_ANIMALE) REFERENCES ANIMALE (ID),
	FOREIGN KEY(CF) REFERENCES VETERINARIO (CF)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE SOTTOPOSTO(
	CODICE INT NOT NULL,
	CF VARCHAR(15) NOT NULL,
	ID_ANIMALE VARCHAR(10) NOT NULL, 
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(CODICE, CF, ID_ANIMALE),
	FOREIGN KEY(CODICE) REFERENCES VISITA_VETERINARIA (CODICE),
	FOREIGN KEY(CF) REFERENCES VETERINARIO (CF),
FOREIGN KEY (ID_ANIMALE) REFERENCES ANIMALE (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ADDETTO_PULIZIE(
	CF VARCHAR(15) NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	COGNOME VARCHAR(30) NOT NULL,
	TELEFONO VARCHAR(15),
    EMAIL VARCHAR(30),
	H_INIZIO time,
	H_FINE time,
	GIORNO_LIBERO ENUM('Lunedì','Martedì','Mercoledì','Giovedì','Venerdì','Sabato','Domenica'),
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PULITO(
	CF VARCHAR(15) NOT NULL,
    NUMERO INT NOT NULL,
	DATA DATETIME,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(CF, NUMERO),
	FOREIGN KEY(CF) REFERENCES ADDETTO_PULIZIE (CF),
	FOREIGN KEY (NUMERO) REFERENCES ALLOGGIO (NUMERO)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE MEDICINA(
	ID VARCHAR(20) NOT NULL,
	NOME VARCHAR(30) NOT NULL,
	DATA_SCADENZA DATETIME NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;	

CREATE TABLE SOMMINISTRATA(
	CODICE INT NOT NULL,
	ID VARCHAR(20) NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
PRIMARY KEY(CODICE, ID),
FOREIGN KEY (CODICE) REFERENCES VISITA_VETERINARIA (CODICE),
FOREIGN KEY (ID) REFERENCES MEDICINA (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CIBO(
	ID VARCHAR(20) NOT NULL,
	NOME VARCHAR(30) NOT NULL,
	DATA_SCADENZA DATETIME NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DIETA(
	ID  INT UNSIGNED NOT NULL AUTO_INCREMENT,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE COMPOSTA(
	ID_CIBO VARCHAR(20) NOT NULL,
	ID_DIETA  INT UNSIGNED NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(ID_DIETA, ID_CIBO),
	FOREIGN KEY (ID_DIETA) REFERENCES DIETA(ID),
	FOREIGN KEY (ID_CIBO) REFERENCES CIBO (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE MAGAZZINO(
	NUMERO INT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	CAPACITA INT(10) UNSIGNED,
	NOME_AREA VARCHAR(20)  NOT NULL, 
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(NUMERO),
	FOREIGN KEY (NOME_AREA) REFERENCES AREA_TEMATICA (NOME)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CONSERVA_CIBO(
	ID_CIBO VARCHAR(20) NOT NULL,
	NUMERO_MAGAZZINO INT(3) UNSIGNED NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(ID_CIBO, NUMERO_MAGAZZINO),
	FOREIGN KEY (ID_CIBO) REFERENCES CIBO (ID),
	FOREIGN KEY (NUMERO_MAGAZZINO) REFERENCES MAGAZZINO (NUMERO)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DIETOLOGO(
	CF VARCHAR(15) NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	COGNOME VARCHAR(30) NOT NULL,
	TELEFONO VARCHAR(15),
    EMAIL VARCHAR(30),
	H_INIZIO time,
	H_FINE time,
	GIORNO_LIBERO ENUM('Lunedì','Martedì','Mercoledì','Giovedì','Venerdì','Sabato','Domenica'),
	TIPOLOGIA_DIETA VARCHAR(20),
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PIANIFICA (
	CF VARCHAR(15) NOT NULL,
	ID_DIETA  INT UNSIGNED NOT NULL,
	ID_ANIMALE VARCHAR(10) NOT NULL, 
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF, ID_DIETA, ID_ANIMALE),
	FOREIGN KEY (CF) REFERENCES DIETOLOGO (CF),
	FOREIGN KEY (ID_DIETA) REFERENCES DIETA (ID),
	FOREIGN KEY (ID_ANIMALE) REFERENCES ANIMALE (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE LAVORA_DIETOLOGO (
	CF_D VARCHAR(15) NOT NULL,
	NOME_AREA VARCHAR(20) NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF_D, NOME_AREA),
	FOREIGN KEY (CF_D) REFERENCES DIETOLOGO (CF),
    FOREIGN KEY (NOME_AREA) REFERENCES AREA_TEMATICA (NOME)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE LAVORA_VETERINARIO (
	CF_V VARCHAR(15) NOT NULL,
	NOME_AREA  VARCHAR(20)  NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF_V, NOME_AREA),
	FOREIGN KEY (CF_V) REFERENCES VETERINARIO (CF),
FOREIGN KEY (NOME_AREA) REFERENCES AREA_TEMATICA (NOME)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE LAVORA_ADDETTO_PULIZIE (
	CF_P VARCHAR(15) NOT NULL,
	NOME_AREA  VARCHAR(20)  NOT NULL,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (CF_P, NOME_AREA),
	FOREIGN KEY (CF_P) REFERENCES ADDETTO_PULIZIE (CF),
FOREIGN KEY (NOME_AREA) REFERENCES AREA_TEMATICA (NOME)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE STRUTTURA_VETERINARIA (
	NOME VARCHAR(30) NOT NULL,
	INDIRIZZO VARCHAR(30) NOT NULL,
	TELEFONO VARCHAR(10),
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY(NOME, INDIRIZZO)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ALLOGGIA (
	ID_ANIMALE VARCHAR(10) NOT NULL, 
	NOME_STRUTTURA VARCHAR(30) NOT NULL,
	DATA_I DATETIME,
	DATA_F DATETIME,
last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	PRIMARY KEY (ID_ANIMALE, NOME_STRUTTURA),
FOREIGN KEY (ID_ANIMALE) REFERENCES ANIMALE (ID),
FOREIGN KEY (NOME_STRUTTURA) REFERENCES STRUTTURA_VETERINARIA (NOME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
