class CardModel {
  final int? id;
  String thaiWord;
  String pronunciation;
  String engWord;
  String note;
  String iconPath;
  bool isFav;

  CardModel({
    this.id,
    required this.thaiWord,
    required this.pronunciation,
    required this.engWord,
    required this.iconPath,
    this.note = "",
    this.isFav = false,
  });
  Map<String, dynamic> toMap() {
    return {'id': id, 'Thai': thaiWord, 'Pronounce': pronunciation, 'English': engWord, 'Note': note, 'Icon': iconPath, 'isFav': isFav};  
  }

  @override
  String toString() => 'Cards(id: $id, Thai: $thaiWord, Pronounce: $pronunciation, English: $engWord, Note: $note, Icon: $iconPath, isFav: $isFav)';
}
