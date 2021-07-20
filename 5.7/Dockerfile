FROM mysql:5.7.35@sha256:956e11ac581cad9ac8747a9a1d61b8ffcfa6845e0f23bdbab6ba20a2ad792cbf

ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
  locales \
 && rm -rf /var/lib/apt/lists/*

RUN echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG de_DE.UTF-8

CMD ["mysqld", "--sql-mode=", "--character-set-server=utf8", "--collation-server=utf8_general_ci"]
