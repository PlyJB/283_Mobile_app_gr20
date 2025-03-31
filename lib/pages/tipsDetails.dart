import 'package:flutter/material.dart';
import 'package:pic2thai/models/tips_model.dart';

class Tipsdetails extends StatelessWidget {
  final TipsModel tip;

  const Tipsdetails({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          tip.title,
          style: const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.builder(
          itemCount: tip.articles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                tip.articles[index].article,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            );
          },
        ),
      ),
    );
  }
}
