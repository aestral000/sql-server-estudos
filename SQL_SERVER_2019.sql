-- criação da base de dados

CREATE DATABASE loja;

USE loja;

--criação das tabelas com as devidas alterações
CREATE TABLE dados_produtos(
	id_produto INT PRIMARY KEY IDENTITY(1,1),
	nome_produto VARCHAR(50) NOT NULL,
	valor_produto DECIMAL(6,2) NOT NULL
);


CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY IDENTITY(1,1),
	nome_cliente VARCHAR(50) NOT NULL,
	data_nascimento DATE,
	sexo CHAR(1) NOT NULL,
	endereco VARCHAR(200),
	cidade VARCHAR(50),
	estado CHAR(2),
	telefone_1 VARCHAR(15),
	telefone_2 VARCHAR(15)
);

CREATE TABLE dados_vendas(
	id_venda INT PRIMARY KEY IDENTITY(1,1),
	id_produto INT NOT NULL,
	valor_produto DECIMAL(6,2) NOT NULL,
);

ALTER TABLE dados_vendas
ADD CONSTRAINT fk_produto_venda
FOREIGN KEY (id_produto)
REFERENCES dados_produtos (id_produto);

-- seleção de dados de acordo com a base de dados
SELECT
	dp.id_produto, dp.nome_produto, dp.valor_produto 
FROM
	dados_produtos dp;
--
SELECT 
	dados_vendas.id_venda, dados_produtos.nome_produto, dados_vendas.valor_produto 
FROM 
	dados_produtos 
JOIN
	dados_vendas
	ON
	dados_vendas.id_produto = dados_produtos.id_produto;

-- dropar tabela
DELETE FROM dados_vendas;
DROP TABLE dados_vendas;

-- alteração na table [dados_vendas] e criação da table [produto_venda]

CREATE TABLE dados_vendas(
	id_venda INT PRIMARY KEY IDENTITY(1,1),
	id_cliente INT NOT NULL FOREIGN KEY REFERENCES clientes (id_cliente),
	data_venda DATETIME NOT NULL
);

CREATE TABLE produto_venda(
	id_produto_venda INT PRIMARY KEY IDENTITY(1,1),
	id_venda INT FOREIGN KEY REFERENCES dados_vendas (id_venda) NOT NULL,
	id_produto INT FOREIGN KEY REFERENCES dados_produtos (id_produto) NOT NULL,
	quantidade_produto INT NOT NULL
);

-- inserção de dados na base de dados

INSERT INTO dados_produtos VALUES ('Suco de Laranja', 4.50);
INSERT INTO dados_produtos VALUES ('Suco de Manga', 6.00);
INSERT INTO dados_produtos (valor_produto, nome_produto) VALUES (4.70, 'Suco de Maracujá');


INSERT INTO clientes VALUES ('Jailson', '1988-12-01', 'M', 'Rua da consolação, 788', 'São Carlos', 'SP', '1640028922', '1699887766');


INSERT INTO dados_vendas VALUES (1, GETDATE());


INSERT INTO produto_venda VALUES (1, 1, 3);


-- testar inserção
SELECT * FROM clientes;
SELECT * FROM dados_vendas;
SELECT * FROM dados_produtos;
SELECT * FROM produto_venda;


-- soma dos valores dos produtos

SELECT dados_produtos.id_produto ,dados_produtos.nome_produto, dados_produtos.valor_produto, (produto_venda.quantidade_produto * dados_produtos.valor_produto) as total FROM dados_produtos
INNER JOIN produto_venda
ON produto_venda.id_produto = dados_produtos.id_produto


