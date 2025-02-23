# Set working directory
WORKDIR /app

# Copy the Maven wrapper and project source files
COPY .mvn/ /app/.mvn/
COPY mvnw mvnw.cmd pom.xml /app/

# Grant execution permissions to the Maven wrapper
RUN chmod +x /app/mvnw

# Copy the application source code
COPY src/ /app/src/

# Run Maven build
RUN /app/mvnw package -DskipTests

# Copy the built JAR file into the final container
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port (make sure this matches your `application.properties` file)
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
