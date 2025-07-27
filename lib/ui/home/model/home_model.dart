import 'dart:math';

class CardModel {
  final String assetPath;

  CardModel({required this.assetPath});
}

class CardListModel {
  static final List<CardModel> cards = [
    CardModel(assetPath: 'assets/images/mapa_escom.png'),
  ];
}

final random = Random();
final randomCard =
    CardListModel.cards[random.nextInt(CardListModel.cards.length)];
