DROP DATABASE if EXISTS `ibd-pratical-work`;
CREATE DATABASE `ibd-pratical-work`;
USE `ibd-pratical-work`;

CREATE TABLE `usuarios` (
    `cod_usuario` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `data_nascimento` DATE NOT NULL,
    `biografia` VARCHAR(255),
    `localizacao` VARCHAR(255),
    PRIMARY KEY (cod_usuario)
) ENGINE=InnoDB;

CREATE TABLE `mensagem_usuario` (
    `cod_mensagem` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `cod_usu_remetente` INT NOT NULL,
    `cod_usu_destinatario` INT NOT NULL,
    `conteudo` TEXT NOT NULL,
    `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cod_usu_remetente) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY (cod_usu_destinatario) REFERENCES usuarios(cod_usuario)
) Engine=InnoDB;

CREATE TABLE `grupo` ( 
    `cod_grupo` INT NOT NULL AUTO_INCREMENT,
    `cod_criador` INT NOT NULL,
    `nome` VARCHAR(255) NOT NULL,
    `descricao` VARCHAR(255),
    PRIMARY KEY(cod_grupo),
    FOREIGN key(cod_criador) REFERENCES usuarios(cod_usuario)
) Engine=InnoDB;

CREATE TABLE `mensagem_grupo` (
    `cod_msg` INT NOT NULL AUTO_INCREMENT,
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `conteudo` VARCHAR(255) NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY(cod_msg, cod_grupo, cod_usuario),
    FOREIGN KEY(cod_grupo) REFERENCES grupo(cod_grupo),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario)
) Engine=InnoDB;

CREATE TABLE `postagem_grupo` (
    `cod_post_grupo` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `cod_grupo`INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `imagem` MEDIUMBLOB,
    `video` LONGBLOB,
    `gif` BLOB,
    `data_hora` DATETIME NOT NULL,
    FOREIGN KEY(cod_grupo) REFERENCES grupo(cod_grupo),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario)

) Engine=InnoDB;

CREATE TABLE `comentario_grupo` (
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    `comentario` VARCHAR(255) NOT NULL,
    PRIMARY KEY(cod_grupo, cod_usuario, data_hora),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_grupo) REFERENCES grupo(cod_grupo)
) Engine=InnoDB;

CREATE TABLE `curtida_grupo` (
    `cod_grupo` INT NOT NULL,
    `cod_usuario` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY(cod_grupo, cod_usuario),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_grupo) REFERENCES grupo(cod_grupo)
) Engine=InnoDB;

CREATE TABLE `postagem_usuario` (
    `cod_post` INT NOT NULL AUTO_INCREMENT,
    `cod_usuario` INT NOT NULL,
    `imagem` MEDIUMBLOB,
    `video` LONGBLOB,
    `gif` BLOB,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY(cod_post, cod_usuario),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario)
) Engine=InnoDB;

CREATE TABLE `compartilhamento` (
    `cod_usuario` INT NOT NULL,
    `cod_post` INT NOT NULL,
    `comentario` VARCHAR(255),
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY(cod_usuario, cod_post),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_post) REFERENCES postagem_usuario(cod_post)
) Engine=InnoDB;

CREATE TABLE `comentario` (
    `cod_usuario` INT NOT NULL,
    `cod_post` INT NOT NULL,
    `conteudo` VARCHAR(255) NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY(cod_usuario, cod_post),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_post) REFERENCES postagem_usuario(cod_post)
) Engine=InnoDB;

CREATE TABLE `curtida` (
    `cod_usuario` INT NOT NULL,
    `cod_post` INT NOT NULL,
    `data_hora` DATETIME NOT NULL,
    PRIMARY KEY(cod_usuario, cod_post),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_post) REFERENCES postagem_usuario(cod_post)
) Engine=InnoDB;

CREATE TABLE `conexao` (
    `cod_usuario1` INT NOT NULL,
    `cod_usuario2` INT NOT NULL,
    PRIMARY KEY(cod_usuario1, cod_usuario2),
    FOREIGN KEY(cod_usuario1) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_usuario2) REFERENCES usuarios(cod_usuario)
) Engine=InnoDB;

CREATE TABLE `participantes_comunidade` (
    `cod_usuario` INT NOT NULL,
    `cod_grupo` INT NOT NULL,
    PRIMARY KEY(cod_usuario, cod_grupo),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario),
    FOREIGN KEY(cod_grupo) REFERENCES grupo(cod_grupo)
) Engine=InnoDB;

CREATE TABLE `interesses_usuario` (
    `cod_usuario` INT NOT NULL,
    `nome` varchar(255) NOT NULL,
    PRIMARY KEY(cod_usuario, nome),
    FOREIGN KEY(cod_usuario) REFERENCES usuarios(cod_usuario)
) Engine=InnoDB;
