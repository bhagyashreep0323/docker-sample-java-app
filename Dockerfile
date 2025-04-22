FROM maven:3.9.9-eclipse-temurin-17

RUN apt update -y && git clone https://github.com/bhagyashreep0323/docker-sample-java-app.git

RUN cd docker-sample-java-app && mvn clean package

CMD ["java", "-jar", "docker-sample-java-app/target/demo-0.0.1-SNAPSHOT.jar"]
