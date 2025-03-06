CREATE TABLE IF NOT EXISTS `Produto` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(255) NOT NULL,
	`valor` decimal(10,2) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Cliente` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`cpf_cnpj` varchar(14) NOT NULL UNIQUE,
	`id_endereco` int NOT NULL,
	`nome` varchar(255) NOT NULL,
	`telefone` varchar(9) NOT NULL,
	`email` varchar(255) NOT NULL,
	`forma_pagamento` int NOT NULL,
	`tipo_cliente` enum NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Pedido` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_cliente` int NOT NULL,
	`status` enum NOT NULL,
	`entrega` enum NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Endereco` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`logradouro` varchar(255) NOT NULL,
	`bairro` varchar(255) NOT NULL,
	`cidade` varchar(255) NOT NULL,
	`pais` varchar(255) NOT NULL,
	`cep` varchar(8) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Fornecedor` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`razao_social` varchar(255) NOT NULL,
	`cpf_cnpj` varchar(14) NOT NULL UNIQUE,
	`email` varchar(255) NOT NULL,
	`telefone` varchar(9) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Fornecimento` (
	`id_produto` int NOT NULL,
	`id_fornecedor` int NOT NULL
);

CREATE TABLE IF NOT EXISTS `Estoque` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_endereco` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Em_estoque` (
	`id_estoque` int NOT NULL,
	`id_produto` int NOT NULL,
	`quantidade` int NOT NULL
);

CREATE TABLE IF NOT EXISTS `Descricao_pedido` (
	`id_pedido` int NOT NULL,
	`id_produto` int NOT NULL,
	`quantidade` int NOT NULL
);

CREATE TABLE IF NOT EXISTS `Terceiro` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`razao_social` varchar(255) NOT NULL,
	`id_endereco` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Pedido_Terceiro` (
	`id_terceiro` int NOT NULL,
	`id_produto` int NOT NULL,
	`quantidade` int NOT NULL
);

ALTER TABLE `Produto` ADD CONSTRAINT `Produto_fk0` FOREIGN KEY (`id`) REFERENCES `Pedido`(`id_produto`);
ALTER TABLE `Cliente` ADD CONSTRAINT `Cliente_fk0` FOREIGN KEY (`id`) REFERENCES `Pedido`(`id_cliente`);

ALTER TABLE `Cliente` ADD CONSTRAINT `Cliente_fk2` FOREIGN KEY (`id_endereco`) REFERENCES `Endereco`(`id`);


ALTER TABLE `Fornecedor` ADD CONSTRAINT `Fornecedor_fk0` FOREIGN KEY (`id`) REFERENCES `Produto`(`id_fornecedor`);
ALTER TABLE `Fornecimento` ADD CONSTRAINT `Fornecimento_fk0` FOREIGN KEY (`id_produto`) REFERENCES `Produto`(`id`);

ALTER TABLE `Fornecimento` ADD CONSTRAINT `Fornecimento_fk1` FOREIGN KEY (`id_fornecedor`) REFERENCES `Fornecedor`(`id`);
ALTER TABLE `Estoque` ADD CONSTRAINT `Estoque_fk1` FOREIGN KEY (`id_endereco`) REFERENCES `Endereco`(`id`);
ALTER TABLE `Em_estoque` ADD CONSTRAINT `Em_estoque_fk0` FOREIGN KEY (`id_estoque`) REFERENCES `Estoque`(`id`);

ALTER TABLE `Em_estoque` ADD CONSTRAINT `Em_estoque_fk1` FOREIGN KEY (`id_produto`) REFERENCES `Produto`(`id`);
ALTER TABLE `Descricao_pedido` ADD CONSTRAINT `Descricao_pedido_fk0` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido`(`id`);

ALTER TABLE `Descricao_pedido` ADD CONSTRAINT `Descricao_pedido_fk1` FOREIGN KEY (`id_produto`) REFERENCES `Produto`(`id`);
ALTER TABLE `Terceiro` ADD CONSTRAINT `Terceiro_fk2` FOREIGN KEY (`id_endereco`) REFERENCES `Endereco`(`id`);
ALTER TABLE `Pedido_Terceiro` ADD CONSTRAINT `Pedido_Terceiro_fk0` FOREIGN KEY (`id_terceiro`) REFERENCES `Terceiro`(`id`);

ALTER TABLE `Pedido_Terceiro` ADD CONSTRAINT `Pedido_Terceiro_fk1` FOREIGN KEY (`id_produto`) REFERENCES `Produto`(`id`);