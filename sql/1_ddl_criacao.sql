-- -------------------------------------------------------------------------
-- 1. TABELAS FORTES (Sem Chaves Estrangeiras)
-- -------------------------------------------------------------------------

CREATE TABLE Animal (
    id_animal INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raca VARCHAR(50),
    sexo CHAR(1),
    idade_aproximada INT,
    porte VARCHAR(30),
    caracteristicas TEXT,
    situacao_atual VARCHAR(50) NOT NULL
);

CREATE TABLE Responsavel (
    id_responsavel INT PRIMARY KEY,
    cpf VARCHAR(15) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Abrigo (
    id_abrigo INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    rua VARCHAR(100),
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    capacidade INT,
    email VARCHAR(100)
);

CREATE TABLE Veterinario (
    id_veterinario INT PRIMARY KEY,
    crmv VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Adotante (
    id_adotante INT PRIMARY KEY,
    cpf VARCHAR(15) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    rua VARCHAR(100),
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(20),
    email VARCHAR(100)
);

-- -------------------------------------------------------------------------
-- 2. TABELAS DE ATRIBUTOS MULTIVALORADOS (Telefones)
-- -------------------------------------------------------------------------

CREATE TABLE Telefone_Responsavel (
    id_responsavel INT,
    numero VARCHAR(20),
    PRIMARY KEY (id_responsavel, numero),
    FOREIGN KEY (id_responsavel) REFERENCES Responsavel(id_responsavel) ON DELETE CASCADE
);

CREATE TABLE Telefone_Abrigo (
    id_abrigo INT,
    numero VARCHAR(20),
    PRIMARY KEY (id_abrigo, numero),
    FOREIGN KEY (id_abrigo) REFERENCES Abrigo(id_abrigo) ON DELETE CASCADE
);

CREATE TABLE Telefone_Veterinario (
    id_veterinario INT,
    numero VARCHAR(20),
    PRIMARY KEY (id_veterinario, numero),
    FOREIGN KEY (id_veterinario) REFERENCES Veterinario(id_veterinario) ON DELETE CASCADE
);

CREATE TABLE Telefone_Adotante (
    id_adotante INT,
    numero VARCHAR(20),
    PRIMARY KEY (id_adotante, numero),
    FOREIGN KEY (id_adotante) REFERENCES Adotante(id_adotante) ON DELETE CASCADE
);

-- -------------------------------------------------------------------------
-- 3. TABELAS DE RELACIONAMENTOS / EVENTOS (Com Chaves Estrangeiras)
-- -------------------------------------------------------------------------

CREATE TABLE Resgate (
    id_resgate INT PRIMARY KEY,
    data_resgate DATE NOT NULL,
    local_resgate VARCHAR(150),
    situacao_encontrada VARCHAR(100),
    id_animal INT NOT NULL,
    id_responsavel INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_responsavel) REFERENCES Responsavel(id_responsavel) ON DELETE RESTRICT
);

CREATE TABLE Permanencia_Abrigo (
    id_permanencia INT PRIMARY KEY,
    data_entrada DATE NOT NULL,
    data_saida DATE,
    id_animal INT NOT NULL,
    id_abrigo INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_abrigo) REFERENCES Abrigo(id_abrigo) ON DELETE CASCADE
);

CREATE TABLE Atendimento_Veterinario (
    id_atendimento INT PRIMARY KEY,
    data_atendimento DATE NOT NULL,
    procedimento VARCHAR(100) NOT NULL,
    diagnostico TEXT,
    observacoes TEXT,
    id_animal INT NOT NULL,
    id_veterinario INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_veterinario) REFERENCES Veterinario(id_veterinario) ON DELETE RESTRICT
);

CREATE TABLE Adocao (
    id_adocao INT PRIMARY KEY,
    data_adocao DATE NOT NULL,
    observacoes TEXT,
    id_animal INT NOT NULL,
    id_adotante INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_adotante) REFERENCES Adotante(id_adotante) ON DELETE RESTRICT
);

CREATE TABLE Devolucao (
    id_devolucao INT PRIMARY KEY,
    data_devolucao DATE NOT NULL,
    motivo TEXT NOT NULL,
    situacao_pos_retorno VARCHAR(100),
    id_adocao INT UNIQUE NOT NULL, -- UNIQUE garante a cardinalidade 1:1
    FOREIGN KEY (id_adocao) REFERENCES Adocao(id_adocao) ON DELETE CASCADE
);
