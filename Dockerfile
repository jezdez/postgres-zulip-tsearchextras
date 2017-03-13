FROM postgres:9.5
MAINTAINER Jannis Leidel <jannis@leidel.info>

RUN apt-add-repository -yus ppa:tabbott/zulip && \
    apt-get install postgresql-9.5-tsearch-extras hunspell-en-us && \
    ln -sf /var/cache/postgresql/dicts/en_us.dict \
        "/usr/share/postgresql/9.5/tsearch_data/en_us.dict" && \
    ln -sf /var/cache/postgresql/dicts/en_us.affix \
        "/usr/share/postgresql/9.5/tsearch_data/en_us.affix" && \
    mkdir -p /docker-entrypoint-initdb.d

COPY zulip_english.stop "/usr/share/postgresql/9.5/tsearch_data/zulip_english.stop"
COPY ./initdb-zulip-db.sh /docker-entrypoint-initdb.d/initdb-zulip-db.sh
