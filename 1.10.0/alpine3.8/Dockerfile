FROM python:3.5.6-alpine3.8

MAINTAINER Dmytro Bohomiakov

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
ENV AIRFLOW_VERSION 1.10.0

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir apache-airflow[crypto,devel,postgres,mysql,celery]==$AIRFLOW_VERSION

ARG USER=airflow
ARG AIRFLOW_HOME=/usr/local/${USER}

RUN addgroup -S ${USER} \
    && adduser -D -S -h ${AIRFLOW_HOME} -G ${USER} ${USER} \
    && mkdir -p ${AIRFLOW_HOME}/dags ${AIRFLOW_HOME}/sql

WORKDIR ${AIRFLOW_HOME}
COPY config/airflow.cfg airflow.cfg

EXPOSE 8080 5555 8793
