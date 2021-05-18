-- criação da base de dados

CREATE DATABASE dbaLoja;

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

-- inserção de dados na base de dados

INSERT INTO dados_produtos VALUES ('Suco de Laranja', 4.50);
INSERT INTO dados_produtos VALUES ('Suco de Manga', 6.00);
INSERT INTO dados_produtos (valor_produto, nome_produto) VALUES (4.70, 'Suco de Maracujá');

INSERT INTO dados_vendas VALUES(2,(SELECT valor_produto FROM dados_produtos WHERE id_produto = 2));

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







