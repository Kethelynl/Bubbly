FROM python:3.9-slim

# Configurar diretório de trabalho
WORKDIR /app

# Instalar dependências
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copiar o restante do código para a imagem
COPY . /app/

# Executar as migrações e coletar arquivos estáticos
RUN python manage.py migrate
RUN python manage.py collectstatic --noinput

# Comando para rodar o servidor
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "bubbly.wsgi:application"]
