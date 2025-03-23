class CardModel {
  String thaiWord;
  String pronunciation;
  String engWord;
  String note;
  String iconPath;
  bool isFav;

  CardModel({
    required this.thaiWord,
    required this.pronunciation,
    required this.engWord,
    required this.iconPath,
    this.note = "",
    this.isFav = false,
  });

  static List<CardModel> getCards() {
    List<CardModel> cards = [];
    cards.add(
      CardModel(
        thaiWord: 'สลัดดดดfffffffffffffffffffff',
        pronunciation: 'sa-lad',
        engWord: 'salad',
        iconPath: 'assets/picture/plate.svg',
      ),
    );
    cards.add(
      CardModel(
        thaiWord: 'เค้ก',
        pronunciation: 'cake',
        engWord: 'Cake',
        iconPath: 'assets/picture/pancakes.svg',
      ),
    );
    cards.add(
      CardModel(
        thaiWord: 'พาย',
        pronunciation: 'pie',
        engWord: 'Pie',
        iconPath: 'assets/picture/pie.svg',
      ),
    );
    cards.add(
      CardModel(
        thaiWord: 'สลัด',
        pronunciation: 'sa-lad',
        engWord: 'salad',
        iconPath: 'assets/picture/plate.svg',
      ),
    );
    cards.add(
      CardModel(
        thaiWord: 'เค้ก',
        pronunciation: 'cake',
        engWord: 'Cake',
        iconPath: 'assets/picture/pancakes.svg',
      ),
    );
    cards.add(
      CardModel(
        thaiWord: 'พาย',
        pronunciation: 'pie',
        engWord: 'Pie',
        iconPath: 'assets/picture/pie.svg',
      ),
    );

    return cards;
  }
}
