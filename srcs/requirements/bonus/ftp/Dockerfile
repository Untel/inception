FROM    alpine
RUN     apk update
RUN     apk upgrade
RUN     apk add --no-cache vsftpd

RUN     mkdir -p /etc/vsftpd/
RUN     mkdir -p /var/www
ADD     /conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ARG     FTP_USER
ARG     FTP_PASSWORD

RUN     adduser "$FTP_USER" --disabled-password
RUN     echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
RUN     chown -R "$FTP_USER:$FTP_USER" /var/www
RUN     echo $FTP_USER | tee -a /etc/vsftpd/user_list &> /dev/null

ENTRYPOINT /usr/sbin/vsftpd
CMD /etc/vsftpd/vsftpd.conf