#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
echo "<h1>Deployed via mazon</h1>" | sudo tee /var/www/html/index.html