FROM maven:3.6-jdk-12-alpine as build

WORKDIR /app

COPY pom.xml .

COPY src src

RUN mvn package && \
    jlink --add-modules com.learn.jlink \
    --module-path ${JAVA_HOME}/jmods:target/jlink-demo-1.0.0.jar \
    --output target/jlink-demo-image \
    --launcher demo=com.learn.jlink/com.learn.jlink.App

FROM alpine:3.8

COPY --from=build /app/target/jlink-demo-image /app

ENTRYPOINT ["/app/bin/demo"]


