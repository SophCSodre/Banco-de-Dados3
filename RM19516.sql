DROP DATABASE IF EXISTS RM19516;

CREATE DATABASE IF NOT EXISTS RM19516;

USE RM19516;

CREATE TABLE Clientes (
  IDCliente INT NOT NULL PRIMARY KEY,
  NomeCliente VARCHAR(50) NOT NULL,
  CPFCliente VARCHAR(14) NOT NULL,
  EstadoCliente CHAR(2) NOT NULL
);

CREATE TABLE Pedidos (
    CodigoPedido INT NOT NULL PRIMARY KEY,
    DataPedido DATE NOT NULL DEFAULT CURRENT_DATE(),
    IDCliente INT NOT NULL,
    FOREIGN KEY (IDCliente) REFERENCES Clientes (IDCliente)
);

CREATE TABLE Produtos (
    IDProduto INT NOT NULL PRIMARY KEY,
    NomeProduto VARCHAR(100) NOT NULL,
    PrecoUnitario DECIMAL (5,2) NOT NULL
);

CREATE TABLE ItensPedidos (
    CodigoPedido INT NOT NULL,
    IDProduto INT NOT NULL,
    QtdeVendida INT NOT NULL,
    FOREIGN KEY (CodigoPedido) REFERENCES Pedidos (CodigoPedido),
    FOREIGN KEY (IDProduto) REFERENCES Produtos (IDProduto)
);

INSERT INTO Clientes
VALUES
(1, 'Yasmin', '54543456481', 'SP'),
(2, 'Sophia', '98462458741', 'SP'),
(3, 'Walssimon', '21367954832', 'RJ'),
(4, 'Wersington', '32495164231', 'MG'),
(5, 'Juliana', '74125896312', 'ES');

ALTER TABLE Clientes
ADD CHECK (EstadoCliente = 'SP' 
OR EstadoCliente = 'MG' 
OR EstadoCliente = 'ES' 
OR EstadoCliente = 'RJ');

INSERT INTO Produtos
VALUES
(1, 'Mouse RedDragon', '10.00'),
(2, 'Teclado Logitech', '50.00'),
(3, 'Monitor Samsung', '150.00'),
(4, 'Mouse Logitech', '50.00'),
(5, 'Teclado RedDragon', '40.00');

INSERT INTO Pedidos
VALUES
(1, DEFAULT, 1),
(2, DEFAULT, 1),
(3, DEFAULT, 2),
(4, DEFAULT, 2),
(5, DEFAULT, 3),
(6, DEFAULT, 3);

INSERT INTO ItensPedidos
VALUES
    (1, 2, 1),
    (1, 1, 1),
    (2, 3, 1),
    (3, 4, 1),
    (3, 5, 1),
    (4, 1, 1),
    (4, 3, 1),

SELECT P.CodigoPedido, P.DataPedido, c.NomeCliente FROM Clientes as C 
JOIN Pedidos as P ON P.IDCliente = C.IDCliente;

SELECT P.CodigoPedido, P.DataPedido, c.NomeCliente FROM Clientes as C 
JOIN Pedidos as P ON P.IDCliente = C.IDCliente;