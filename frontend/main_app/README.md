# SaaSter Kit - Flutter Main App

A comprehensive Flutter application implementing clean architecture principles with OAuth2 authentication, BDD testing, and multi-platform publishing capabilities.

## Table of Contents

- [Clean Architecture](#clean-architecture)
- [BDD Gherkin Tests](#bdd-gherkin-tests)
- [Authentication](#authentication)
- [Publishing to Multiple Platforms](#publishing-to-multiple-platforms)

## Clean Architecture

The main_app follows Clean Architecture principles with clear separation of concerns across three main layers:

### Architecture Overview

```
lib/
├── domain/                 # Business Logic Layer
│   ├── entities/          # Core business entities
│   ├── usecases/          # Application business rules
│   └── domain_module.dart # Domain layer module
├── data/                  # Data Layer
│   ├── dto/               # Data Transfer Objects
│   ├── repository/        # Repository implementations
│   └── data_module.dart   # Data layer module
├── ui/                    # Presentation Layer
│   ├── app.dart           # Main application widget
│   ├── router.dart        # Navigation and routing
│   └── ui_module.dart     # UI layer module
└── core/                  # Infrastructure Layer
    └── di/                # Dependency Injection
        ├── authentication/
        ├── configuration/
        └── network/
```

### Key Architectural Components

#### Domain Layer
- **Entities**: Core business objects (e.g., `UserEntity`, `AnonymousEntity`, `AuthenticatedEntity`)
- **Use Cases**: Business logic operations (`LoginUser`, `GetUser`, `GetIsConnected`, `AggregateLoginIfNeeded`)
- **Interfaces**: Abstract contracts for external dependencies

#### Data Layer
- **DTOs**: Data transfer objects with JSON serialization using `freezed` and `json_annotation`
- **Repositories**: Concrete implementations of domain interfaces
- **Data Sources**: External API clients and local storage

#### Presentation Layer
- **Widgets**: UI components using the design system
- **State Management**: Flutter Bloc pattern for reactive state management
- **Navigation**: Go Router for declarative routing with authentication guards

#### Infrastructure Layer
- **Dependency Injection**: Injectable/GetIt for dependency management
- **Configuration**: Environment-specific configurations
- **Network**: HTTP clients with OAuth2 interceptors

### Dependency Injection

The app uses `injectable` and `get_it` for dependency injection:

```dart
// Configure dependencies in main.dart
configureDependencies(environment: Environment.prod);

// Access dependencies anywhere
final loginUseCase = getIt<LoginUser>();
```

Dependencies are organized by modules:
- `CoreModule`: Core infrastructure services
- `DataModule`: Data layer dependencies
- `DomainModule`: Business logic dependencies
- `UiModule`: Presentation layer dependencies

## BDD Gherkin Tests

The application implements Behavior-Driven Development (BDD) using Gherkin syntax with the `bdd_widget_test` package.

### Test Structure

```
test/
├── gherkin/
│   ├── features/
│   │   ├── login.feature      # Gherkin feature files
│   │   ├── login_test.dart    # Generated test implementations
│   │   └── step/              # Step definition implementations
│   └── steps/                 # Reusable step definitions
└── unit/                      # Traditional unit tests
```

### Gherkin Feature Example

```gherkin
Feature: Login
  Whether you are a user or an admin, you can login to the system.

  Scenario: Login page by default
    Given My app is running
    Then I should see a {ElevatedButton} with text {"Login"}

  Scenario: Logged user can see his profile
    Given My app is running
    When I connect as {'john'}
    Then I sould see text {"Welcome, John Doe"}
```

### Step Definitions

Step definitions are implemented in Dart and can be reused across features:

```dart
// Example step implementation
Future<void> myAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(UiModule());
  await tester.pumpAndSettle();
}
```

### Running BDD Tests

```bash
# Run all tests
flutter test

# Run specific feature tests
flutter test test/gherkin/features/login_test.dart

# Generate test code from Gherkin features
flutter packages pub run build_runner build
```

### Test Dependencies

Key testing packages used:
- `bdd_widget_test`: BDD testing framework for Flutter
- `flutter_test`: Flutter's testing framework
- `mockito`: Mocking framework for unit tests

## Authentication

The application implements OAuth2/OpenID Connect authentication using industry-standard protocols.

### Authentication Architecture

```
Authentication Flow:
1. User initiates login
2. Redirect to OAuth2 provider (Keycloak)
3. User authenticates with provider
4. Provider redirects back with authorization code
5. Exchange code for access/refresh tokens
6. Store tokens securely
7. Use tokens for API requests
```

### Key Components

#### Authentication Interface
```dart
abstract class Authentication {
  Interceptor get oAuthInterceptor;
  Future<void> login({Map<String, String>? queryParameters});
  Future<void> logout();
  Future<void> refreshToken();
  Future<bool> get isAuthenticated;
}
```

#### OAuth2 Implementation
The production implementation uses `dio_oidc_interceptor` for OAuth2 flows:

```dart
@prod
@Singleton(as: Authentication)
class AuthenticationImpl implements Authentication {
  late final OpenId _oAuth;

  AuthenticationImpl(Configuration configuration) {
    _oAuth = OpenId(
      configuration: OpenIdConfiguration(
        clientId: configuration.authClientId,
        clientSecret: configuration.authClientSecret,
        uri: Uri.parse(configuration.authTokenUrl),
        scopes: ['openid'],
      )
    );
  }
}
```

#### Authentication Guard
The router includes authentication guards that automatically redirect unauthenticated users:

```dart
// Router checks authentication status
StreamBuilder(
  stream: _getIsConnected.stream,
  builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data!) {
      return builder(context, state); // Show protected content
    }
    return DSButtons.primaryAppButton(
      text: "Login",
      onPressed: _loginUser.call, // Redirect to login
    );
  },
)
```

### Authentication Configuration

Configure OAuth2 settings in your environment:

```dart
// Configuration interface
abstract class Configuration {
  String get authClientId;
  String get authClientSecret;
  String get authTokenUrl;
}
```

### User Entities

The domain defines user states using sealed classes:

```dart
sealed class UserEntity {}

class AnonymousEntity extends UserEntity {}

class AuthenticatedEntity extends UserEntity {
  final String email;
  final String name;
}
```

### Authentication Dependencies

Key packages used:
- `oauth2`: OAuth2 client implementation
- `openid_client`: OpenID Connect client
- `dio_oidc_interceptor`: Dio interceptor for OAuth2
- `localstorage`: Secure token storage

## Publishing to Multiple Platforms

The Flutter main_app supports publishing to six platforms: Web, iOS, Android, Linux, Windows, and macOS.

### Platform Support Matrix

| Platform | Status | Build Command | Output |
|----------|--------|---------------|---------|
| Web | ✅ Ready | `flutter build web` | `build/web/` |
| iOS | ✅ Ready | `flutter build ios` | `.app` bundle |
| Android | ✅ Ready | `flutter build apk` | `.apk` file |
| Linux | ✅ Ready | `flutter build linux` | Binary executable |
| Windows | ✅ Ready | `flutter build windows` | `.exe` executable |
| macOS | ✅ Ready | `flutter build macos` | `.app` bundle |

### Web Publishing

#### Build for Web
```bash
# Development build
flutter build web

# Production build with optimizations
flutter build web --release --web-renderer html

# Build with custom base href
flutter build web --base-href /app/
```

#### Web Configuration
- **Entry Point**: `web/index.html`
- **App Title**: "SaaSter Kit"
- **PWA Support**: Configured via `web/manifest.json`
- **Icons**: Responsive icons in `web/icons/`

#### Deployment Options
- **Static Hosting**: Deploy `build/web/` to any static host
- **CDN**: Use with CloudFront, CloudFlare, etc.
- **Docker**: Use provided Nginx configuration

### iOS Publishing

#### Prerequisites
- macOS development machine
- Xcode 14.0 or later
- Apple Developer Account
- iOS deployment target: iOS 12.0+

#### Build for iOS
```bash
# Debug build for simulator
flutter build ios --debug --simulator

# Release build for device
flutter build ios --release

# Build for App Store
flutter build ipa --release
```

#### iOS Configuration
- **Bundle ID**: Configured in `ios/Runner/Info.plist`
- **Display Name**: "Saaster"
- **Supported Orientations**: Portrait, Landscape
- **Minimum iOS Version**: 12.0

#### App Store Deployment
1. Archive in Xcode: `Product > Archive`
2. Upload to App Store Connect
3. Submit for review

### Android Publishing

#### Prerequisites
- Android SDK 21+ (Android 5.0)
- Java 11 or later
- Android signing key

#### Build for Android
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

#### Android Configuration
- **Package Name**: `com.example.saaster`
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: Latest stable
- **Permissions**: Configured in `android/app/src/main/AndroidManifest.xml`

#### Play Store Deployment
1. Generate signed bundle: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Submit for review

### Linux Publishing

#### Prerequisites
- Linux development environment
- CMake 3.13+
- GTK 3.0 development libraries
- Ninja build system

#### Build for Linux
```bash
# Install dependencies (Ubuntu/Debian)
sudo apt-get install cmake ninja-build libgtk-3-dev

# Build application
flutter build linux --release
```

#### Linux Configuration
- **Binary Name**: "saaster"
- **Application ID**: "com.example.saaster"
- **GTK Version**: 3.0+
- **Output**: `build/linux/x64/release/bundle/`

#### Distribution Options
- **AppImage**: Package as portable AppImage
- **Snap**: Publish to Snap Store
- **Flatpak**: Package for Flathub
- **DEB/RPM**: Create distribution packages

### Windows Publishing

#### Prerequisites
- Windows 10 or later
- Visual Studio 2019 or later with C++ tools
- CMake 3.14+

#### Build for Windows
```bash
# Build application
flutter build windows --release
```

#### Windows Configuration
- **Binary Name**: "saaster.exe"
- **Target Platform**: x64
- **Minimum Windows**: Windows 10
- **Output**: `build/windows/x64/runner/Release/`

#### Distribution Options
- **MSIX**: Package for Microsoft Store
- **Installer**: Create setup executable
- **Portable**: Distribute as ZIP archive

### macOS Publishing

#### Prerequisites
- macOS 10.14 or later
- Xcode 12.0 or later
- Apple Developer Account (for distribution)

#### Build for macOS
```bash
# Debug build
flutter build macos --debug

# Release build
flutter build macos --release
```

#### macOS Configuration
- **Bundle ID**: Configured in `macos/Runner/Info.plist`
- **Minimum macOS**: 10.14
- **App Sandbox**: Configured for App Store
- **Output**: `build/macos/Build/Products/Release/`

#### App Store Deployment
1. Archive in Xcode
2. Upload to App Store Connect
3. Submit for review

### Universal Build Script

Create a build script for all platforms:

```bash
#!/bin/bash
# build_all.sh

echo "Building for all platforms..."

# Web
echo "Building Web..."
flutter build web --release

# Mobile platforms (requires respective SDKs)
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Building iOS..."
  flutter build ios --release
  
  echo "Building macOS..."
  flutter build macos --release
fi

# Desktop platforms
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "Building Linux..."
  flutter build linux --release
fi

if [[ "$OSTYPE" == "msys" ]]; then
  echo "Building Windows..."
  flutter build windows --release
fi

# Android (available on all platforms)
echo "Building Android..."
flutter build apk --release

echo "Build complete!"
```

### Platform-Specific Considerations

#### Performance Optimization
- **Web**: Use `--web-renderer html` for better compatibility
- **Mobile**: Enable R8/ProGuard for Android, bitcode for iOS
- **Desktop**: Use release builds for optimal performance

#### Platform Features
- **Web**: PWA capabilities, responsive design
- **Mobile**: Native platform integrations, app store features
- **Desktop**: File system access, native menus

#### Testing Strategy
- **Web**: Test across browsers (Chrome, Firefox, Safari, Edge)
- **Mobile**: Test on physical devices and simulators
- **Desktop**: Test on different OS versions and screen sizes

### Continuous Integration

Example GitHub Actions workflow for multi-platform builds:

```yaml
name: Build All Platforms
on: [push, pull_request]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
    
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.7.2'
    
    - name: Install dependencies
      run: flutter pub get
      working-directory: frontend/main_app
    
    - name: Build for platform
      run: |
        if [[ "$RUNNER_OS" == "Linux" ]]; then
          sudo apt-get install -y libgtk-3-dev
          flutter build linux --release
          flutter build web --release
        elif [[ "$RUNNER_OS" == "macOS" ]]; then
          flutter build ios --release --no-codesign
          flutter build macos --release
        elif [[ "$RUNNER_OS" == "Windows" ]]; then
          flutter build windows --release
        fi
      working-directory: frontend/main_app
```

## Development Setup

### Prerequisites
- Flutter SDK 3.7.2+
- Dart SDK 3.7.2+
- Platform-specific SDKs (as needed)

### Installation
```bash
# Clone repository
git clone https://github.com/b-fontaine/saaster_kit.git
cd saaster_kit/frontend/main_app

# Install dependencies
flutter pub get

# Generate code
flutter packages pub run build_runner build

# Run application
flutter run
```

### Development Commands
```bash
# Run tests
flutter test

# Run with hot reload
flutter run

# Analyze code
flutter analyze

# Format code
dart format .

# Generate code
flutter packages pub run build_runner build --delete-conflicting-outputs
```
