#!/bin/bash

# Navigate to the directory where your application is deployed
cd /home/ec2-user/deploy

# Stop the currently running Spring Boot application (if any)
echo "Stopping the existing Spring Boot application..."
sudo pkill -f 'java -jar springboot-hello-world.jar'

# Start the new Spring Boot application
echo "Starting the new Spring Boot application..."
nohup java -jar springboot-hello-world.jar > /home/ec2-user/deploy/app.log 2>&1 &

# Optionally, monitor the application log for errors or issues
tail -f /home/ec2-user/deploy/app.log

echo "Deployment completed successfully!"
