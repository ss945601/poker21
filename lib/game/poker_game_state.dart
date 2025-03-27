import 'package:equatable/equatable.dart';
import '../models/card.dart';

enum GameState { betting, playerTurn, dealerTurn, gameOver }

class PokerGameState extends Equatable {
  final List<PlayingCard> playerHand;
  final List<PlayingCard> dealerHand;
  final GameState currentState;
  final int playerScore;
  final int dealerScore;
  final String? gameResult;

  const PokerGameState({
    this.playerHand = const [],
    this.dealerHand = const [],
    this.currentState = GameState.betting,
    this.playerScore = 0,
    this.dealerScore = 0,
    this.gameResult,
  });

  PokerGameState copyWith({
    List<PlayingCard>? playerHand,
    List<PlayingCard>? dealerHand,
    GameState? currentState,
    int? playerScore,
    int? dealerScore,
    String? gameResult,
  }) {
    return PokerGameState(
      playerHand: playerHand ?? this.playerHand,
      dealerHand: dealerHand ?? this.dealerHand,
      currentState: currentState ?? this.currentState,
      playerScore: playerScore ?? this.playerScore,
      dealerScore: dealerScore ?? this.dealerScore,
      gameResult: gameResult ?? this.gameResult,
    );
  }

  @override
  List<Object?> get props => [
        playerHand,
        dealerHand,
        currentState,
        playerScore,
        dealerScore,
        gameResult,
      ];
}