# ── STAGE 1: MAVEN BUILDER CONTAINER ──────────────────────────
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy pom.xml and fetch dependencies first (optimizes Docker caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source files and compile/package the WAR archive
COPY src ./src
RUN mvn clean package -DskipTests

# ── STAGE 2: RUNTIME TOMCAT CONTAINER ────────────────────────
FROM tomcat:10.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=builder /app/target/AuraWear.war /usr/local/tomcat/webapps/ROOT.war

# Dynamic JVM memory optimization (automatically adjusts to 75% of container RAM)
ENV CATALINA_OPTS="-XX:MaxRAMPercentage=75.0 -XX:+UseG1GC"

EXPOSE 8080
CMD ["catalina.sh", "run"]

