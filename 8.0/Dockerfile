FROM mysql:8.0.36-bookworm@sha256:fe968a89962f9d6bb594f7525bc1f61e0c61ff89500a41424899bcd7cf65a5c9

ENV DEBIAN_FRONTEND noninteractive

ENV TZ=UTC
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

USER mysql
CMD ["mysqld", "--sql-mode=", "--character-set-server=utf8", "--collation-server=utf8_general_ci"]
