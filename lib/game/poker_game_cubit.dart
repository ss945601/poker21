import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/card.dart';
import '../models/deck.dart';
import 'poker_game_state.dart';

class PokerGameCubit extends Cubit<PokerGameState> {
  final Deck deck = Deck();

  PokerGameCubit() : super(const PokerGameState());

  void startNewGame() {
    deck.reset();
    emit(const PokerGameState());
    
    // Initial deal
    dealCardToPlayer();
    dealCardToDealer(faceUp: true);
    dealCardToPlayer();
    dealCardToDealer(faceUp: false);
    
    emit(state.copyWith(currentState: GameState.playerTurn));
  }

  void dealCardToPlayer() {
    final card = deck.drawCard();
    if (card != null) {
      card.isFaceUp = true;
      final newHand = List<PlayingCard>.from(state.playerHand)..add(card);
      emit(state.copyWith(
        playerHand: newHand,
        playerScore: calculateHandValue(newHand),
      ));
    }
  }

  void dealCardToDealer({bool faceUp = true}) {
    final card = deck.drawCard();
    if (card != null) {
      card.isFaceUp = faceUp;
      final newHand = List<PlayingCard>.from(state.dealerHand)..add(card);
      emit(state.copyWith(
        dealerHand: newHand,
        dealerScore: calculateHandValue(newHand),
      ));
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
    if (state.currentState == GameState.playerTurn) {
      dealCardToPlayer();
      if (state.playerScore > 21) {
        endGame();
      }
    }
  }

  void playerStand() {
    if (state.currentState == GameState.playerTurn) {
      emit(state.copyWith(currentState: GameState.dealerTurn));
      dealerPlay();
    }
  }

  void dealerPlay() {
    // Reveal dealer's hidden card
    final revealedHand = state.dealerHand.map((card) {
      card.isFaceUp = true;
      return card;
    }).toList();

    emit(state.copyWith(
      dealerHand: revealedHand,
      dealerScore: calculateHandValue(revealedHand),
    ));

    // Dealer must hit on 16 and stand on 17
    while (state.dealerScore < 17) {
      dealCardToDealer();
    }

    endGame();
  }

  void endGame() {
    final result = getGameResult();
    emit(state.copyWith(
      currentState: GameState.gameOver,
      gameResult: result,
    ));
  }

  String getGameResult() {
    if (state.playerScore > 21) return 'Bust! Dealer wins!';
    if (state.dealerScore > 21) return 'Dealer bust! You win!';
    if (state.playerScore > state.dealerScore) return 'You win!';
    if (state.dealerScore > state.playerScore) return 'Dealer wins!';
    return 'Push - It\'s a tie!';
  }
}