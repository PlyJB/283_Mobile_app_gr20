import 'package:flutter/material.dart';
import 'package:pic2thai/main.dart';

class EditCardDetail extends StatefulWidget {
  final String thai;
  final String pronun;
  final String eng;
  final String note;
  final String iconPath;

  const EditCardDetail({
    super.key,
    required this.thai,
    required this.pronun,
    required this.eng,
    required this.note,
    required this.iconPath,
  });

  @override
  State<EditCardDetail> createState() => _EditCardDetailState();
}

class _EditCardDetailState extends State<EditCardDetail> {
  late TextEditingController thaiWordController;
  late TextEditingController pronunController;
  late TextEditingController engWordController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    thaiWordController = TextEditingController(text: widget.thai);
    pronunController = TextEditingController(text: widget.pronun);
    engWordController = TextEditingController(text: widget.eng);
    noteController = TextEditingController(text: widget.note);
  }

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
            decoration: const InputDecoration(
              labelText: 'Thai Word',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: pronunController,
            decoration: const InputDecoration(
              labelText: 'Pronunciation',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: engWordController,
            decoration: const InputDecoration(
              labelText: 'English Word',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey, thickness: 1),
          const SizedBox(height: 10),
          const Text(
            "Note",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: noteController,
            decoration: const InputDecoration(
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
                  final thai = thaiWordController.text;
                  final pronun = pronunController.text;
                  final eng = engWordController.text;
                  final note = noteController.text;

                  print('Edited: $thai / $pronun / $eng / $note');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: const [
                          Icon(Icons.edit, color: Colors.white),
                          SizedBox(width: 10),
                          Text("Changes saved!"),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MyApp()),
                      (route) => false,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8806D8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                child: const Text("Save"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF8806D8),
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
                "Edit Card Detail",
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
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.iconPath,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              InputSection(),
            ],
          ),
        ),
      ),
    );
  }
}
