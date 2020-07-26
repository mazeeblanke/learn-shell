# ------------ Database Configuration -----------
# Install and configure firewallD
sudo yum install -y firewalld
sudo service firewalld start
sudo systemctl enable firewalld


# Install and configure MariaDB
sudo yum install -y mariadb-server
# sudo vi /etc/my.cnf
sudo service mariadb start
sudo systemctl enable mariadb

# Add firewallD rules for the database
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload

# Configure database
# For mysql script we'll create a database script
cat > configure-db.sql <<-EOF
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
FLUSH PRIVILEGES;
EOF
mysql < configure-db.sql

# load inventory data into the database
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

EOF



mysql < db-load-script.sql

# ------------------- Webserver Configuration --------------
# Install apache web server and php
sudo yum install -y httpd php php-mysql

# Configure Firewall rules for webserver 
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload

sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

# Start and enable httpd service
sudo service httpd start
sudo systemctl enable httpd

# Install GIT nd download source code repository
sudo yum install -y git
git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

# Replace database ip with localhost
sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php



