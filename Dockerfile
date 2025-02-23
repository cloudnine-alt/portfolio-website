# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY target/portfolio-website-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080 (or your configured port)
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
