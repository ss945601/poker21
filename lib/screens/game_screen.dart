import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';
import '../game/poker_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokerGame(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('21 Poker Game'),
          backgroundColor: Colors.green[800],
        ),
        body: Consumer<PokerGame>(
          builder: (context, game, child) {
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
                          'Dealer\'s Hand (${game.dealerScore})',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: game.dealerHand.map((card) {
                            return Card(
                              color: card.isFaceUp ? Colors.white : Colors.blue,
                              child: card.isFaceUp
                                  ? Container(
                                      width: 70,
                                      height: 100,
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(
                                            card.suitSymbol,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: card.color,
                                            ),
                                          ),
                                          Text(
                                            card.rank.name.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: card.color,
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
                          'Your Hand (${game.playerScore})',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: game.playerHand.map((card) {
                            return Card(
                              color: Colors.white,
                              child: Container(
                                width: 70,
                                height: 100,
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Text(
                                      card.suitSymbol,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: card.color,
                                      ),
                                    ),
                                    Text(
                                      card.rank.name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: card.color,
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
                      if (game.currentState == GameState.betting)
                        ElevatedButton(
                          onPressed: () {
                            game.startNewGame();
                            game.currentState = GameState.playerTurn;
                          },
                          child: const Text('Deal'),
                        ),
                      if (game.currentState == GameState.playerTurn) ...[                        
                        ElevatedButton(
                          onPressed: () => game.playerHit(),
                          child: const Text('Hit'),
                        ),
                        ElevatedButton(
                          onPressed: () => game.playerStand(),
                          child: const Text('Stand'),
                        ),
                      ],
                      if (game.currentState == GameState.gameOver)
                        Column(
                          children: [
                            Text(
                              game.getGameResult(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                game.startNewGame();
                                game.currentState = GameState.playerTurn;
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