#!/bin/bash

set -e  ## this is means if any command fails stop the script immediately

echo "updating packages"
sudo apt-get update

echo "installing java"
sudo apt-get install -y openjdk-8-jdk wget tar

echo "checking java version"
java -version

echo "downloading tomcat"
cd /opt

wget -q https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.122/bin/apache-tomcat-9.0.122.tar.gz

echo "extracting tomcat"

tar -xzf apache-tomcat-9.0.122.tar.gz

mv apache-tomcat-9.0.122 tomcat

rm apache-tomcat-9.0.122.tar.gz

echo "changing tomcat port to 7070"

sed -i 's/port="8080"/port="7070"/' /opt/tomcat/conf/server.xml

echo "starting tomcat"

chmod +x /opt/tomcat/bin/*.sh

/opt/tomcat/bin/startup.sh

echo "tomcat installation completed"
