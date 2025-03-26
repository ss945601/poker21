import 'dart:math';
import 'card.dart';

class Deck {
  final List<PlayingCard> cards = [];
  final Random _random = Random();

  Deck() {
    _initializeDeck();
  }

  void _initializeDeck() {
    for (var suit in Suit.values) {
      for (var rank in Rank.values) {
        cards.add(PlayingCard(suit: suit, rank: rank));
      }
    }
  }

  void shuffle() {
    cards.shuffle(_random);
  }

  PlayingCard? drawCard() {
    if (cards.isEmpty) return null;
    return cards.removeLast();
  }

  void reset() {
    cards.clear();
    _initializeDeck();
    shuffle();
  }

  int get remainingCards => cards.length;
}