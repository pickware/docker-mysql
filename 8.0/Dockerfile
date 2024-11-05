FROM mysql:8.0.40-bookworm@sha256:49b84fc5916192e766f6879127d4d871e7101e73bd15ca63df4c1d5ba6d08946

ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG MYSQL_APT_CONFIG_DEB_URL='https://dev.mysql.com/get/mysql-apt-config_0.8.33-1_all.deb'
ARG MYSQL_APT_CONFIG_DEB_SHA256='sha256:455ec3690765cff58a4123ba498921fb58fb76c46465e9659180848e997452b6'

ADD --checksum=$MYSQL_APT_CONFIG_DEB_SHA256 $MYSQL_APT_CONFIG_DEB_URL /root/mysql-apt-config.deb

RUN # mysql-apt-config fails if this directory does not already exist: \
    mkdir -p /etc/apt/sources.list.d \
    && dpkg -i /root/mysql-apt-config.deb \
    && rm /root/mysql-apt-config.deb \
    && apt '--option=APT::Acquire::Retries="3"' update \
    && apt '--option=APT::Acquire::Retries="3"' install --no-install-recommends -y locales \
   && rm -rf /var/lib/apt/lists/*
RUN apt update \
 && apt install --no-install-recommends -y \
  locales \
 && rm -rf /var/lib/apt/lists/*

RUN echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
RUN echo "\
[mysqld]\n\
default-authentication-plugin=mysql_native_password\n\
group_concat_max_len=320000" >> /etc/my.cnf
ENV LANG de_DE.UTF-8

CMD ["mysqld", "--sql-mode=", "--character-set-server=utf8", "--collation-server=utf8_general_ci"]
