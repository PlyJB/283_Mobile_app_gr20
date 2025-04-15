import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pic2thai/main.dart';
import 'package:pic2thai/models/card_model.dart';
import 'package:sqflite/sqflite.dart';

class EditCardDetail extends StatefulWidget {
  final int? id;
  final String thai;
  final String pronun;
  final String eng;
  final String note;
  final String iconPath;
  final Database database;

  const EditCardDetail({
    super.key,
    required this.id,
    required this.thai,
    required this.pronun,
    required this.eng,
    required this.note,
    required this.iconPath,
    required this.database,
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

  Future<void> _saveEdit() async {
    final thai = thaiWordController.text.trim();
    final pronun = pronunController.text.trim();
    final eng = engWordController.text.trim();
    final note = noteController.text.trim();
    final card = CardModel(
      id: widget.id,
      thaiWord: thai,
      pronunciation: pronun,
      engWord: eng,
      note: note,
      iconPath: widget.iconPath,
    );

    await widget.database.update(
      'cards',
      card.toMap(),
      where: 'id = ?',
      whereArgs: [widget.id],
    );

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MyApp()),
      (route) => false,
    );
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
            decoration: InputDecoration(
              labelText: 'Thai Word',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: pronunController,
            decoration: InputDecoration(
              labelText: 'Pronunciation',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: engWordController,
            decoration: InputDecoration(
              labelText: 'English Word',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
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
            decoration: InputDecoration(
              labelText: 'Note (optional)',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 300,
              //Save button
              // Update card detail
              child: ElevatedButton(
                onPressed: () {
                  _saveEdit();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
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
                  child: Image.file(
                    File(widget.iconPath),
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
