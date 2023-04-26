DROP DATABASE IF EXISTS Editora;

CREATE DATABASE IF NOT EXISTS Editora;

USE Editora;

CREATE TABLE Livrarias
(
   IDLivraria int not null,
   NomeLivraria varchar(50) not null,
   Endereco varchar(100) not null,
   Telefone varchar(13) not null,
   PRIMARY KEY (IDLivraria)
);

CREATE TABLE Livros
(
   IDLivro int not null,
   TituloLivro varchar(150) not null,
   Autor varchar(150) not null,
   PrecoUnitario decimal(5,2) not null,
   PRIMARY KEY(IDLivro)
);

CREATE TABLE NotasFiscais
(
   IDVenda int not null,
   DataVenda date not null,
   IDLivraria int not null,
   PRIMARY KEY (IDVenda),
   FOREIGN KEY (IDLivraria)
      REFERENCES Livrarias(IDLivraria)
);

CREATE TABLE ItensNF
(
   IDVenda int not null,
   IDLivro int not null,
   QtdeVendida tinyint not null,
   PRIMARY KEY(IDVenda, IDLivro),
   FOREIGN KEY (IDVenda)
      REFERENCES NotasFiscais(IDVenda),
   FOREIGN KEY (IDLivro)
      REFERENCES Livros(IDLivro)
);

INSERT INTO Livrarias
VALUES (1,'Livraria Francesa','Rua Barao de Itapetininga, 275','11 3231-4555'),
(2,'Livraria da Vila','Rua Fradique Coutinho, 915','11 3814-5811'),
(3,'Devir Livraria Ltda','Rua Teodureto Souto, 624','11 2127-8787'),
(4,'Livraria Cultura','Avenida Paulista, 2073','11 3170-4033'),
(5,'Moonshadows Livraria','Rua Treze de Maio, 966','11 3266-3916');

INSERT INTO Livros
VALUES (1,'WINDOWS VISTA','SURANI, ROGERIO MASSARO','35.00'),
(2,'ORGANIZACAO DE SISTEMAS','FERNANDES, LEILA MARIA PINHEIRO','34.00'),
(3,'LOGICA DE PROGRAMACAO','XAVIER, GLEY FABIANO CARDOSO','87.00'),
(4,'LINKANIA:UMA TEORIA DE REDES','DIMANTAS, HERMANI','299.00'),
(5,'INTERNET:NAVEGANDO MELHOR NA WEB','FILHO, OZEAS VIEIRA SANTANA','40.00'),
(6,'INCLUSAO DIGITAL:UMA VISAO CRITICA','CAZELOTO, EDILSON','47.00'),
(7,'GUIA INTERNET DE CONECTIVIDADE','CYCLADES BRASIL','47.00'),
(8,'ESTRATEGIAS PARA A MIDIA DIGITAL 2.0','CORREA, ELIZABETH SAAD','87.00'),
(9,'COREL DRAW X4','ANDRADE, MARIA ANGEL SERAFIM DE','74.00'),
(10,'COMUNIDADES VIRTUAIS','FILHO, JAYME TEXEIRA','32.00');

INSERT INTO NotasFiscais
VALUES (1,'2021-08-09',4),
(2,'2021-08-09',5),
(3,'2021-08-10',2),
(4,'2021-08-15',1);

INSERT INTO ItensNF
VALUES (1,3,5),
(1,9,10),
(1,1,20),
(2,10,2),
(3,8,15),
(3,2,15),
(4,5,10),
(4,7,5),
(4,6,10),
(4,2,5);

ALTER TABLE ItensNF ADD COLUMN Desconto TINYINT NULL;

UPDATE ItensNF SET Desconto = 10 WHERE IDVenda = 1;

UPDATE ItensNF SET Desconto = 50 WHERE IDVenda = 4;

SELECT IDVenda, Livros.IDLivro, PrecoUnitario, QtdeVendida, Desconto,
PrecoUnitario*QtdeVendida - (PrecoUnitario*QtdeVendida* IFNULL(Desconto/100, 0)) AS Subtotal
FROM Livros INNER JOIN ItensNF ON Livros.IDLivro = ItensNF.IDLivro
ORDER BY IDVenda;

CREATE TEMPORARY TABLE tmp_Livros
SELECT * FROM Livros;

SELECT * FROM tmp_Livros;

CREATE TEMPORARY TABLE tmp_livrarias(
    ID INT (11) NOT NULL PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    CONTATO VARCHAR(13) NOT NULL);

DESC tmp_livrarias;

INSERT INTO tmp_livrarias
VALUES (1,'Livraria Francesa','11 3231-4555'),
(2,'Livraria da Vila','11 3814-5811'),
(3,'Devir Livraria Ltda','11 2127-8787'),
(4,'Livraria Cultura','11 3170-4033'),
(5,'Moonshadows Livraria','11 3266-3916');

CREATE TEMPORARY TABLE tmp_calculos(
    IDVenda INT (11) NOT NULL,
    Titulo VARCHAR(150) NOT NULL,
    Qntde TINYINT(4) NOT NULL,
    Preco DECIMAL(5,2) NOT NULL,
    Desconto DECIMAL(5,2) NOT NULL,
    Subtotal DECIMAL(7,2) NOT NULL
);

