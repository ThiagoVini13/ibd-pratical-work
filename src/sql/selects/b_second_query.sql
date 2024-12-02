-- Consulta de conexões de um usuário: Obter a lista de amigos de um determinado usuário.

USE `ibd-pratical-work`;

SELECT 
    *
FROM
    usuario u
        INNER JOIN
    conexao c ON u.cod_usuario IN (c.cod_usuario1 , c.cod_usuario2)
        AND '' IN (c.cod_usuario1 , c.cod_usuario2) -- Substituir aspas pelo código do usuário
        AND u.cod_usuario <> '' -- Substituir aspas pelo código do usuário
;
