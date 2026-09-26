### 1. Read about Docker: what it is, use cases, and basic commands

Docker is a tool that lets us run applications inside containers

We use Docker to run applications in an isolated environment and make them easy to move and run on different machines

Some basic Docker commands are

```bash
docker ps -a

docker push 

docker images

docker run

docker ps

docker stop

docker start

docker rm

docker logs

docker exec
```

### 2. Create a Dockerfile for a Tomcat Docker image, deploy a sample WAR in it, and push it to a Docker registry

I use the image `tomcat:9.0.122-jdk21-temurin-noble` and I use this sample WAR. I want to run the sample WAR in a Tomcat Docker container and place it in `/usr/local/tomcat/webapps/`, with Tomcat running on port `8080`

The Dockerfile is

```dockerfile
FROM tomcat:9.0.122-jdk21-temurin-noble

COPY sample.war /usr/local/tomcat/webapps/
```

Then I build the Docker image

```bash
docker build -t my-tomcat .
```

Then I run the container on port `8080`

```bash
docker run -d -p 8080:8080 --name tomcat my-tomcat
```

Then I push the image to a Docker registry

```bash
docker push aboodcs/my-tomcat
```

### 3. The commands to run Nginx and PostgreSQL are

#### Nginx

```bash
docker run -d -p 8081:80 nginx
```

#### PostgreSQL

```bash
docker run -d -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=1234 postgres
```
