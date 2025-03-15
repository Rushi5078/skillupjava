# Use an official OpenJDK image as the base
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
# Replace 'your-application-name.jar' with the actual JAR file name or use a wildcard if you have only one JAR
COPY target/skillupjava-1.0.jar app.jar

# Expose the application port (can be updated based on the environment or configuration)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
