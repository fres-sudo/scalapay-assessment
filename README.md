# Scalapay Assessment

Scalapay Assessment by Francesco Calicchio.

# Requirements

- FVM installed on your local machine. You can follow the [FVM installation guide](https://fvm.app/documentation/getting-started/installation) to set it up.

# Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/fres-sudo/scalapay-assessment.git
   ```
2. Navigate to the project directory:
   ```bash
   cd scalapay-assessment
   ```
3. Set up fvm:
   ```bash
   fvm install
   ```
   This will install the Flutter SDK version specified in the `.fvmrc` file.
4. Install dependencies:
   ```bash
   fvm flutter pub get
   ```
5. Generate the necessary files with build_runner:
   ```bash
   fvm dart run build_runner watch --delete-conflicting-outputs
   ```
6. Run the app:
   ```bash
   fvm flutter run
   ```
7. Run tests:
   ```bash
   fvm flutter test
   ```
