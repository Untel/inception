FROM    alpine
RUN     apk update
RUN     apk upgrade
RUN     apk add --no-cache vsftpd

RUN     mkdir -p /etc/vsftpd/
ADD    /conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ARG     FTP_USER
ARG     FTP_PASSWORD

RUN     adduser $FTP_USR --disabled-password
RUN     echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
RUN     chown -R $FTP_USR:$FTP_USR /var/www
RUN     echo $FTP_USR | tee -a /etc/vsftpd.userlist &> /dev/null

ENTRYPOINT /usr/sbin/vsftpd
CMD /etc/vsftpd/vsftpd.conf