import 'dart:ui';

class TipsModel {
  String title;
  List<Article> articles;

  TipsModel({required this.title, required this.articles});

  static List<TipsModel> getTips() {
    List<TipsModel> tips = [];
    tips.add(
      TipsModel(
        title: "What is Krup(ครับ) and Ka(ค่ะ)",
        articles: [
          Article(
            article:
                '"Krup"/ "ครับ" Also spelled as "kup", is a polite ending particle for males. '
                'It is used in both questions and normal sentences. It is usually pronounced the same as the English word “cup.”',
          ),
          Article(
            article:
                '"Ka" / "คะ" / "ค่ะ" Also spelled as "kha", is a polite ending particle for females. In normal sentences, it has a falling tone (written as khâ / ค่ะ), and in questions, it has a high tone (written as khá / คะ).',
          ),
          Article(
            article:
                'Sometimes, when Thai people answer a question with krub or ka, it can mean "yes" or indicate agreement with the question.',
          ),
        ],
      ),
    );
    tips.add(
      TipsModel(
        title: "Ending particles in Thai",
        articles: [
          Article(
            article:
                '"na" นะ used to soften your sentence and make it sound more friendly. "na" can be used for both formal and informal context. It can be use along with "ka" or "krup" for example, you can say "khoop khun na ka" or "khop khun na".e',
          ),
          Article(
            article:
                '"ja" จ่ะ Used in a less formal context, when speaking to friends or someone younger than yourself',
          ),
          Article(
            article:
                '"lor" เหรอ Used in the context of "really?". Frequently paired with "Jing lor" or "Chai lor" which means "really?".',
          ),
        ],
      ),
    );
    tips.add(
      TipsModel(
        title: "Tips and Tricks",
        articles: [Article(article: 'article test1')],
      ),
    );
    tips.add(
      TipsModel(
        title: "Tips and Tricks",
        articles: [Article(article: 'article test2')],
      ),
    );
    tips.add(
      TipsModel(
        title: "Tips and Tricks",
        articles: [Article(article: 'article test3')],
      ),
    );
    tips.add(
      TipsModel(
        title: "Tips and Tricks",
        articles: [Article(article: 'article test4')],
      ),
    );

    return tips;
  }
}

class Article {
  final String article;

  Article({required this.article});
}
