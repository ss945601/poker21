import 'package:flame_test/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/game.dart';
import '../game/poker_game_cubit.dart';
import '../game/poker_game_state.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokerGameCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
          ),
          title: const Text('21 Poker Game'),
          backgroundColor: Colors.green[800],
        ),
        body: BlocBuilder<PokerGameCubit, PokerGameState>(
          builder: (context, state) {
            return Column(
              children: [
                // Dealer's cards
                Expanded(
                  child: Container(
                    color: Colors.green[600],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dealer\'s Hand (${state.dealerScore})',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: state.dealerHand.map((card) {
                            return Card(
                              color: card.isFaceUp ? Colors.white : Colors.blue,
                              child: card.isFaceUp
                                  ? Container(
                                      width: 70,
                                      height: 100,
                                      padding: const EdgeInsets.all(8),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Text(
                                              card.suitSymbol,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: card.color,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              card.displayRank,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: card.color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 70,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Player's cards
                Expanded(
                  child: Container(
                    color: Colors.green[700],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Hand (${state.playerScore})',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: state.playerHand.map((card) {
                            return Card(
                              color: Colors.white,
                              child: Container(
                                width: 70,
                                height: 100,
                                padding: const EdgeInsets.all(8),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Text(
                                        card.suitSymbol,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: card.color,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        card.displayRank,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: card.color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Game controls
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.green[800],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (state.currentState == GameState.betting)
                        ElevatedButton(
                          onPressed: () {
                            context.read<PokerGameCubit>().startNewGame();
                          },
                          child: const Text('Deal'),
                        ),
                      if (state.currentState == GameState.playerTurn) ...[                        
                        ElevatedButton(
                          onPressed: () => context.read<PokerGameCubit>().playerHit(),
                          child: const Text('Hit'),
                        ),
                        ElevatedButton(
                          onPressed: () => context.read<PokerGameCubit>().playerStand(),
                          child: const Text('Stand'),
                        ),
                      ],
                      if (state.currentState == GameState.gameOver)
                        Column(
                          children: [
                            Text(
                              state.gameResult!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<PokerGameCubit>().startNewGame();
                              },
                              child: const Text('Play Again'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}