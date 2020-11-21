#!/bin/bash

# Variables
HTTPASSWD_USER=usuario
HTTPASSWD_PASSWD=usuario
HTTPASSWD_DIR=/home/ubuntu
IP_MYSQL_PUBLICA_BACK=34.201.50.255

# Activar depuración
set -x

# Actualizar lista de paquetes
apt update

# Actualizar los paquetes
apt upgrade -y

# Instalar apache
apt install apache2 -y


# Instalar paquetes PHP
apt install php libapache2-mod-php php-mysql -y

#---------------------------------------------------------------------------------------------------------------------------------
# Instalar herramientas adicionales

#Crear directorio de adminer
mkdir /var/www/html/adminer
cd /var/www/html/adminer
wget https://github.com/vrana/adminer/releases/download/v4.7.7/adminer-4.7.7-mysql.php
mv adminer-4.7.7-mysql.php index.php

# Instar GoAcces
echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add -
apt install goaccess -y

# Directorio de consulta de estadísticas
mkdir -p /var/www/html/stats
nohup goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html &
htpasswd -bc $HTTPASSWD_DIR/.htpasswd $HTTPASSWD_USER $HTTPASSWD_PASSWD

# Copiamos el archivo de configuración de Apache
cd /home/ubuntu
cp /home/ubuntu/000-default.conf /etc/apache2/sites-available/
systemctl restart apache2
#---------------------------------------------------------------------------------------------------------------------------------

# Instalar PHPMYADMIM

# Instalar herramienta unzip
apt install unzip -y

# Descargar codigo fuente phpMyadmin
cd/home/ubuntu
rm -rf phpMyAdmin-5.0.4-all-languages.zip
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.zip

# Descomprir el archivo
unzip phpMyAdmin-5.0.4-all-languages.zip

# Borrar el archivo comprimido
rm -rf phpMyAdmin-5.0.4-all-languages.zip

# Mover el directorio phpmyadmin
mv phpMyAdmin-5.0.4-all-languages/ /var/www/html/phpmyadmin

#Configurar config.inc.php
cd /var/www/html/phpmyadmin
mv config.sample.inc.php config.inc.php
sed -i "s/localhost/$IP_MYSQL_PUBLICA_BACK/" /var/www/html/phpmyadmin/config.inc.php

# ------------------------------------------------------------------------------
# Instalación de aplicación web
# ------------------------------------------------------------------------------

cd /var/www/html
rm -rf iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp
mv /var/www/html/iaw-practica-lamp/src/* /var/www/html/

# Configurar config.php
sed -i "s/localhost/$IP_MYSQL_PUBLICA_BACK/" /var/www/html/config.php

# Eliminar directorios innecesarios
rm -rf /var/www/html/index.html
rm -rf /var/www/html/iaw-practica-lamp
rm -rf /home/ubuntu/iaw-practica-03

# Cambiar permisos
chown www-data:www-data * -R
