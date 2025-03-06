CREATE TABLE IF NOT EXISTS `Cliente` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`cpf` varchar(11) NOT NULL UNIQUE,
	`telefone` varchar(11) NOT NULL,
	`id_endereco` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Veiculo` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`placa` varchar(255) NOT NULL,
	`modelo` varchar(255) NOT NULL,
	`marca` varchar(255) NOT NULL,
	`ano` year NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Ordem_servico` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`data_emissao` date NOT NULL,
	`valor` decimal(10,0) NOT NULL,
	`status` enum NOT NULL,
	`data_entrega` date NOT NULL,
	`id_avaliacao` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Mecanico` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(255) NOT NULL,
	`id_endereco` int NOT NULL,
	`especialidade` enum NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Peca` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(255) NOT NULL,
	`descricao` varchar(255) NOT NULL,
	`valor` decimal(10,0) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Endereco` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`cep` varchar(8) NOT NULL,
	`logradouro` varchar(255) NOT NULL,
	`bairro` varchar(255) NOT NULL,
	`cidade` varchar(255) NOT NULL,
	`pais` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Executar_OS` (
	`id_mecanico` int NOT NULL,
	`id_os` int NOT NULL,
	`status` enum NOT NULL
);

CREATE TABLE IF NOT EXISTS `Pecas_Servico` (
	`id_os` int NOT NULL,
	`id_peca` int NOT NULL
);

CREATE TABLE IF NOT EXISTS `Revisao` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_cliente` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Executar_revisao` (
	`id_mecanico` int NOT NULL,
	`id_revisao` int NOT NULL
);

CREATE TABLE IF NOT EXISTS `Avaliacao` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_cliente` int NOT NULL,
	`id_veiculo` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Servico` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`descricao` varchar(255) NOT NULL,
	`valor` decimal(10,0) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Cliente_Veiculo` (
	`id_cliente` int NOT NULL,
	`id_veiculo` int NOT NULL
);

CREATE TABLE IF NOT EXISTS `Avaliacao_Servico` (
	`id_avaliacao` int NOT NULL,
	`id_servico` int NOT NULL
);

ALTER TABLE `Cliente` ADD CONSTRAINT `Cliente_fk3` FOREIGN KEY (`id_endereco`) REFERENCES `Endereco`(`id`);

ALTER TABLE `Ordem_servico` ADD CONSTRAINT `Ordem_servico_fk5` FOREIGN KEY (`id_avaliacao`) REFERENCES `Avaliacao`(`id`);
ALTER TABLE `Mecanico` ADD CONSTRAINT `Mecanico_fk2` FOREIGN KEY (`id_endereco`) REFERENCES `Endereco`(`id`);


ALTER TABLE `Executar_OS` ADD CONSTRAINT `Executar_OS_fk0` FOREIGN KEY (`id_mecanico`) REFERENCES `Mecanico`(`id`);

ALTER TABLE `Executar_OS` ADD CONSTRAINT `Executar_OS_fk1` FOREIGN KEY (`id_os`) REFERENCES `Ordem_servico`(`id`);
ALTER TABLE `Pecas_Servico` ADD CONSTRAINT `Pecas_Servico_fk0` FOREIGN KEY (`id_os`) REFERENCES `Ordem_servico`(`id`);

ALTER TABLE `Pecas_Servico` ADD CONSTRAINT `Pecas_Servico_fk1` FOREIGN KEY (`id_peca`) REFERENCES `Peca`(`id`);
ALTER TABLE `Revisao` ADD CONSTRAINT `Revisao_fk1` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id`);
ALTER TABLE `Executar_revisao` ADD CONSTRAINT `Executar_revisao_fk0` FOREIGN KEY (`id_mecanico`) REFERENCES `Mecanico`(`id`);

ALTER TABLE `Executar_revisao` ADD CONSTRAINT `Executar_revisao_fk1` FOREIGN KEY (`id_revisao`) REFERENCES `Revisao`(`id`);
ALTER TABLE `Avaliacao` ADD CONSTRAINT `Avaliacao_fk1` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id`);

ALTER TABLE `Avaliacao` ADD CONSTRAINT `Avaliacao_fk2` FOREIGN KEY (`id_veiculo`) REFERENCES `Veiculo`(`id`);

ALTER TABLE `Cliente_Veiculo` ADD CONSTRAINT `Cliente_Veiculo_fk0` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id`);

ALTER TABLE `Cliente_Veiculo` ADD CONSTRAINT `Cliente_Veiculo_fk1` FOREIGN KEY (`id_veiculo`) REFERENCES `Veiculo`(`id`);
ALTER TABLE `Avaliacao_Servico` ADD CONSTRAINT `Avaliacao_Servico_fk0` FOREIGN KEY (`id_avaliacao`) REFERENCES `Avaliacao`(`id`);

ALTER TABLE `Avaliacao_Servico` ADD CONSTRAINT `Avaliacao_Servico_fk1` FOREIGN KEY (`id_servico`) REFERENCES `Servico`(`id`);