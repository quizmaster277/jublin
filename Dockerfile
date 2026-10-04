# Jublin - APK Safety Scanner & Modifier
# Multi-stage Docker build for development and production

# ============================================
# Stage 1: Build Environment (Maven + JDK 21)
# ============================================
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy pom.xml first for dependency caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests -B

# ============================================
# Stage 2: Runtime Environment (JRE 21 + JavaFX)
# ============================================
FROM eclipse-temurin:21-jre-jammy AS runtime

# Install JavaFX dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 \
    libgtk-3-0 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libxrandr2 \
    libxxf86vm1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libpulse0 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the built JAR from builder stage
COPY --from=builder /app/target/jublin-1.0.0-SNAPSHOT.jar ./jublin.jar

# Create non-root user
RUN groupadd -r jublin && useradd -r -g jublin jublin
RUN chown -R jublin:jublin /app
USER jublin

# Expose port (if needed for future web UI)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "--enable-native-access=ALL-UNNAMED", "-jar", "jublin.jar"]

# ============================================
# Stage 3: Development Environment
# ============================================
FROM maven:3.9.6-eclipse-temurin-21 AS dev

WORKDIR /app

# Install development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    vim \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pom.xml .
COPY src ./src

# Pre-download dependencies
RUN mvn dependency:go-offline -B

# Default command starts a shell for development
CMD ["bash"]