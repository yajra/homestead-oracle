#!/usr/bin/env bash

# Populate this array with each of your dev site hostnames.
sites_hosts=( homestead.app ) # array, e.g., www.example.dev

# Config for SSL.
SSL_DIR="/etc/nginx/ssl"
PASSPHRASE="secret"
SUBJ="
C=BE
ST=SomeState
O=SomeCompany
localityName=SomeCity
commonName=*.$DOMAIN
organizationalUnitName=HQ
emailAddress=some@email.com
"

echo "--- Making SSL Directory ---"
sudo mkdir -p "$SSL_DIR"

for i in "${sites_hosts[@]}"
do
    echo "--- Copying $i SSL crt and key ---"

    DOMAIN=$i

    sudo openssl genrsa -out "$SSL_DIR/$DOMAIN.key" 1024 >/dev/null 2>&1
    sudo openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key "$SSL_DIR/$DOMAIN.key" -out "$SSL_DIR/$DOMAIN.csr" -passin pass:$PASSPHRASE >/dev/null 2>&1
    sudo openssl x509 -req -days 365 -in "$SSL_DIR/$DOMAIN.csr" -signkey "$SSL_DIR/$DOMAIN.key" -out "$SSL_DIR/$DOMAIN.crt" >/dev/null 2>&1

    # Comment out this line if you prefer ssl on a per
    # server basis, rather for all sites on the vm.
    # If commented out you can access hosts on http
    # port 8000, and https port 44300. If uncommented,
    # you can ONLY access hosts via https on port 44300.
    #echo "--- Turning SSL on in nginx.conf. ---"
    #sed -i "/sendfile on;/a \\        ssl on;" /etc/nginx/nginx.conf

    echo "--- Inserting SSL directives into site's server file. ---"
    sed -i "/listen 80;/a \\\n    listen 443 ssl;\n    ssl_certificate /etc/nginx/ssl/$i.crt;\n    ssl_certificate_key /etc/nginx/ssl/$i.key;\n\n" /etc/nginx/sites-available/$i

done
echo "--- Restarting Serivces ---"
service nginx restart
service php5-fpm restart