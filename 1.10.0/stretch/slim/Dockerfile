FROM python:3.6-slim

MAINTAINER andriisoldatenko

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV AIRFLOW_GPL_UNIDECODE yes
ARG AIRFLOW_HOME=/usr/local/airflow

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
       freetds-dev \
       python3-dev \
       libkrb5-dev \
       libsasl2-dev \
       libssl-dev \
       libffi-dev \
       libpq-dev \
       freetds-bin \
       build-essential \
       default-libmysqlclient-dev \
       apt-utils \
       locales \
       gcc \
       git \
       iputils-ping \
       netcat \
       curl \
       vim \
    && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Sane defaults for pip
ENV PIP_NO_CACHE_DIR off
ENV PIP_DISABLE_PIP_VERSION_CHECK on

COPY requirements.txt requirements.txt

RUN pip install -U pip setuptools wheel
RUN pip install apache-airflow[crypto,devel,postgres,mysql,celery]==1.10.0

RUN groupadd -r airflow && useradd -d ${AIRFLOW_HOME} -r -ms /bin/bash -g airflow airflow
RUN chown -R airflow:airflow ${AIRFLOW_HOME}
USER airflow

COPY script/entrypoint.sh /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

EXPOSE 8080 5555 8793

ENTRYPOINT ["/entrypoint.sh"]