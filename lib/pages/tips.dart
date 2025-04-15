import 'package:flutter/material.dart';
import 'package:pic2thai/models/tips_model.dart';
import 'package:pic2thai/pages/tipsDetails.dart';
import 'package:pic2thai/main.dart';

class TipsPage extends StatefulWidget {
  TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  List<TipsModel> tips = [];
  String searchText = '';
  void _getTips() {
    setState(() {
      tips = TipsModel.getTips();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getTips();
    });
  }

  Widget _searchBox() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.01),
            blurRadius: 10,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase(); // กรองแบบไม่สนตัวพิมพ์เล็ก-ใหญ่
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search tips',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: const Icon(Icons.menu, color: Color(0xFF8806D8)),
          suffixIcon: const Icon(Icons.search, color: Color(0xFF8806D8)),
        ),
      ),
    );
  }

  Widget _buildTips(TipsModel tips) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: const Color(0xFF8806D8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 30),
        ),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      Tipsdetails(tip: tips),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1, 0),
                    end: Offset(0, 0),
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
        child: Text(
          tips.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8806D8),
          ),
          // const TextStyle(color: const Color(0xFF8806D8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTips =
        tips.where((tip) {
          final titleMatch = tip.title.toLowerCase().contains(searchText);
          final articleMatch = tip.articles.any(
            (article) => article.article.toLowerCase().contains(searchText),
          );
          return titleMatch || articleMatch;
        }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: Text(
                "Tips and Tricks",
                style: AppTextStyles.heading.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8806D8),
                ),
              ),
            ),
          ),
          _searchBox(),
          if (filteredTips.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'No tips found',
                  style: AppTextStyles.body.copyWith(color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: filteredTips.length,
                  itemBuilder: (context, index) {
                    return _buildTips(filteredTips[index]);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
