import 'package:flutter/material.dart';
import 'package:pic2thai/models/tips_model.dart';
import 'package:pic2thai/main.dart';

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
          style: AppTextStyles.body.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8806D8),
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
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Text(
                tip.articles[index].article,
                style: AppTextStyles.body.copyWith(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
