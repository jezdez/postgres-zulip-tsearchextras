FROM postgres:9.5
MAINTAINER Jannis Leidel <jannis@leidel.info>

RUN apt-get -q update && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:tabbott/zulip && \
    sed -i 's/jessie/xenial/g' /etc/apt/sources.list.d/tabbott-zulip-jessie.list && \
    apt-get -q update && \
    apt-get install -y postgresql-9.5-tsearch-extras hunspell-en-us && \
    ln -sf /var/cache/postgresql/dicts/en_us.dict \
        "/usr/share/postgresql/9.5/tsearch_data/en_us.dict" && \
    ln -sf /var/cache/postgresql/dicts/en_us.affix \
        "/usr/share/postgresql/9.5/tsearch_data/en_us.affix" && \
    mkdir -p /docker-entrypoint-initdb.d && \
    apt-get --purge remove -y software-properties-common && \
    apt-get -qq autoremove --purge -y && \
    apt-get -qq clean && \
    rm -rf /root/zulip/puppet/ /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD zulip_english.stop /usr/share/postgresql/9.5/tsearch_data/zulip_english.stop
ADD initdb-zulip-db.sh /docker-entrypoint-initdb.d/initdb-zulip-db.sh
