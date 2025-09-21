# Flutter API Assessment

## Overview
 Flutter app that fetches posts from JSONPlaceholder and displays them.
- Networking: **Dio**
- State Management: **flutter_bloc**
- Material 3 + simple theme
- Clean-ish architecture (data / domain / presentation)
- Unit + Widget tests included

## How to run
1. Clone:
   ```bash
   git clone https://github.com/clyclycc/flutter_api_assessment.git
   cd flutter_api_assessment
2. Install dependencies:

flutter pub get


3. Run on device/emulator:

flutter run

## Networking library used

dio (https://pub.dev/packages/dio)

## State management used

flutter_bloc (https://pub.dev/packages/flutter_bloc)

## Tests

Run all tests:

flutter test


Unit test example: test/unit/post_repository_test.dart

Widget test example: test/widget/posts_screen_test.dart



This project is a starting point for a Flutter application.
Notes

The remote data source uses https://jsonplaceholder.typicode.com/posts.

Error handling displays an error message & retry button.


---

# Git Operation（push to GitHub）
```bash
git init
git add .
git commit -m "Initial: Flutter API assessment app with Dio + flutter_bloc, tests"
git remote add origin https://github.com/clyclycc/flutter_api_assessment.git
git branch -M main
git push -u origin main