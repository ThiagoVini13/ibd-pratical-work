import mysql.connector
from mysql.connector import Error

# Função para conectar ao banco de dados MySQL
def conectar_banco(host, usuario, senha, banco):
    try:
        conexao = mysql.connector.connect(
            host=host,
            user=usuario,
            password=senha,
            database=banco
        )
        if conexao.is_connected():
            print("Conectado ao banco de dados")
            return conexao
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

# Função para executar um arquivo SQL no banco de dados
def executar_sql_arquivo(conexao, arquivo_sql):
    try:
        cursor = conexao.cursor()
        
        # Lê o conteúdo do arquivo SQL
        with open(arquivo_sql, 'r', encoding='utf-8') as file:
            sql_script = file.read()
        
        # Executa o script SQL
        for comando in sql_script.split(';'):
            comando = comando.strip()
            if comando:
                cursor.execute(comando)
                print(f"Executando: {comando}")
        
        # Confirma as alterações no banco de dados
        conexao.commit()
        print("Arquivo SQL executado com sucesso!")
    except Error as e:
        print(f"Erro ao executar o SQL: {e}")
        conexao.rollback()
    finally:
        cursor.close()

# Função principal
def main():
    # Parâmetros de conexão
    host = 'localhost'  # Endereço do servidor MySQL
    usuario = 'root'  # Seu usuário do banco de dados
    senha = 'sua_senha'  # Sua senha de acesso ao banco de dados
    banco = 'seu_banco'  # Nome do banco de dados

    # Caminho do arquivo SQL
    arquivo_sql = 'caminho/do/seu/arquivo.sql'

    # Conectar ao banco de dados
    conexao = conectar_banco(host, usuario, senha, banco)

    if conexao:
        # Executar o arquivo SQL
        executar_sql_arquivo(conexao, arquivo_sql)
        
        # Fechar a conexão
        conexao.close()

if __name__ == '__main__':
    main()
