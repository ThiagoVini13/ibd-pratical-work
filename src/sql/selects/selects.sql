/*Primeira consulta*/
SELECT 
    *
FROM
    usuarios
WHERE
    cod_usuario = ''; -- Substituir aspas pelo código do usuário


/*Segunda consulta*/
SELECT
	*
FROM
	usuarios u
inner join conexao c
on
u.cod_usuario in (c.cod_usuario1,c.cod_usuario2) and
"" -- Substituir aspas pelo código do usuário
in (c.cod_usuario1,c.cod_usuario2) and  
u.cod_usuario <> "" -- Substituir aspas pelo código do usuário
;


/*Terceira consulta*/
SELECT 
    *
FROM
    postagem_usuario
WHERE
    cod_usuario = "" -- Substituir aspas pelo código do usuário
ORDER BY data_hora DESC;


/*Quarta consulta*/
SELECT 
    *
FROM
    postagem_grupo
WHERE
    cod_grupo = "" -- Substituir aspas pelo código do grupo
ORDER BY data_hora DESC
LIMIT 20;

/*Quinta consulta*/
SELECT
	*
FROM
	mensagem_usuario
WHERE
	cod_usu_remetente = “” -- Substituir aspas pelo código do usuário
    	AND cod_usu_destinatario = “” -- Substituir aspas pelo código do usuário
UNION SELECT
	*
FROM
	mensagem_usuario
WHERE
	cod_usu_remetente = “” -- Substituir aspas pelo código do usuário
    	AND cod_usu_destinatario = ”” -- Substituir aspas pelo código do usuário;
order by envio_data_hora DESC, recebe_data_hora DESC
limit 10;

/*Sexta consulta*/
SELECT 
    *
FROM
    usuarios
WHERE
    nome LIKE '%""%';-- Substituir aspas duplas pelo código do usuário

/*Sétima consulta*/
WITH post_usu AS (
    SELECT 
        pu.cod_post AS cod_post,
        COUNT(ct.cod_usuario) AS qt_curtidas,
        COUNT(cm.cod_usuario) AS qt_comentarios,
        (COUNT(ct.cod_usuario) + COUNT(cm.cod_usuario)) AS indice_interacao
    FROM postagem_usuario pu
    LEFT JOIN curtida ct
        ON pu.cod_post = ct.cod_post
    LEFT JOIN comentario cm
        ON pu.cod_post = cm.cod_post
    GROUP BY pu.cod_post
),
post_group AS (
    SELECT 
        pg.cod_post AS cod_post,
        COUNT(ct.cod_grupo) AS qt_curtidas,
        COUNT(cm.cod_grupo) AS qt_comentarios,
        (COUNT(ct.cod_grupo) + COUNT(cm.cod_grupo)) AS indice_interacao
    FROM postagem_grupo pg
    LEFT JOIN curtida_grupo ct
        ON pg.cod_post = ct.cod_post_grupo
    LEFT JOIN comentario_grupo cm
        ON pg.cod_post = cm.cod_post_grupo
    GROUP BY pg.cod_post
)
SELECT 
    cod_post,
    qt_curtidas,
    qt_comentarios,
    indice_interacao
FROM post_usu
UNION ALL
SELECT 
    cod_post,
    qt_curtidas,
    qt_comentarios,
    indice_interacao
FROM post_group
ORDER BY indice_interacao DESC
LIMIT 5;






