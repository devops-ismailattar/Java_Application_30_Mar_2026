FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

RUN mvn -B clean install

#RUNTIME STAGE

FROM eclipse-temurin:17-jre-jammy

COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar ./app.jar
COPY --from=builder /app/src ./src

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
