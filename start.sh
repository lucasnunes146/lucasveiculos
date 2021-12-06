#!/bin/bash
echo "Esperando banco de dados carregar"
postgres_ready() {
python3 << END
import sys
import psycopg2
try:
    conn = psycopg2.connect(
        dbname = "lucasveiculos_db",
        user = "lucasveiculos",
        password = "lucasveiculos",
        host = "lucasveiculos_postgres"
    )
except psycopg2.OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

until postgres_ready; do
    >&2 echo "PostgreSQL não está disponível ainda - Espere..."
    sleep 1
done

echo "Rodando as migrações"
python manage.py migrate

echo "Rodando o servidor"
gunicorn lucasveiculos.wsgi -b 0.0.0.0:8000 --reload --log-level DEBUG --workers 1
