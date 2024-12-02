-- Consulta de análise de engajamento: Dado um post de um usuário, fazer a contagem de quantos usuários interagiram com ele nos últimos 7 dias.

USE `ibd-pratical-work`;    

-- Consulta para usuários

SELECT 
    SUM(quantidade) AS interacoes
FROM
    (SELECT 
        COUNT(cod_usuario) AS quantidade
    FROM
        curtida
    WHERE
        cod_post = '' -- Substituir as aspas pelo Código do Post desejado
            AND data_hora >= NOW() - INTERVAL 7 DAY UNION SELECT 
        COUNT(cod_usuario) AS quantidade
    FROM
        comentario
    WHERE
        cod_post = '' -- Substituir as aspas pelo Código do Post desejado
            AND data_hora >= NOW() - INTERVAL 7 DAY UNION SELECT 
        COUNT(cod_usuario) AS quantidade
    FROM
        compartilhamento
    WHERE
        cod_post = '' -- Substituir as aspas pelo Código do Post desejado
            AND data_hora >= NOW() - INTERVAL 7 DAY) AS interacoes;



-- Consulta para grupos

SELECT 
    SUM(quantidade) AS interacoes
FROM
    (SELECT 
        COUNT(cod_usuario) AS quantidade
    FROM
        curtida_grupo
    WHERE
        cod_post_grupo = '' -- Substituir as aspas pelo Código do Post desejado
            AND data_hora >= NOW() - INTERVAL 7 DAY UNION SELECT 
        COUNT(cod_usuario) AS quantidade
    FROM
        comentario_grupo
    WHERE
        cod_post_grupo = '' -- Substituir as aspas pelo Código do Post desejado
            AND data_hora >= NOW() - INTERVAL 7 DAY) AS interacoes;