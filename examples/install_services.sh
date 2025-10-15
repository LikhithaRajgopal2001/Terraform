#!/bin/bash

sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h1> Terraform nginx installation shell script</h1>" | sudo tee /var/www/html/index.html