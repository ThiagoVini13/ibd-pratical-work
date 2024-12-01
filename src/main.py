import mysql.connector
import asyncio
import asyncpg
import time

# Função para se conectar ao MySQL e criar o banco de dados
async def create_database_from_sql(host, user, password, sql_file):
    try:
        # Conectar ao MySQL (sem especificar um banco de dados ainda)
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )

        cursor = connection.cursor()

        # Ler o conteúdo do arquivo SQL
        with open(sql_file, 'r') as file:
            sql = file.read()

        # Executar as instruções SQL do arquivo
        for statement in sql.split(';'):
            if statement.strip():  # Ignorar strings vazias
                cursor.execute(statement)

        # Commit das mudanças
        connection.commit()
        print(f"Banco de dados criado e configurado com sucesso!")

    except mysql.connector.Error as err:
        print(f"Erro: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()


async def are_all_tables_empty(host, user, password, database):
    try:
        # Conectar ao banco de dados MySQL
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )

        cursor = connection.cursor()

        # Obter todas as tabelas do banco de dados
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()

        # Verificar se todas as tabelas estão vazias
        for table in tables:
            table_name = table[0]

            # Verificar se a tabela está vazia
            cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
            count = cursor.fetchone()[0]

            if count > 0:
                print(f"O script de população deve ser usado com todas as tabelas vazias")
                return False  # Se qualquer tabela não estiver vazia, retorna False

        print("Todas as tabelas estão vazias.")
        return True  # Se todas as tabelas estiverem vazias, retorna True

    except mysql.connector.Error as err:
        print(f"Erro ao acessar o banco de dados: {err}")
        return False
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
# Função para se conectar ao MySQL e criar o banco de dados

async def populate_database_from_sql_files(host, user, password, database, sql_files):
    try:
        # Conectar ao MySQL
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )

        cursor = connection.cursor()

        # Iniciar a transação
        connection.start_transaction()

        # Loop sobre todos os arquivos SQL fornecidos
        for sql_file in sql_files:
            # Ler o conteúdo do arquivo SQL
            with open(sql_file, 'r') as file:
                sql = file.read()

            # Executar as instruções SQL
            for statement in sql.split(';'):
                if statement.strip():  # Ignorar strings vazias
                    cursor.execute(statement)

        # Commit das mudanças
        connection.commit()
        print(f"Banco de dados populado com sucesso!")

    except mysql.connector.Error as err:
        # Se houver erro, fazer o rollback da transação
        connection.rollback()
        print(f"Erro: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Usando a função
host = 'localhost'
user = 'root'
password = '05.peDro12@'
sql_file_create = './sql/createDatabase/create_database.sql'
database = "ibd-pratical-work"

async def main():
    while(True):
        print("-------------------------------------------------")
        print("Pow, bicho! Seja bem-vindo!")
        print("Escolha a opção desejada:")
        print("1 - Criar o banco de dados")
        print("2 - Popular o banco de dados")
        print("3 - Sair")

        resp = int(input("Insira a resposta: "))

        if (resp==1):
          await create_database_from_sql(host, user, password, sql_file_create)
        elif(resp==2):
            
          if(await are_all_tables_empty(host,user,password,database)):
            await populate_database_from_sql_files(host,user,password,database,[
                "./sql/populate/a_insert_usuarios.sql",
                "./sql/populate/b_insert_grupos.sql",
                "./sql/populate/c_insert_interesses.sql",
                "./sql/populate/d_insert_participantes_comunidade.sql",
                "./sql/populate/e_insert_interesses_usuario.sql",
                "./sql/populate/f_insert_categoria_grupo.sql",
                "./sql/populate/g_insert_conexoes.sql",
                "./sql/populate/h_insert_postagens_usuario.sql",
                "./sql/populate/i_insert_curtidas.sql",
                "./sql/populate/j_insert_compartilhamentos.sql",
                "./sql/populate/k_insert_comentarios.sql",
                "./sql/populate/l_insert_mensagens.sql",
                "./sql/populate/m_insert_postagem_grupo.sql",
                "./sql/populate/n_insert_comentarios_grupo.sql",
                "./sql/populate/o_insert_curtidas_grupo_unicas.sql",
                "./sql/populate/p_insert_mensagens_grupo.sql",
                "./sql/populate/q_insert_dthr_msg_dest.sql"
            ])
        elif(resp==3):
            exit()

        time.sleep(2)
    

asyncio.run(main())


