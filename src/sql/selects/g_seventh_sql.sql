-- Consulta de tendências: Listar o identificador dos 5 posts com mais interações nos últimos 7 dias.

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
