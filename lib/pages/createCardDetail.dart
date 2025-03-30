import 'package:flutter/material.dart';
import 'package:pic2thai/pages/cardCollection.dart';
import 'package:pic2thai/pages/checkCardPic.dart';

class CreatecardDetail extends StatefulWidget {
  const CreatecardDetail({super.key});

  @override
  State<CreatecardDetail> createState() => _CreatecardDetailState();
}

class _CreatecardDetailState extends State<CreatecardDetail> {
  final thaiWordController = TextEditingController();
  final pronunController = TextEditingController();
  final engWordController = TextEditingController();
  final noteController = TextEditingController();

  Widget InputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Vocabulary",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: thaiWordController,
            decoration: InputDecoration(
              labelText: 'Thai Word',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: pronunController,
            decoration: InputDecoration(
              labelText: 'Pronunciation',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: engWordController,
            decoration: InputDecoration(
              labelText: 'English Word',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            color: Colors.grey, // สีเส้น
            thickness: 1, // ความหนา
          ),
          const SizedBox(height: 10),
          const Text(
            "Vocabulary",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Note (optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save or send data
                  final thai = thaiWordController.text;
                  final pronun = pronunController.text;
                  final eng = engWordController.text;
                  final note = noteController.text;

                  print('Saved: $thai / $pronun / $eng / $note');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Card created!")),
                  );
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => CardCollectionPage(),
                      ),
                      (route) => false,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8806D8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                child: const Text("Create"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => CheckCardPic()),
                      (route) => false,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF8806D8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                child: const Text("Cancel"),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Create Card Detail",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8806D8),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // ปรับขนาดมุมมนตามต้องการ
                  child: Image.asset(
                    'assets/picture/testPic.jpg',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey, // สีเส้น
                thickness: 1, // ความหนา
                indent: 16, // ระยะห่างจากด้านซ้าย
                endIndent: 16, // ระยะห่างจากด้านขวา
              ),
              InputSection(),
            ],
          ),
        ),
      ),
    );
  }
}
