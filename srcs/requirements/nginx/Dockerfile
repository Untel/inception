FROM        alpine
RUN         apk update
RUN         apk add nginx openssl
RUN         adduser -D -g 'www' www
RUN         chown -R www:www /var/lib/nginx
RUN         chown -R www:www /var/www
COPY        /conf/nginx.conf /etc/nginx/nginx.conf

RUN         openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
                -out /etc/ssl/certs/adda-sil.42.fr.cert \
                -keyout /etc/ssl/certs/adda-sil.42.fr.key \
                -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=adda-sil/CN=adda-sil.42.fr/distinguished_name=dn/subjectAltName=DNS:adda-sil.42.fr/keyUsage=digitalSignature/extendedKeyUsage=serverAuth"

ENTRYPOINT  nginx -g 'daemon off;'