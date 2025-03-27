# Flutter Flame Poker Game

A poker game implementation using Flutter and the Flame game engine. This project demonstrates how to build an interactive card game with modern Flutter gaming capabilities.

## Features

- Interactive poker game built with Flutter and Flame
- Card deck management system
- Game state management using Cubit
- Multiple game screens (Menu and Game screens)
- Cross-platform support

## Getting Started

### Prerequisites

- Flutter SDK (^3.5.3)
- Dart SDK
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository
```bash
git clone [repository-url]
```

2. Navigate to the project directory
```bash
cd flame_test
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the application
```bash
flutter run
```

## Project Structure

```
lib/
├── game/
│   ├── poker_game_cubit.dart    # Game state management
│   └── poker_game_state.dart
├── models/
│   ├── card.dart                # Card model
│   └── deck.dart                # Deck management
├── screens/
│   ├── game_screen.dart         # Main game screen
│   └── menu_screen.dart         # Menu screen
└── main.dart                    # Application entry point
```

## Development

This project uses:
- Flutter for the UI framework
- Flame engine for game development
- Cubit for state management

## Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flame Engine Documentation](https://docs.flame-engine.org/)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
