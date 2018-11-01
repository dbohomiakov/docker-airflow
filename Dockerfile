FROM python:3.5.6-alpine3.8

RUN apk add make automake gcc \
                          g++ \
                          subversion \
                          python3-dev \
    && apk add --no-cache --virtual .build-deps linux-headers \
                                                libxml2-dev \
                                                libxslt-dev \
                                                mariadb-dev \
                                                postgresql-dev \
                                                libffi-dev

ENV AIRFLOW_GPL_UNIDECODE yes
ARG USER=airflow
ARG AIRFLOW_HOME=/usr/local/${USER}
RUN mkdir -p ${AIRFLOW_HOME}

RUN adduser -D airflow
RUN chown -R airflow: ${AIRFLOW_HOME}
USER airflow

RUN mkdir -p ${AIRFLOW_HOME}/dags ${AIRFLOW_HOME}/sql

ENV PATH="/home/${USER}/.local/bin:$PATH"
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt --user ${USER}
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

EXPOSE 8080 5555 8793

WORKDIR ${AIRFLOW_HOME}

CMD ["airflow webserver"]
