class AchievementModel {
  final String name;
  final String iconPath;
  final bool Function(int collectedCards, int learnedConversations) condition;
  bool isReceived;

  AchievementModel({
    required this.name,
    required this.iconPath,
    required this.condition,
    this.isReceived = false,
  });

  static List<AchievementModel> getAchievements() {
    return [
      AchievementModel(
        name: 'Collect 20 cards',
        iconPath: 'assets/achievement/card_silver.png',
        condition: (collectedCards, _) => collectedCards >= 20,
      ),
      AchievementModel(
        name: 'Collect 50 cards',
        iconPath: 'assets/achievement/card_gold.png',
        condition: (collectedCards, _) => collectedCards >= 50,
      ),
      AchievementModel(
        name: 'Collect 100 cards',
        iconPath: 'assets/achievement/card_diamond.png',
        condition: (collectedCards, _) => collectedCards >= 100,
      ),
      AchievementModel(
        name: 'Learn 20 conversations',
        iconPath: 'assets/achievement/exercise_silver.png',
        condition: (_, learnedConversations) => learnedConversations >= 20,
      ),
      AchievementModel(
        name: 'Learn 50 conversations',
        iconPath: 'assets/achievement/exercise_gold.png',
        condition: (_, learnedConversations) => learnedConversations >= 50,
      ),
      AchievementModel(
        name: 'Learn 100 conversations',
        iconPath: 'assets/achievement/exercise_diamond.png',
        condition: (_, learnedConversations) => learnedConversations >= 100,
      ),
    ];
  }
}

