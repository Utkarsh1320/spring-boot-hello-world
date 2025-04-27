#!/bin/bash
# Kill any old app running
pkill -f 'java -jar' || true

# Go to the directory
cd /home/ec2-user

# Start new app
nohup java -jar *.jar > /dev/null 2> /dev/null < /dev/null &
