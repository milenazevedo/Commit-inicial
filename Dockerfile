# Use uma imagem oficial do Python como imagem base.
# A tag "slim" é um bom equilíbrio entre tamanho e compatibilidade.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Fazer isso separadamente do resto do código aproveita o cache do Docker.
COPY requirements.txt .

# Instala as dependências definidas no requirements.txt.
# --no-cache-dir: Desabilita o cache para reduzir o tamanho da imagem.
# --upgrade pip: Garante que a versão mais recente do pip seja usada.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para permitir a comunicação com a aplicação.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# --host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]