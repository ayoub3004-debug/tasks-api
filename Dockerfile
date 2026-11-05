# 1. Image de base Python légère
FROM python:3.12-slim

# 2. Définir le dossier de travail
WORKDIR /app

# 3. Copier les dépendances et les installer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copier le code de l'application
COPY app/ ./app/

# 5. Créer un utilisateur non-root
RUN useradd --create-home appuser
USER appuser

# 6. Définir la version et lancer l'application
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.main:app"]