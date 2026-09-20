CREATE DATABASE clinivet;

USE clinivet;

CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_nascimento DATE NULL,
    email VARCHAR(255) NOT NULL,
    observacoes_gerais VARCHAR(500) NULL,

    PRIMARY KEY (id_cliente),
    UNIQUE (cpf),
    UNIQUE (email)
);

CREATE TABLE endereco_cliente (
    id_endereco_cliente INT NOT NULL,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    numero VARCHAR(25) NOT NULL,
    complemento VARCHAR(50) NULL,
    bairro VARCHAR(45) NOT NULL,
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

CREATE TABLE prontuario (
    id_prontuario INT NOT NULL AUTO_INCREMENT,
    pdf_prontuario LONGBLOB NOT NULL,
    observacoes TEXT,

    PRIMARY KEY (id_prontuario)
);



CREATE TABLE animal (
    id_animal INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(100) NOT NULL,
    raca VARCHAR(100),
    idade INT,
    observacoes TEXT,
    id_prontuario INT,
    sexo ENUM('macho', 'fêmea'),
    id_cliente INT NOT NULL,

    PRIMARY KEY (id_animal),

    FOREIGN KEY (id_prontuario)
        REFERENCES prontuario(id_prontuario),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE exame (
    id_exame INT NOT NULL AUTO_INCREMENT,
    exame_pdf LONGBLOB NOT NULL,
    observacoes TEXT,
    valor DECIMAL(10, 2) NOT NULL,
    gasto DECIMAL(10, 2),
    id_animal INT NOT NULL,

    PRIMARY KEY (id_exame),

    FOREIGN KEY (id_animal)
        REFERENCES animal(id_animal)
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
    diagnostico TEXT,
    tratamento TEXT,
    observacoes TEXT,
    tipo VARCHAR(100),
    valor DECIMAL(10, 2) NOT NULL,
    gasto DECIMAL(10, 2),
    id_animal INT NOT NULL,

    PRIMARY KEY (id_consulta),

    FOREIGN KEY (id_animal)
        REFERENCES animal(id_animal)
);

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(255) NOT NULL,
    senha VARCHAR(256) NOT NULL,

    PRIMARY KEY (id_usuario)
);

CREATE TABLE veterinario (
    id_veterinario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NULL,
    crmv VARCHAR(45) NULL,
    salario DECIMAL(10,2) NULL,
    id_usuario INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    data_nascimento DATE NULL,

    PRIMARY KEY (id_veterinario),

    UNIQUE (cpf),
    UNIQUE (crmv),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE endereco_veterinario (
    id_endereco_veterinario INT NOT NULL,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    numero VARCHAR(25) NOT NULL,
    complemento VARCHAR(50) NULL,
    bairro VARCHAR(45) NOT NULL,
    regiao_administrativa VARCHAR(50) NOT NULL,
    id_veterinario INT NOT NULL,

    PRIMARY KEY (id_endereco_veterinario),

    FOREIGN KEY (id_veterinario)
        REFERENCES veterinario(id_veterinario)
);

CREATE TABLE telefone_veterinario (
    id_telefone_veterinario INT NOT NULL AUTO_INCREMENT,
    telefone VARCHAR(20) NOT NULL,
    id_veterinario INT NOT NULL,
	whatsapp TINYINT NOT NULL,
 
    PRIMARY KEY (id_telefone_veterinario),

    FOREIGN KEY (id_veterinario)
        REFERENCES veterinario(id_veterinario)
);

CREATE TABLE agendamento_exame (
    id_agendamento_exame INT NOT NULL AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    status ENUM('cancelada', 'pendente', 'concluida') NOT NULL,
    observacoes TEXT NULL,
    id_veterinario INT NOT NULL,
    tipo_exame VARCHAR(500) NOT NULL,

    PRIMARY KEY (id_agendamento_exame),

    FOREIGN KEY (id_veterinario)
        REFERENCES veterinario(id_veterinario)
);

CREATE TABLE agendamento_consulta (
    id_agendamento_consulta INT NOT NULL AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    status ENUM('cancelada', 'pendente', 'concluida') NOT NULL,
    observacoes TEXT NULL,
    id_veterinario INT NOT NULL,
    tipo_consulta VARCHAR(500) NOT NULL,

    PRIMARY KEY (id_agendamento_consulta),

    FOREIGN KEY (id_veterinario)
        REFERENCES veterinario(id_veterinario)
);

CREATE TABLE gasto_separado (
    id_gasto_separado INT NOT NULL AUTO_INCREMENT,
    motivo VARCHAR(500) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (id_gasto_separado)
);

CREATE TABLE funcionario (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    tipo TINYINT NULL,
    salario DECIMAL(10,2) NULL,
    cpf VARCHAR(11) NULL,
    id_usuario INT NOT NULL,
    email VARCHAR(255) NULL,
    data_nascimento DATE NULL,

    PRIMARY KEY (id_funcionario),

    UNIQUE (cpf),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE endereco_funcionario (
    id_endereco_funcionario INT NOT NULL,
    cep VARCHAR(8) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    numero VARCHAR(25) NOT NULL,
    complemento VARCHAR(50) NULL,
    bairro VARCHAR(45) NOT NULL,
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

