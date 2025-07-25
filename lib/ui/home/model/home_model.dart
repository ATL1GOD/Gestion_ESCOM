import 'dart:math';

class CardModel {
  final String assetPath;

  CardModel({required this.assetPath});
}

class CardListModel {
  static final List<CardModel> cards = [
    CardModel(assetPath: 'assets/images/escom1.png'),
    CardModel(assetPath: 'assets/images/escom2.png'),
    CardModel(assetPath: 'assets/images/escom3.png'),
  ];
}

final random = Random();
final randomCard =
    CardListModel.cards[random.nextInt(CardListModel.cards.length)];
