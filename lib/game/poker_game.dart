import 'package:flutter/material.dart';
import '../models/card.dart';
import '../models/deck.dart';

enum GameState { betting, playerTurn, dealerTurn, gameOver }

class PokerGame extends ChangeNotifier {
  final Deck deck = Deck();
  List<PlayingCard> playerHand = [];
  List<PlayingCard> dealerHand = [];
  GameState currentState = GameState.betting;
  int playerScore = 0;
  int dealerScore = 0;

  void startNewGame() {
    deck.reset();
    playerHand.clear();
    dealerHand.clear();
    currentState = GameState.betting;
    
    // Initial deal
    dealCardToPlayer();
    dealCardToDealer(faceUp: true);
    dealCardToPlayer();
    dealCardToDealer(faceUp: false);
    
    notifyListeners();
  }

  void dealCardToPlayer() {
    final card = deck.drawCard();
    if (card != null) {
      card.isFaceUp = true;
      playerHand.add(card);
      playerScore = calculateHandValue(playerHand);
      notifyListeners();
    }
  }

  void dealCardToDealer({bool faceUp = true}) {
    final card = deck.drawCard();
    if (card != null) {
      card.isFaceUp = faceUp;
      dealerHand.add(card);
      dealerScore = calculateHandValue(dealerHand);
      notifyListeners();
    }
  }

  int calculateHandValue(List<PlayingCard> hand) {
    int value = 0;
    int aces = 0;

    for (var card in hand) {
      if (card.isFaceUp) {
        if (card.rank == Rank.ace) {
          aces += 1;
        } else {
          value += card.value;
        }
      }
    }

    // Add aces
    for (int i = 0; i < aces; i++) {
      if (value + 11 <= 21) {
        value += 11;
      } else {
        value += 1;
      }
    }

    return value;
  }

  void playerHit() {
    if (currentState == GameState.playerTurn) {
      dealCardToPlayer();
      if (playerScore > 21) {
        endGame();
      }
    }
  }

  void playerStand() {
    if (currentState == GameState.playerTurn) {
      currentState = GameState.dealerTurn;
      dealerPlay();
    }
  }

  void dealerPlay() {
    // Reveal dealer's hidden card
    for (var card in dealerHand) {
      card.isFaceUp = true;
    }
    dealerScore = calculateHandValue(dealerHand);

    // Dealer must hit on 16 and stand on 17
    while (dealerScore < 17) {
      dealCardToDealer();
    }

    endGame();
  }

  void endGame() {
    currentState = GameState.gameOver;
    notifyListeners();
  }

  String getGameResult() {
    if (playerScore > 21) return 'Bust! Dealer wins!';
    if (dealerScore > 21) return 'Dealer bust! You win!';
    if (playerScore > dealerScore) return 'You win!';
    if (dealerScore > playerScore) return 'Dealer wins!';
    return 'Push - It\'s a tie!';
  }
}