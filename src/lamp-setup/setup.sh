

function print_green() {
    GREEN="\33[0;32m"
    NC="\033[0m"
    echo -e "${GREEN} $1 ${NC}"
}

# ------------ Database Configuration -----------
# Install and configure firewallD
echo print_green "Installing firewalld..."
sudo yum install -y firewalld
sudo service firewalld start
sudo systemctl enable firewalld


# Install and configure MariaDB
echo "Installing MariaDB..."
sudo yum install -y mariadb-server
# sudo vi /etc/my.cnf
sudo service mariadb start
sudo systemctl enable mariadb

# Add firewallD rules for the database
echo "Adding firewall rules for DB..."
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload

# Configure database
# For mysql script we'll create a database script
echo "Configuring DB..."
cat > configure-db.sql <<-EOF
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
FLUSH PRIVILEGES;
EOF
mysql < configure-db.sql

# load inventory data into the database
echo "Loading inventory data into DB..."
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

EOF



mysql < db-load-script.sql

# ------------------- Webserver Configuration --------------
# Install apache web server and php
echo "configuring web server...."
sudo yum install -y httpd php php-mysql

# Configure Firewall rules for webserver 
echo "Configuring Firewall rules for webserver...."
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload

sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

# Start and enable httpd service
echo "Starting web server..."
sudo service httpd start
sudo systemctl enable httpd

# Install GIT nd download source code repository
echo "Cloning GIT repo..."
sudo yum install -y git
git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

# Replace database ip with localhost
sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php

echo "All set."
