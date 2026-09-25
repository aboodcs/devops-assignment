#!/bin/bash

set -e  ## this is means if any command fails stop the script immediately

echo "Updating packages..."
sudo apt-get update

echo "Installing Java 8..."
sudo apt-get install -y openjdk-8-jdk wget tar

echo "Checking Java version..."
java -version

echo "Downloading Tomcat 9..."
cd /opt

wget -q https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.122/bin/apache-tomcat-9.0.122.tar.gz

echo "Extracting Tomcat..."

tar -xzf apache-tomcat-9.0.122.tar.gz

mv apache-tomcat-9.0.122 tomcat

rm apache-tomcat-9.0.122.tar.gz

echo "Changing Tomcat port to 7070..."

sed -i 's/port="8080"/port="7070"/' /opt/tomcat/conf/server.xml

echo "Starting Tomcat..."

chmod +x /opt/tomcat/bin/*.sh

/opt/tomcat/bin/startup.sh

echo "Tomcat installation completed"
