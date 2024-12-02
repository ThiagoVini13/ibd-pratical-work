-- Consulta de busca de usuários: Dado uma string como entrada, buscar os usuários cujos nomes contenham a string fornecida.

USE `ibd-pratical-work`;

SELECT 
    *
FROM
    usuario
WHERE
    nome LIKE "%''%"; -- Substituir aspas pelo nome do usuário
