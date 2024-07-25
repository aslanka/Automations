#!/bin/bash

# Update and upgrade system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y

# Start and enable Nginx service
echo "Starting and enabling Nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Certbot and obtain SSL certificate
echo "Installing Certbot..."
sudo apt install certbot python3-certbot-nginx -y

# Obtain SSL certificate using Certbot
DOMAIN="yourdomain.com"
EMAIL="your-email@example.com"

echo "Obtaining SSL certificate for $DOMAIN..."
sudo certbot --nginx -d $DOMAIN -m $EMAIL --agree-tos --no-eff-email

# Configure firewall settings
echo "Configuring firewall settings..."
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
sudo ufw allow OpenSSH
sudo ufw enable

# Set up user permissions and directories
WEB_USER="webuser"
WEB_DIR="/var/www/$DOMAIN"

echo "Creating user $WEB_USER..."
sudo adduser --disabled-login --gecos "" $WEB_USER

echo "Creating web directory $WEB_DIR..."
sudo mkdir -p $WEB_DIR
sudo chown -R $WEB_USER:$WEB_USER $WEB_DIR

# Sample HTML file
echo "<!DOCTYPE html>
<html>
<head>
    <title>Welcome to $DOMAIN!</title>
</head>
<body>
    <h1>Success! The $DOMAIN server block is working!</h1>
</body>
</html>" | sudo tee $WEB_DIR/index.html

# Nginx server block configuration
NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"
echo "Configuring Nginx for $DOMAIN..."

sudo tee $NGINX_CONF <<EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;
    root $WEB_DIR;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Enable the configuration and reload Nginx
echo "Enabling Nginx configuration..."
sudo ln -s $NGINX_CONF /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

echo "Setup complete!"
