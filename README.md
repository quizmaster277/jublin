# 🛡️ Jublin - APK Safety Scanner & Modifier

> **Open-source, offline-first APK security scanner and modifier for Windows and Android**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![JavaFX](https://img.shields.io/badge/JavaFX-21-blue.svg)](https://openjfx.io/)
[![Maven](https://img.shields.io/badge/Maven-3.9+-red.svg)](https://maven.apache.org/)
[![Build Status](https://github.com/quizmaster277/jublin/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/quizmaster277/jublin/actions)

## 🎯 Features

- **🔍 Security Scanner** - Analyzes APK structure using `ZipInputStream` without executing any binary payloads
- **🔐 Hash Verification** - SHA-256 fingerprint matching against local malicious signature database
- **📋 Permission Inspector** - Decompiles `AndroidManifest.xml` to flag dangerous permissions
- **🔧 Tweak Engine** - Strips dangerous permissions and repackages APK safely
- **✍️ Auto-Signer** - Signs modified APKs with test certificates for deployment
- **🖥️ Modern UI** - Drag-and-drop JavaFX interface with real-time progress
- **🐳 Docker Ready** - Multi-stage builds for development and production
- **📦 Offline-First** - No internet required, completely local processing

## 🏗️ Architecture

```
┌────────────────────────────────────────────────────────┐
│             User Interface (JavaFX)                    │
│   Drag & Drop APK Box / File Explorer                  │
└───────────────────────────┬────────────────────────────┘
                            │ (Direct Method Invocations)
                            ▼
┌────────────────────────────────────────────────────────┐
│             Pure Java Scanner & Modifier Engine        │
│  • ZipInputStream (Extractor)   • SHA-256 Hash Matcher │
│  • XML Manifest Parser         • Automated Auto-Signer │
└────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- **JDK 21+** (Eclipse Temurin recommended)
- **Maven 3.9+**
- **Git**

### Build & Run Locally

```bash
# Clone the repository
git clone https://github.com/quizmaster277/jublin.git
cd jublin

# Build with Maven
mvn clean package

# Run the application
java --enable-native-access=ALL-UNNAMED -jar target/jublin-1.0.0-SNAPSHOT.jar
```

### Run with Docker

```bash
# Development environment
docker-compose up jublin-dev

# Build the application
docker-compose up jublin-build

# Run tests
docker-compose up jublin-test

# Run the built application (headless)
docker-compose up jublin-run
```

### Using the Application

1. **Launch Jublin** - The main window opens with a drag-and-drop zone
2. **Drop an APK** - Drag any `.apk` file onto the drop zone or click to browse
3. **Scan** - Click "🔍 Scan APK" to analyze the file
4. **Review Results** - View suspicious files, dangerous permissions, and hash status
5. **Modify** - Click "🔧 Modify & Sign" to create a safer version
6. **Save** - Choose where to save the modified APK

## 📁 Project Structure

```
jublin/
├── src/
│   ├── main/
│   │   ├── java/com/jublin/
│   │   │   ├── Main.java                 # Entry point
│   │   │   ├── model/                    # Data models
│   │   │   │   └── ScanResult.java
│   │   │   ├── scanner/                  # Scanning engine
│   │   │   │   ├── ApkScanner.java       # Core APK scanner
│   │   │   │   └── HashMatcher.java      # SHA-256 signature matching
│   │   │   ├── modifier/                 # APK modification
│   │   │   │   └── ApkModifier.java      # Permission stripper & repackager
│   │   │   └── ui/                       # JavaFX UI
│   │   │       └── MainWindow.java       # Main application window
│   │   └── resources/
│   │       ├── styles.css                # JavaFX styling
│   │       ├── logback.xml               # Logging configuration
│   │       └── signatures/
│   │           └── malicious.txt         # Malicious hash database
│   └── test/                             # Unit tests
├── pom.xml                               # Maven configuration
├── Dockerfile                            # Multi-stage Docker build
├── docker-compose.yml                    # Docker services
├── .github/workflows/ci.yml              # CI/CD pipeline
└── LICENSE                               # MIT License
```

## 🔧 Configuration

### Adding Custom Malicious Signatures

Create a text file with one SHA-256 hash per line (64 hex characters):

```text
# my-signatures.txt
abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890
1111111111111111111111111111111111111111111111111111111111111111
```

Load it programmatically:
```java
HashMatcher matcher = new HashMatcher("path/to/my-signatures.txt");
```

### Customizing Permissions to Strip

```java
Set<String> customPermissions = Set.of(
    "android.permission.CAMERA",
    "android.permission.RECORD_AUDIO",
    "android.permission.ACCESS_FINE_LOCATION"
);
ApkModifier modifier = new ApkModifier(customPermissions);
```

## 🧪 Testing

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=ApkScannerTest

# Run with coverage
mvn test jacoco:report
```

## 📦 Building for Distribution

```bash
# Create fat JAR with all dependencies
mvn clean package

# The runnable JAR will be at:
# target/jublin-1.0.0-SNAPSHOT.jar
```

## 🐳 Docker Images

### Development Image
```bash
docker build --target dev -t jublin-dev .
docker run -it -v $(pwd):/app jublin-dev
```

### Production Runtime Image
```bash
docker build --target runtime -t jublin .
docker run -v /path/to/apks:/app/input -v /path/to/output:/app/output jublin
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow existing code style
- Add tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **JavaFX** - Modern UI toolkit for Java
- **SLF4J + Logback** - Logging framework
- **JUnit 5 + AssertJ** - Testing frameworks
- **Maven** - Build automation
- **Docker** - Containerization

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/quizmaster277/jublin/issues)
- **Discussions**: [GitHub Discussions](https://github.com/quizmaster277/jublin/discussions)
- **Security**: Report vulnerabilities privately via GitHub Security Advisories

---

**Made with ❤️ for the open-source community**

*Jublin - Keeping your APKs safe, one scan at a time.*
