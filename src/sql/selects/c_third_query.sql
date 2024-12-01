-- Consulta de postagens de um usuário: Recuperar todas as postagens feitas por um usuário específico, ordenadas por data de publicação (as mais recentes primeiro).

SELECT 
    *
FROM
    postagem_usuario
WHERE
    cod_usuario = '' -- Substituir aspas pelo código do usuário
ORDER BY data_hora DESC;