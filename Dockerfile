# Use OpenJDK as the base image
FROM openjdk:17-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy Maven wrapper and source code
COPY .mvn /app/.mvn
COPY mvnw pom.xml ./

# Build dependencies first (this caches them)
RUN chmod +x mvnw && ./mvnw dependency:go-offline

# Copy the rest of the app source and build it
COPY src/ src/
RUN ./mvnw package -DskipTests

# ---- Runtime Image ----
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR from the first stage
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port (default Spring Boot is 8080)
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "app.jar"]
