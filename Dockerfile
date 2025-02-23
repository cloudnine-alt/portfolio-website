# Base image with JDK
FROM openjdk:17-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy Maven wrapper and project source files
COPY .mvn/ .mvn
COPY mvnw mvnw.cmd pom.xml ./

# Grant execution permissions to the Maven wrapper
RUN chmod +x mvnw

# Copy application source code
COPY src/ src/

# Run Maven build
RUN ./mvnw package -DskipTests

# Create final image using the built JAR
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built JAR file into the final container
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port (matches `application.properties`)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
