import 'package:flutter/material.dart';
import 'game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.greenAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '21 Poker',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                child: const Text('New Game'),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Game Rules'),
                      content: const Text(
                        'Try to get as close to 21 as possible without going over.\n\n'
                        '- Numbered cards are worth their face value\n'
                        '- Face cards (J, Q, K) are worth 10\n'
                        '- Aces are worth 11 or 1\n\n'
                        'You can either "Hit" to take another card or "Stand" to keep your current hand.\n\n'
                        'The dealer must hit on 16 and stand on 17.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Rules'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}