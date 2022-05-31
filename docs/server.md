SERVER
============

Il server `ubu2004board-datawarehousing-170` è stato configurato anche per poter servire delle applicazioni `nodejs`
attraverso il servizio npm `pm2`.

E' stato installato anche `nvm` da root per gestire le varie versioni di `node`.

```bash

$  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

$ nvm install lts/erbium
$ nvm install lts/fermium
$ nvm install lts/gallium
$ npm install pm2 -g

$ cd /home/vhosts/free-code-camp-is.obdem.eu/current/
$ pm2 start myApp.js --name "information-security-helmet-js" --watch
$ pm2 startup
$ pm2 save

$ a2enmod proxy proxy_http rewrite headers expires
$ a2ensite free-code-camp-is.obdem.eu.conf

$ service apache2 restart

```

configurazione minima di apache2:
```text

<VirtualHost *:80>
    ServerAdmin postmaster@free-code-camp-is.obdem.eu
    ServerName free-code-camp-is.obdem.eu

  <Directory />
      Options FollowSymLinks
      AllowOverride None
  </Directory>


    ErrorLog /home/logs/free-code-camp-is.obdem.eu-errors-prod.log
    CustomLog /home/logs/free-code-camp-is.obdem.eu-access-prod.log combined

### AB: parte per servire roba che gira su nodejs e che risponde sulla porta 3000
    ProxyRequests Off
    ProxyPreserveHost On
    ProxyVia Full

    <Proxy *>
        Require all granted
    </Proxy>

    ProxyPass / http://127.0.0.1:3000/
    ProxyPassReverse / http://127.0.0.1:30000/



</VirtualHost>


```