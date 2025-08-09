#!/bin/bash
# Update package index
yum update -y

# Install Apache (httpd)
yum install -y httpd

# Enable and start the service
systemctl enable httpd
systemctl start httpd

# Add a simple HTML page
echo "<html><h1>Hello from Apache Web Server!</h1></html>" > /var/www/html/index.html
