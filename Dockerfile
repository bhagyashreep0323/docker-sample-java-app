FROM maven:3.9.9-eclipse-temurin-17

RUN apt update -y && git clone https://github.com/bhagyashreep032/docker-sample-java-webapp.git

RUN cd docker-sample-java-webapp && mvn clean package

CMD ["java", "-jar", "docker-sample-java-webapp/target/demo-0.0.1-SNAPSHOT.jar"]
