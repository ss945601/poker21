import 'package:flutter/material.dart';

enum Suit { hearts, diamonds, clubs, spades }
enum Rank { ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king }

class PlayingCard {
  final Suit suit;
  final Rank rank;
  bool isFaceUp;

  PlayingCard({
    required this.suit,
    required this.rank,
    this.isFaceUp = false,
  });

  int get value {
    switch (rank) {
      case Rank.ace:
        return 11; // Ace can be 1 or 11
      case Rank.jack:
      case Rank.queen:
      case Rank.king:
        return 10;
      default:
        return rank.index + 1;
    }
  }

  String get suitSymbol {
    switch (suit) {
      case Suit.hearts:
        return '♥';
      case Suit.diamonds:
        return '♦';
      case Suit.clubs:
        return '♣';
      case Suit.spades:
        return '♠';
    }
  }

  Color get color {
    return (suit == Suit.hearts || suit == Suit.diamonds)
        ? Colors.red
        : Colors.black;
  }

  String get displayRank {
    switch (rank) {
      case Rank.ace:
        return 'A';
      case Rank.jack:
        return 'J';
      case Rank.queen:
        return 'Q';
      case Rank.king:
        return 'K';
      default:
        return (rank.index + 1).toString();
    }
  }

  @override
  String toString() {
    return '${rank.name} of ${suit.name}';
  }
}