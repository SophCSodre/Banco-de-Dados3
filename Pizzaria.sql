DROP DATABASE IF EXISTS Pizzaria;

CREATE DATABASE IF NOT EXISTS Pizzaria;

USE Pizzaria;

CREATE TABLE Clientes(
    CodCliente INT NOT NULL PRIMARY KEY,
    NomeCliente VARCHAR(50) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    CEP VARCHAR(9) NOT NULL,
    Compl VARCHAR(100) NOT NULL,
    Bairro VARCHAR(30) NOT NULL,
    Telefone VARCHAR(14) NOT NULL
);

CREATE TABLE Pizzas(
    CodPizza INT NOT NULL PRIMARY KEY,
    NomePizza VARCHAR(50) NOT NULL,
    Ingredientes VARCHAR(150) NOT NULL,
    Tamanho VARCHAR(7) NOT NULL,
    PrecoPizza DECIMAL(5,2) NOT NULL
);

CREATE TABLE Bebidas (
    CodBebida INT NOT NULL PRIMARY KEY,
    NomeBebida VARCHAR(30) NOT NULL,
    Peso INT NOT NULL,
    PrecoBebida DECIMAL(5,2) NOT NULL
);

CREATE TABLE Pedidos (
    CodPedido INT NOT NULL PRIMARY KEY,
    DataPedido TIMESTAMP NOT NULL,
    CodCliente INT NOT NULL,
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (CodCliente) REFERENCES Clientes (CodCliente)
);

CREATE TABLE PizzasPedidas(
    CodPedido INT NOT NULL,
    CodPizza INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY(CodPedido, CodPizza),
    CONSTRAINT FK_PizzasPedidas_Pedidos FOREIGN KEY (CodPedido) REFERENCES Pedidos (CodPedido),
    CONSTRAINT FK_PizzasPedidas_Pizzas FOREIGN KEY (CodPizza) REFERENCES Pizzas (CodPizza)
);

CREATE TABLE BebidasPedidas(
    CodPedido INT NOT NULL,
    CodBebida INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY(CodPedido, CodBebida),
    CONSTRAINT FK_BebidasPedidas_Pedidos FOREIGN KEY (CodPedido) REFERENCES Pedidos (CodPedido),
    CONSTRAINT FK_BebidasPedidas_Bebidas FOREIGN KEY (CodBebida) REFERENCES Bebidas (CodBebida)
);

INSERT INTO Clientes
VALUES (1, 'Yasmin Marques Tito', 'Bahia', '04849522', 'B', 'Cantinho do Céu', '59333362');
(2, 'Sophia Cruz Sodre', 'Pierre de Beranger', '04676051', '141', 'Campo Grande', '977149197'),
(3, 'Walssimon dos Santos Silva Sacramento', 'Alameda Santo Amaro', '04647001', '11', 'Santo Amaro', '971485417'),
(4, 'Wersington dos Santos Silva Sacramento', 'Angelo José Ribeiro', '04779841', '4', 'Parelheiros', '59797906'),
(5, 'Juliana Sabino', 'Boa Vista', '04698713', '134', 'Gaivotas', '55281922');

INSERT INTO Pizzas
VALUES (1, 'Mussarela', 'Queijo e Tomate', 'Grande', '40.00'),
(2, 'Caipira', 'Frango, Catupiry e Milho', 'Grande', '45.00'),
(3, 'Calabresa', 'Calabresa e Cebola', 'Medio', '30.00'),
(4, 'Brocolis', 'Brocolis e Bacon', 'Media', '30.00'),
(5, 'Sensacao', 'Chocoalte e Morango', 'Pequena', '25.00');

INSERT INTO Bebidas
VALUES (1, 'Coca Cola', '1.5', '9.00'),
(2, 'Fanta Laranja', '1.5', '7.00'),
(3, 'Guarana', '2', '8.00');

INSERT INTO Pedidos
VALUES(1, '09/05/2023', 2),
(2, '08/05/2023', 2),
(3, '07/05/2023', 3),
(4, '06/05/2023', 4),
(5, '05/05/2023', 5);

INSERT INTO PizzasPedidas
VALUES (1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 4, 1),
(2, 5, 1),
(3, 3, 1),
(3, 2, 1),
(3, 1, 1),
(4, 4, 1),
(4, 5, 1),
(5, 5, 1),
(5, 1, 1),
(5, 2, 1);

INSERT INTO BebidasPedidas
VALUES (1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(4, 1, 1),
(5, 3, 1);

CREATE TEMPORARY TABLE tmp_subtotalp(
    CodPedido INT NOT NULL,
    NomePizza VARCHAR(50),
    Quantidade INT NOT NULL,
    PrecoPizza DECIMAL(5,2) NOT NULL,
    Subtotal DECIMAL(7,2) NOT NULL
);

INSERT INTO tmp_subtotalp(CodPedido, NomePizza, Quantidade, PrecoPizza, Subtotal)
SELECT CodPedido, CodPizza, Quantidade
FROM tmp_subtotalp
WHERE PrecoPizza