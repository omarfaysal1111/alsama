#!/bin/bash

# Clean Dart/Flutter Analysis Cache Script
# Run this from the project root directory

echo "🧹 Cleaning Dart/Flutter analysis cache..."

# Navigate to project directory
cd "$(dirname "$0")"

# Remove analysis cache
echo "Removing .dart_tool directory..."
rm -rf .dart_tool/

# Remove build directory
echo "Removing build directory..."
rm -rf build/

# Remove iOS build cache (if exists)
if [ -d "ios" ]; then
    echo "Removing iOS build cache..."
    rm -rf ios/Pods/
    rm -rf ios/.symlinks/
    rm -rf ios/Flutter/Flutter.framework
    rm -rf ios/Flutter/Flutter.podspec
fi

# Remove Android build cache
if [ -d "android" ]; then
    echo "Removing Android build cache..."
    rm -rf android/.gradle/
    rm -rf android/app/build/
    rm -rf android/build/
fi

echo "✅ Cache cleaned successfully!"
echo ""
echo "Next steps:"
echo "1. Restart your IDE (VS Code/Android Studio)"
echo "2. Restart Dart Analysis Server:"
echo "   - VS Code: Cmd+Shift+P → 'Dart: Restart Analysis Server'"
echo "   - Android Studio: File → Invalidate Caches / Restart"
echo "3. Run: flutter pub get"
echo "4. The error should be gone!"
