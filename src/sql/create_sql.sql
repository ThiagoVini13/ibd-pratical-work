DROP DATABASE if EXISTS `ibd-pratical-work`;
CREATE DATABASE `ibd-pratical-work`;
USE `ibd-pratical-work`;

CREATE TABLE `usuarios` (
    `cod_usuario` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `data_nascimento` DATE NOT NULL,
    `biografia` VARCHAR(255),
    `localizacao` VARCHAR(255),
    `foto_perfil` BLOB,
    PRIMARY KEY (cod_usuario)
)  ENGINE=INNODB;

CREATE TABLE `mensagem_usuario` (
    `cod_mensagem` INT NOT NULL AUTO_INCREMENT,
    `cod_usu_remetente` INT DEFAULT NULL,
    `cod_usu_destinatario` INT DEFAULT NULL,
    `conteudo` VARCHAR(255) NOT NULL,
    `envio_data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `recebe_data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cod_mensagem),
    FOREIGN KEY (cod_usu_remetente)
        REFERENCES usuarios (cod_usuario)
        ON DELETE SET NULL,
    FOREIGN KEY (cod_usu_destinatario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE SET NULL
)  ENGINE=INNODB;

CREATE TABLE `interesse` (
    `cod_interesse` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255),
    PRIMARY KEY (cod_interesse)
)  ENGINE=INNODB;

CREATE TABLE `interesses_usuario` (
    `cod_interesse` INT NOT NULL AUTO_INCREMENT,
    `cod_usuario` INT NOT NULL,
    PRIMARY KEY (cod_interesse , cod_usuario),
    FOREIGN KEY (cod_interesse)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `grupo` (
    `cod_grupo` INT NOT NULL AUTO_INCREMENT,
    `cod_criador` INT NOT NULL,
    `nome` VARCHAR(255) NOT NULL,
    `descricao` VARCHAR(255),
    PRIMARY KEY (cod_grupo),
    FOREIGN KEY (cod_criador)
        REFERENCES usuarios (cod_usuario)
)  ENGINE=INNODB;

CREATE TABLE `mensagem_grupo` (
    `cod_msg` INT NOT NULL AUTO_INCREMENT,
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT DEFAULT NULL,
    `conteudo` VARCHAR(255) NOT NULL,
    `data_hora_envio` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cod_msg),
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE SET NULL
)  ENGINE=INNODB;

CREATE TABLE `dthr_msg_dest` (
    `cod_msg` INT NOT NULL,
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `data_hora_recebe` DATETIME DEFAULT NULL,
    PRIMARY KEY (cod_msg , cod_usuario , cod_grupo),
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo),
    FOREIGN KEY (cod_msg)
        REFERENCES mensagem_grupo (cod_msg)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `categoria` (
    `cod_categoria` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(50),
    PRIMARY KEY (cod_categoria)
)  ENGINE=INNODB;

CREATE TABLE `categoria_grupo` (
    `cod_categoria` INT NOT NULL AUTO_INCREMENT,
    `cod_grupo` INT NOT NULL,
    PRIMARY KEY (cod_categoria , cod_grupo),
    FOREIGN KEY (cod_categoria)
        REFERENCES categoria (cod_categoria)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `postagem_grupo` (
    `cod_post` INT NOT NULL AUTO_INCREMENT,
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `texto` VARCHAR(1000) NOT NULL,
    `imagem` MEDIUMBLOB,
    `video` LONGBLOB,
    `gif` BLOB,
    `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cod_post , cod_grupo , cod_usuario),
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `comentario_grupo` (
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `cod_post_grupo` INT NOT NULL,
    `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `comentario` VARCHAR(255) NOT NULL,
    PRIMARY KEY (cod_grupo , cod_usuario , cod_post_grupo , data_hora),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_post_grupo)
        REFERENCES postagem_grupo (cod_post)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `curtida_grupo` (
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `cod_post_grupo` INT NOT NULL,
    `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cod_grupo , cod_usuario , cod_post_grupo),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_post_grupo)
        REFERENCES postagem_grupo (cod_post)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `postagem_usuario` (
    `cod_post` INT NOT NULL AUTO_INCREMENT,
    `cod_usuario` INT NOT NULL,
    `texto` VARCHAR(256) NOT NULL,
    `imagem` MEDIUMBLOB,
    `video` LONGBLOB,
    `gif` BLOB,
    `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cod_post , cod_usuario),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `compartilhamento` (
    `cod_usuario` INT NOT NULL,
    `cod_post` INT NOT NULL,
    `comentario` VARCHAR(255),
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY (cod_usuario , cod_post),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_post)
        REFERENCES postagem_usuario (cod_post)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `comentario` (
    `cod_usuario` INT NOT NULL,
    `cod_post` INT NOT NULL,
    `conteudo` VARCHAR(255) NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY (cod_usuario , cod_post),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_post)
        REFERENCES postagem_usuario (cod_post)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `curtida` (
    `cod_usuario` INT NOT NULL,
    `cod_post` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY (cod_usuario , cod_post),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_post)
        REFERENCES postagem_usuario (cod_post)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `conexao` (
    `cod_usuario1` INT NOT NULL,
    `cod_usuario2` INT NOT NULL,
    PRIMARY KEY (cod_usuario1 , cod_usuario2),
    FOREIGN KEY (cod_usuario1)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_usuario2)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE `participantes_comunidade` (
    `cod_usuario` INT NOT NULL,
    `cod_grupo` INT NOT NULL,
    PRIMARY KEY (cod_usuario , cod_grupo),
    FOREIGN KEY (cod_usuario)
        REFERENCES usuarios (cod_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_grupo)
        REFERENCES grupo (cod_grupo)
        ON DELETE CASCADE
)  ENGINE=INNODB;
