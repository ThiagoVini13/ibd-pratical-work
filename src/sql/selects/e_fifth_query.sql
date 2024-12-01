-- Consulta de mensagens privadas: Listar as 10 mensagens privadas mais recentes trocadas entre 2 usuários dados como entrada. 

SELECT 
    *
FROM
    mensagem_usuario
WHERE
    cod_usu_remetente = '' -- Substituir aspas pelo código do usuário
        AND cod_usu_destinatario = '' -- Substituir aspas pelo código do usuário
UNION 
SELECT 
    *
FROM
    mensagem_usuario
WHERE
    cod_usu_remetente = '' -- Substituir aspas pelo código do usuário
        AND cod_usu_destinatario = '' -- Substituir aspas pelo código do usuário
ORDER BY envio_data_hora DESC , recebe_data_hora DESC
LIMIT 10;