FROM python:3.7-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir \
    Django==2.2.4 \
    django-allauth==0.40.0 \
    django-crispy-forms==1.7.2 \
    django-countries==5.5 \
    stripe==2.37.1 \
    Pillow \
    gunicorn \
    whitenoise

COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput || true

EXPOSE 8000

CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "2"]
