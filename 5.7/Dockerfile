# Note: We are still using buster as for bullseye, only MySQL >= 8.0 is available.
FROM debian:buster-20220418-slim@sha256:06a7bee0f90b6087f2b239125ef3c75d474e48cc69643d496d0c6e545fd91023

ENV DEBIAN_FRONTEND noninteractive

# Install mysql
RUN set -euvx \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        # gnupg is necessary to pre-process keys for external APT repositories (MySQL):
        gnupg \
        # wget is used to download configuration for the external MySQL repository:
        wget \
        # mysql-apt-config pre-depends on lsb-release:
        lsb-release

# Find the newest version on <https://dev.mysql.com/downloads/repo/apt/>.
ARG MYSQL_APT_CONFIG_DEB_URL='https://dev.mysql.com/get/mysql-apt-config_0.8.33-1_all.deb'
ARG MYSQL_APT_CONFIG_DEB_SHA256='455ec3690765cff58a4123ba498921fb58fb76c46465e9659180848e997452b6'

RUN set -euvx \
    # Prepare configuration MySQL installation from external MySQL repository:
    && printf '%s\n' 'mysql-apt-config mysql-apt-config/select-server select mysql-5.7' | debconf-set-selections \
    && wget --output-document=/root/mysql-apt-config.deb "$MYSQL_APT_CONFIG_DEB_URL" \
    && printf '%s  %s\n' "$MYSQL_APT_CONFIG_DEB_SHA256" /root/mysql-apt-config.deb | sha256sum --strict --check \
    # mysql-apt-config fails if this directory does not already exist:
    && mkdir -p /etc/apt/sources.list.d \
    && dpkg -i /root/mysql-apt-config.deb \
    # Add new mysql key.
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29 \
    && rm /root/mysql-apt-config.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        mysql-client \
        mysql-server

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  locales \
 && rm -rf /var/lib/apt/lists/*

RUN echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG de_DE.UTF-8

USER root
# COPY set-mysql-password.sh /set-mysql-password.sh
# RUN /set-mysql-password.sh

#USER mysql
COPY entrypoint.sh /home/mysql/entrypoint.sh
ENTRYPOINT /home/mysql/entrypoint.sh
