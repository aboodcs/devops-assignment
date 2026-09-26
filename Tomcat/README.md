1) In your own words, explain what JVM means ?
A) jvm is an app thats run java app and allows them to work on different os

2) In your own words, explain what an application server is ?
A) the application server is software that runs applications and lets people access them

3) In your own words, explain what a WAR file is, how Tomcat handles it, and where it should be deployed.
A1) the war file is a web application archive and it is a folder which contains the jave web app which is ready to deploy
A2) tomcat handles the war file by putting the war file in /opt/tomcat/webapps/ then tomcat detects it then extract it and automatically deploys it so now the users can use the application


1. Download and install Tomcat as a WebApp container. Set up a reverse proxy with Nginx and connect both so that the WebApp can be accessed through a DNS name over port 80?
A) First I download and install Tomcat in `/opt/tomcat` and install Nginx

Then I open `/opt/tomcat/conf/server.xml` and find port `8080` and change it to `7070`

After that I open `/etc/nginx/sites-available/default` and add this

```nginx
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name webapp.com;

    location / {
        proxy_pass http://127.0.0.1:7070;
    }
}
```

The `server_name` is the name I use to access the WebApp

The `location /` means any request that comes to Nginx

The `proxy_pass` sends the request from Nginx to Tomcat on port `7070`

Finally I add this to `/etc/hosts`

```text
127.0.0.1 webapp.com
```

Now I can access the WebApp using `http://webapp.com` on port `80`
