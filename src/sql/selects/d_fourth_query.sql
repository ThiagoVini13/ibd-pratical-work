-- Consulta de postagens em um grupo: Listar 20 as postagens mais recentes feitas em um grupo específico.

SELECT 
    *
FROM
    postagem_grupo
WHERE
    cod_grupo = '' -- Substituir aspas pelo código do grupo
ORDER BY data_hora DESC
LIMIT 20;