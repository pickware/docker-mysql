FROM mysql:8.0.27@sha256:ff9a288d1ecf4397967989b5d1ec269f7d9042a46fc8bc2c3ae35458c1a26727

ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  locales \
 && rm -rf /var/lib/apt/lists/*

RUN echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
RUN echo "\
[mysqld]\n\
default-authentication-plugin=mysql_native_password\n\
group_concat_max_len=320000" >> /etc/my.cnf
ENV LANG de_DE.UTF-8

CMD ["mysqld", "--sql-mode=", "--character-set-server=utf8", "--collation-server=utf8_general_ci"]
