FROM python:3.6-slim-stretch

LABEL maintainer="Darius Ndubi <ndubidarius@gmail.com>"

WORKDIR /superset

# Application environment variables
ENV SUPERSET_PORT=8080
ENV SUPERSET_LATEST_VERSION="superset package version"
ENV DB_URI="postgres db uri"
ENV SUPERSET_ADM_PASSWORD="admin password"
ENV SECRET_KEY="application secret key"

# Update packages and install necessary dependancies. Installs superset as a pip package picking the latest build
RUN apt-get update && \
    apt-get install build-essential nano libssl-dev libffi-dev libsasl2-dev libldap2-dev -y && \
    pip install virtualenv && \
    python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade setuptools pip && \
    pip install gevent pymssql psycopg2-binary && \
    pip install apache-superset==$SUPERSET_LATEST_VERSION && \
    rm -f /superset/venv/lib/python3.6/site-packages/superset/config.py && \
    apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy entrypoint file and superset config file
COPY ./custom_configs/docker-entrypoint.sh superset_start.sh
COPY ./custom_configs/config.py config.py

# Setup superset admin user and initialize the db
RUN . venv/bin/activate && \
    chmod +x superset_start.sh && \
    mv config.py venv/lib/python3.6/site-packages/superset/config.py && \
    superset fab create-admin --username admin \
    --firstname Superset \
    --lastname Admin \
    --email admin@superset.com \
    --password $SUPERSET_ADM_PASSWORD && \
    echo "------------- Superset upgrade-------------" && \
    superset db upgrade && \
    echo "++++++++++++++ Superset init ++++++++++++++++" && \
    superset init

# expose superset container port
EXPOSE $SUPERSET_PORT

# Set super set entry point
ENTRYPOINT ["/superset/superset_start.sh"]
