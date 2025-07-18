# Wallet App

![Preview](wallet_app.mp4)

A sleek and interactive Flutter wallet application, designed to mimic real-world wallet UI and card interaction experience. Built with Riverpod for efficient state management, and customized animations for a smooth user interface.

## Features

- Card stack interface with swipe and tap to reorder
- Leather-style animated background
- Real-time animated transitions between screens
- Riverpod state management (without hooks)
- Card detail navigation with smooth flow animation
- Recent activity section with advanced animation handling
- Gesture-based UI elements (e.g., swipe to expand)
- Adaptive layout and scroll behavior

## Technologies Used

- Flutter
- Riverpod (state management)
- Dart Extensions for responsive design
- Custom animations with `AnimatedPositioned`, `AnimatedOpacity`, `AnimatedContainer`

## Getting Started

To run this project:

```bash
flutter pub get
flutter run
```

Ensure your Flutter environment is correctly set up. See the [official documentation](https://docs.flutter.dev/get-started/install) for help.

## Developer Notes

- Make sure all assets (backgrounds, cards) are included in `pubspec.yaml`.
- Card transitions rely on animated widgets within `Stack` and `Positioned`.
- Flutter Version I used 3.32.4
- The card stack and animated transitions are inspired by the wallet UI concept shared by [Kingsley Orji](https://www.linkedin.com/in/kingsleyorji/).
- Developed and maintained by [Hassan Al-Najjar](https://www.linkedin.com/in/hassanannajjar/).

## License

This project is proprietary and maintained by Hassan Al-Najjar.
