FROM mariadb:10.2.23@sha256:014373188672e2a7b4756e3bde2fff1d1e49110e4c6b568b8dabaf9709aa7f3b

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
