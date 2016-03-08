FROM funkygibbon/pytasklist:latest

RUN mkdir -p /app /app/automysqlbackup && sync

RUN apk add --update coreutils mysql-client bash tar gzip bzip2 openssl ca-certificates duplicity git && rm -rf /var/cache/apk/*

RUN wget -qO - http://sourceforge.net/projects/automysqlbackup/files/latest/download | tar zxf - -C /tmp
RUN cd /tmp && /tmp/install.sh && rm -fr /tmp/*

RUN cd /tmp && wget -qO- -O tmp.zip https://github.com/zertrin/duplicity-backup/archive/stable.zip && unzip tmp.zip && rm tmp.zip

COPY . /app

ENV BACKUP_HOST mysql
ENV BACKUP_USERNAME root
ENV BACKUP_PASSWORD root

ENV BACKUP_DATABASES all

ENV BACKUP_EMAIL root

ENV BACKUP_COMPRESS bzip2

ENV BACKUP_ENCRYPT yes
ENV BACKUP_ENCRYPT_PASSWORD whatisthisidonteven

ENV MYSQL_COMPRESS_COMMUNICATION yes

RUN chmod +x /app/bin/*.sh


ENTRYPOINT ["/app/bin/boot.sh"]

CMD ["start"]
