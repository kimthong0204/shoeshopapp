# Stage 1: Build ứng dụng bằng Maven
FROM maven:3.8.6-eclipse-temurin-17 AS builder

# Đặt thư mục làm việc trong container
WORKDIR /app

# Sao chép file pom.xml và source code
COPY pom.xml .
COPY src ./src

# Build ứng dụng, tạo file JAR
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng bằng Eclipse Temurin JDK 17
FROM eclipse-temurin:17-jdk-jammy

# Đặt thư mục làm việc trong container
WORKDIR /app

# Sao chép file JAR từ stage builder
COPY --from=builder /app/target/*.jar app.jar

# Mở port 8080 (port mặc định của Spring Boot)
EXPOSE 8080

# Lệnh chạy ứng dụng Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
