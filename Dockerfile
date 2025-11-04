# DOCKERFILE FINAL

# Gunakan base image Python standar (sudah mengatasi masalah compiler)
FROM python:3.10

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV APP_HOME /app
WORKDIR $APP_HOME

# 1. Copy requirements dari subfolder dan instal dependensi
# MENGATASI ERROR "file not found" (Path Koreksi)
COPY f1-winner-api/requirements.txt ./ 
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# 2. Copy file aplikasi dan model dari subfolder
# Ini menggantikan COPY . ./ yang berbahaya
COPY f1-winner-api/main.py ./
COPY f1-winner-api/model.pkl ./
COPY f1-winner-api/scaler.pkl ./

# Tentukan port dan command running
ENV PORT 8080
CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --worker-class uvicorn.workers.UvicornWorker main:app
