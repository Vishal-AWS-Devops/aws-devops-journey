#!/bin/bash
# Navigate to repo
cd ~/aws-devops-journey

# Fetch latest changes from the branch that triggered the webhook
git fetch origin
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
git reset --hard origin/$BRANCH_NAME

# Deploy files to web server
cp -r ~/aws-devops-journey/* /var/www/html/

# Restart Apache
sudo systemctl restart httpd

echo "Deployment from branch $BRANCH_NAME completed."
