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
                '"lor" เหรอ Used in the context of "really?". Frequently paired with "Jing lor" or "Chai lor" which means "really?".',
          ),
        ],
      ),
    );
    tips.add(
      TipsModel(
        title: "Thai's tones",
        articles: [
          Article(
            article: '1. Thai Consonant Classes\n'
            'Consonants are divided into three classes:\nlow, middle, and high.\n'
            'The class of the first consonant in a syllable determines the tone of the syllable.\n'
            'Low-Class Consonants: \nค, ฅ, ฆ, ง, ช, ซ, ฌ, ญ, ฑ, ฒ, ณ, ท, ธ, \nน, พ, ฟ, ภ, ม, ย, ร, ล, ว, ฬ, ฮ\n'
            'Middle-Class Consonants: \nก, จ, ฎ, ฏ, ด, ต, บ, ป\n'
            'High-Class Consonants: \nข, ฃ, ฉ, ฐ, ถ, ผ, ฝ, ศ, ษ, ส\n'
            'Tip: Memorize only the middle- and high-class consonants. Anything else will be low-class.\n',
            ),
            Article(
              article: '2. Tones When No Tone Mark is Present\n'
              'When a word has no tone mark, \nuse these rules:\n'
              'If the first consonant is low-class\n'
              ' ่ (Mai Ek) = Falling tone\n'
              ' ้ (Mai Tho) = High tone\n'
              'If the first consonant is not low-class\n'
              ' ่ (Mai Ek) = Low tone\n'
              ' ้ (Mai Tho) = Falling tone\n'
              ' ๊ (Mai Tri) = High tone (Only for middle-class consonants)\n'
              ' ๋ (Mai Chattawa) = Rising tone (Only for middle-class consonants)\n',
            ),
            Article(
              article: '3. Tones When There Is No Tone Mark\n'
              'If there is no tone mark, follow these steps:\n'
              'Case 1: If the syllable is a dead syllable\n'
              'A dead syllable ends abruptly with final consonants such as ก, ด, บ \nor a short vowel (e.g., ะ).\n'
              'If the first consonant is low-class\n'
              '- Short vowel = High tone\n'
              '- Long vowel = Falling tone\n'
              'If the first consonant is middle- or high-class\n'
              '- Low tone\n'
              'Case 2: If the syllable is a live syllable\n'
              'A live syllable ends in น, ณ, ญ, ร, ล, ฬ, \nม, ง, ว, ย or a long vowel.\n'
              '- If the first consonant is high-class → Rising tone\n'
              '- If the first consonant is not high-class → Mid tone\n',
            ),
          Article(
            article:'4. Easy Tricks to Remember\n'
            '- If there is a tone mark, apply the tone mark rules first.\n'
            '- If there is no tone mark, check the consonant class.\n'
            '- If the consonant is low-class and the syllable is dead, apply the dead syllable rules.\n'
            '- If the consonant is high-class and the syllable is live, use the rising tone.\n'
            'Practice reading and pronouncing often, and it will become natural!\n',
            ),
        ],
      )
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
