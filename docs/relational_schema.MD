**usuario**(cod_usuario, nome, data_nascimento, biografia, localizacao, foto)

---

**mensagem_usuario**(cod_msg, #cod_usu_remetente, #cod_usuario_destinatario, conteudo, envio_data_hora, recebe_data_hora)​
**mensagem_usuario**[cod_usuario_remetente] -> usuario[cod_usuario]​
**mensagem_usuario**[cod_usuario_destinatario] -> usuario[cod_usuario]

---

**interesse**(#cod_interesse, nome)

---

**interesse_usuario**(#cod_interesse, #cod_usuario)​​
**interesse_usuario**[cod_usuario] -> usuario[cod_usuario]
**interesse_usuario**[cod_interesse] -> interesse[cod_interesse]

---

**grupo**(cod_grupo, #cod_criador, nome, descricao)​
**grupo**[cod_criador] -> usuario[cod_usuario]

---

**mensagem_grupo**(cod_msg, #cod_grupo, data_hora_envio, conteudo)​
**mensagem_grupo**[cod_grupo] -> grupo[cod_grupo]​
**mensagem_grupo**[cod_usuario] -> usuario[cod_usuario]

---

**dthr_msg_destinatario**(#cod_msg, #cod_gru, #cod_usuario_destin, data_hora_recebe)​
**dthr_msg_destinatario**[cod_gru] -> grupo[cod_grupo]​
**dthr_msg_destinatario**[cod_usuario_destin] -> usuario[cod_usuario]​
**dthr_msg_destinatario**[cod_msg] -> mensagem_grupo[cod_msg]

---

**categoria_grupo**(#cod_grupo, categoria)​
**categoria_grupo**[cod_grupo] -> grupo[cod_grupo]

---

**postagem_grupo**(cod_post, #cod_grupo, #cod_usuario, imagem, texto, video, gif, data_hora)​
**postagem_grupo**[cod_grupo] -> grupo[cod_grupo]​
**postagem_grupo**[cod_usuario] -> usuario[cod_usuario]

---

**comentario_grupo**(#cod_grupo, #cod_usuario, #cod_post, data_hora, conteudo)
**comentario_grupo**[cod_grupo] -> grupo[cod_grupo]​
**comentario_grupo**[cod_usuario] -> usuario[cod_usuario]​
**comentario_grupo**[cod_post] -> postagem_grupo[cod_post]

---

**curtida_grupo**(#cod_grupo, #cod_usuario, #cod_post , data_hora)​
**curtida_grupo**[cod_grupo] -> grupo[cod_grupo]​
**curtida_grupo**[cod_usuario] -> usuario[cod_usuario]​
**curtida_grupo**[cod_post] -> postagem_grupo[cod_post]

---

**postagem_usuario**(cod_post, #cod_usuario, imagem, texto, video, gif, data_hora)​
**postagem_usuario**[cod_usuario] -> usuario[cod_usuario]

---

**compartilhamento**(#cod_usuario, #cod_post, comentario, data_hora)​
**compartilhamento**[cod_usuario] -> usuario[cod_usuario]​
**compartilhamento**[cod_post] -> postagem_usuario[cod_post]

---

**comentario**(#cod_usuario, #cod_post, data_hora, conteudo, data_hora)​
**comentario**[cod_usuario] -> usuario[cod_usuario]​
**comentario**[cod_post] -> postagem_usuario[cod_post]

---

**curtida**(#cod_usuario, #cod_post, data_hora)​
**curtida**[cod_usuario] -> usuario[cod_usuario]​
**curtida**[cod_post] -> postagem_usuario[cod_post]

---

**conexao**(#cod_usuario1, #cod_usuario2)​
**conexao**[cod_usuario1] -> usuario[cod_usuario]​
**conexao**[cod_usuario2] -> usuario[cod_usuario]

---

**participante_comunidade**(#cod_usuario, #cod_grupo)​
**participante_comunidade**[cod_usuario] -> usuario[cod_usuario]​
**participante_comunidade**[cod_post] -> grupo[cod_grupo]
