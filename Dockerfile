# Use uma imagem Python oficial e leve como imagem base.
# A tag 'slim' é um bom equilíbrio entre tamanho e compatibilidade.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para o diretório de trabalho.
# Fazer isso em um passo separado aproveita o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências listadas no requirements.txt
RUN pip install --no-cache-dir pip -r requirements.txt

# Copia o restante do código da sua aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que o Uvicorn rodará a aplicação
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]