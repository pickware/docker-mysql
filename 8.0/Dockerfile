FROM mysql:8.0.26@sha256:d45561a65aba6edac77be36e0a53f0c1fba67b951cb728348522b671ad63f926

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
