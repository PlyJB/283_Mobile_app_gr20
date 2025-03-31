class ConvoModel {
  String title;
  List<Article> articles;

  ConvoModel({required this.title, required this.articles});
  static List<ConvoModel> getConvo() {
    List<ConvoModel> convos = [];
    convos.add(
      ConvoModel(
        title: "Greetings",
        articles: [
          Article(thai: "สวัสดี", english: "Hello", pheonetic: "sawasdee"),
          Article(
            thai: "เป็นไงบ้าง",
            english: "How are you?",
            pheonetic: "pen ngai bang",
          ),
          Article(
            thai: "สบายดีไหม",
            english: "Are you well?",
            pheonetic: "sabai dee mai",
          ),
          Article(
            thai: "ฉันสบายดี",
            english: "i'm fine",
            pheonetic: "chan sabai dee",
          ),
          Article(
            thai: "แล้วเจอกันใหม่",
            english: "See you again",
            pheonetic: "laew jer kan mai",
          ),
        ],
      ),
    );
    convos.add(
      ConvoModel(
        title: "Food ordering",
        articles: [
          Article(
            thai: "เอา(...)",
            english: "I want (...)",
            pheonetic: "ao (...)",
          ),
          Article(
            thai: "เอาผัดไทย",
            english: "I want pad thai",
            pheonetic: "ao pad thai",
          ),
          Article(
            thai: "เอาแบบไม่เผ็ด",
            english: "I want it not spicy",
            pheonetic: "ao baeb mai phed",
          ),
          Article(
            thai: "มี(...)ไหม",
            english: "Do you have (...)",
            pheonetic: "mee (...) mai",
          ),
          Article(
            thai: "มีผัดกระเพราไหม",
            english: "Do you have pad kra pao?",
            pheonetic: "mee pad kra pao mai",
          ),
        ],
      ),
    );
    convos.add(
      ConvoModel(
        title: "Shopping",
        articles: [
          Article(
            thai: "ราคาเท่าไหร่",
            english: "How much is it?",
            pheonetic: "rakha thao rai",
          ),
          Article(
            thai: "แพงไปไหม",
            english: "Is it expensive?",
            pheonetic: "paeng pai mai",
          ),
          Article(
            thai: "ลดได้ไหม",
            english: "Can you lower the price?",
            pheonetic: "lot dai mai",
          ),
          Article(
            thai: "ลดหน่อยได้ไหม",
            english: "Can you lower the price a bit?",
            pheonetic: "lot noi dai mai",
          ),
        ],
      ),
    );
    convos.add(
      ConvoModel(
        title: "Transportation",
        articles: [
          Article(
            thai: "ไป(...)",
            english: "Go to (...)",
            pheonetic: "pai (...)",
          ),
          Article(
            thai: "ไปสนามบิน",
            english: "Go to the airport",
            pheonetic: "pai sanam bin",
          ),
          Article(
            thai: "ไปตลาด",
            english: "Go to the market",
            pheonetic: "pai talad",
          ),
          Article(
            thai: "ไปห้างสรรพสินค้า",
            english: "Go to the mall",
            pheonetic: "pai hang sapha sin kha",
          ),
        ],
      ),
    );
    convos.add(
      ConvoModel(
        title: "Asking for help",
        articles: [
          Article(thai: "ช่วยด้วย", english: "Help!", pheonetic: "chuay duay"),
          Article(
            thai: "ช่วยฉันด้วย",
            english: "Help me!",
            pheonetic: "chuay chan duay",
          ),
          Article(
            thai: "ฉันหลงทาง",
            english: "I'm lost",
            pheonetic: "chan long thang",
          ),
          Article(
            thai: "ฉันต้องการความช่วยเหลือ",
            english: "I need help",
            pheonetic: "chan tong kan khwamsuai luea",
          ),
        ],
      ),
    );
    convos.add(
      ConvoModel(
        title: "Asking for directions",
        articles: [
          Article(
            thai: "ไปทางไหน",
            english: "Which way?",
            pheonetic: "pai thang nai",
          ),
          Article(
            thai: "ไปทางซ้าย",
            english: "Go left",
            pheonetic: "pai thang sai",
          ),
          Article(
            thai: "ไปทางขวา",
            english: "Go right",
            pheonetic: "pai thang khwa",
          ),
          Article(
            thai: "ตรงไป",
            english: "Go straight",
            pheonetic: "throng pai",
          ),
        ],
      ),
    );

    return convos;
  }
}

class Article {
  final String thai;
  final String english;
  final String pheonetic;

  Article({required this.thai, required this.english, required this.pheonetic});
}
