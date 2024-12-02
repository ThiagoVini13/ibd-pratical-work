-- Consulta de perfil do usuário: Recuperar informações do perfil de um usuário específico, incluindo nome, foto, biografia, etc.

USE `ibd-pratical-work`;

SELECT 
    *
FROM
    usuario
WHERE
    cod_usuario = ''; -- Substituir aspas pelo código do usuário