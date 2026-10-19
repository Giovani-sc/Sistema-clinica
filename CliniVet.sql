CREATE DATABASE clinivet;

USE clinivet;

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(256) NOT NULL,

    PRIMARY KEY (id_usuario)
);

CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_nascimento DATE,
    email VARCHAR(255) NOT NULL UNIQUE,
    observacoes_gerais VARCHAR(500),

    PRIMARY KEY (id_cliente),
    UNIQUE (cpf),
    UNIQUE (email)
);

CREATE TABLE endereco_cliente (
    id_endereco_cliente INT NOT NULL AUTO_INCREMENT,
	endereco_completo VARCHAR(50),
    regiao_administrativa VARCHAR(50) NOT NULL,
    id_cliente INT NOT NULL,

    PRIMARY KEY (id_endereco_cliente),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE telefone_cliente (
    id_telefone_cliente INT NOT NULL AUTO_INCREMENT,
    telefone VARCHAR(20) NOT NULL,
    id_cliente INT NOT NULL,
    whatsapp TINYINT NOT NULL,

    PRIMARY KEY (id_telefone_cliente),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE funcionario (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    tipo TINYINT,
    salario DECIMAL(10,2),
    cpf VARCHAR(11) NOT NULL,
    id_usuario INT NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    data_nascimento DATE,
	crmv VARCHAR(50),
    
    PRIMARY KEY (id_funcionario),

    UNIQUE (cpf),
    UNIQUE (crmv),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE endereco_funcionario (
    id_endereco_funcionario INT NOT NULL AUTO_INCREMENT,
	endereco_completo VARCHAR(50),
    regiao_administrativa VARCHAR(50) NOT NULL,
    id_funcionario INT NOT NULL,

    PRIMARY KEY (id_endereco_funcionario),

    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);

CREATE TABLE telefone_funcionario (
    id_telefone_funcionario INT NOT NULL AUTO_INCREMENT,
    telefone VARCHAR(20) NOT NULL,
    id_funcionario INT NOT NULL,
	whatsapp TINYINT NOT NULL,

    PRIMARY KEY (id_telefone_funcionario),

    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);

CREATE TABLE animal (
    id_animal INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(100) NOT NULL,
    raca VARCHAR(100),
    data_nascimento DATE,
    observacoes TEXT,
    sexo ENUM('macho', 'fêmea') NOT NULL,
    prontuario LONGBLOB,
    id_cliente INT NOT NULL,

    PRIMARY KEY (id_animal),

    FOREIGN KEY (id_cliente)
		REFERENCES cliente(id_cliente)
);

CREATE TABLE exame (
    id_exame INT NOT NULL AUTO_INCREMENT,
    exame_pdf LONGBLOB NOT NULL,
    observacoes TEXT,
    valor DECIMAL(10,2),
    gasto DECIMAL(10,2),
    id_animal INT NOT NULL,
    data_hora DATETIME NOT NULL,
    id_funcionario INT NOT NULL,
    
    PRIMARY KEY (id_exame),

    FOREIGN KEY (id_animal)
        REFERENCES animal(id_animal),

	FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);

CREATE TABLE servico (
    id_servico INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(200) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    gasto DECIMAL(10, 2),
    id_animal INT,

    PRIMARY KEY (id_servico),

    FOREIGN KEY (id_animal)
        REFERENCES animal(id_animal)
);

CREATE TABLE consulta (
    id_consulta INT NOT NULL AUTO_INCREMENT,
    motivo VARCHAR(500) NOT NULL,
    anamnese TEXT,
    diagnostico TEXT NOT NULL,
    tratamento TEXT NOT NULL,
    observacoes TEXT,
    tipo VARCHAR(100),
    valor DECIMAL,
    gasto DECIMAL,
    id_animal INT NOT NULL,
    data_hora DATETIME,
    id_funcionario INT NOT NULL,

    PRIMARY KEY (id_consulta),

    FOREIGN KEY (id_animal)
        REFERENCES animal(id_animal),

	FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);

CREATE TABLE agendamento_exame (
    id_agendamento_exame INT NOT NULL AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    status ENUM('finalizada', 'pendente', 'ausente', 'cancelada') NOT NULL,
    observacoes TEXT,
    id_funcionario INT NOT NULL,
    tipo_exame VARCHAR(500) NOT NULL,

    PRIMARY KEY (id_agendamento_exame),

    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);

CREATE TABLE agendamento_consulta (
    id_agendamento_consulta INT NOT NULL AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    status ENUM('finalizada', 'pendente', 'ausente', 'cancelada') NOT NULL,
    observacoes TEXT,
    id_funcionario INT NOT NULL,
    tipo_consulta VARCHAR(500) NOT NULL,

    PRIMARY KEY (id_agendamento_consulta),

	FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);