#!/bin/bash

apt update && apt install apache2 php php-mysqli php-mbstring mysql-client -y

wget -qO /var/www/html/adminer.php https://www.adminer.org/latest.php
wget -qO /var/www/html/adminer.css https://raw.githubusercontent.com/vrana/adminer/master/designs/ng9/adminer.css

sed -i 's/;extension=mysqli/extension=mysqli/' /etc/php/8.1/apache2/php.ini
sed -i 's/;extension=mbstring/extension=mbstring/' /etc/php/8.1/apache2/php.ini

sudo tee /var/www/html/index.php > /dev/null <<EOF
<?php
header("Location: /adminer.php");
exit;
?>
EOF


systemctl restart apache2

echo "Adminer installato" # --> http://192.168.56.10/auto_adminer.php."
