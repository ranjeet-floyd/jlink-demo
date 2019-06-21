FROM maven:3.6-jdk-12-alpine as build

WORKDIR /app

COPY pom.xml .

COPY src src

RUN mvn package

FROM openjdk:12-alpine

COPY --from=build /app/target/jlink-demo-1.0.0.jar  /app/target/jlink-demo.jar

ENTRYPOINT ["java","-jar"]

CMD ["/app/target/jlink-demo.jar"]

