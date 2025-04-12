import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pic2thai/main.dart';
import 'package:pic2thai/pages/cardCollection.dart';
import 'package:pic2thai/pages/checkCardPic.dart';
import 'package:sqflite/sqflite.dart';

class CreatecardDetail extends StatefulWidget {
  final String imagePath;
  final Database database;
  const CreatecardDetail({
    super.key,
    required this.database,
    required this.imagePath,
  });

  @override
  State<CreatecardDetail> createState() => _CreatecardDetailState();
}

class _CreatecardDetailState extends State<CreatecardDetail> {
  final thaiWordController = TextEditingController();
  final pronunController = TextEditingController();
  final engWordController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> insertCard() async {
    await widget.database.insert('cards', {
      'thai': thaiWordController.text,
      'pronun': pronunController.text,
      'english': engWordController.text,
      'note': noteController.text,
      'imagePath': widget.imagePath,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Card saved!')));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => CardCollectionPage(
              database: widget.database,
              imagePath: widget.imagePath,
            ),
      ),
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
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          const Text(
            "Vocabulary",
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(widget.imagePath),
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
      // ),
    );
  }
}
