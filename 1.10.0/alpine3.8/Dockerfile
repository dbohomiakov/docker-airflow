FROM python:3.5.6-alpine3.8

MAINTAINER dbohomiakov

ENV LANG en_US.utf8
ENV AIRFLOW_GPL_UNIDECODE yes
ARG AIRFLOW_VERSION=1.10.0
ARG AIRFLOW_HOME=/usr/local/airflow

RUN addgroup -S airflow \
    && adduser -D -S -h ${AIRFLOW_HOME} -G airflow airflow

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

RUN pip install -U pip \
    && pip install --no-cache-dir apache-airflow[crypto,devel,postgres,mysql,celery]==${AIRFLOW_VERSION}

WORKDIR ${AIRFLOW_HOME}
COPY config/airflow.cfg .

EXPOSE 8080 5555 8793
