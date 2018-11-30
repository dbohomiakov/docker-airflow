FROM dbohomiakov/airflow:1.10.0-alpine3.8

ONBUILD COPY requirements.txt .

ONBUILD RUN if [ -s requirements.txt ]; then pip install -r requirements.txt; fi

ONBUILD USER airflow
