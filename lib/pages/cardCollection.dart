import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pic2thai/models/card_model.dart';
import 'package:pic2thai/pages/camera.dart';
import 'package:pic2thai/pages/checkCardPic.dart';
import 'package:pic2thai/pages/acheivement.dart';

class CardCollectionPage extends StatefulWidget {
  const CardCollectionPage({super.key});

  @override
  State<CardCollectionPage> createState() => _CardCollectionPageState();
}

class _CardCollectionPageState extends State<CardCollectionPage> {
  List<CardModel> cards = [];

  void _getCards() {
    setState(() {
      cards = CardModel.getCards();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCards();
    });
  }

  Widget _searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
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
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search card',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: const Icon(Icons.menu, color: Color(0xFF8806D8)),
          suffixIcon: const Icon(Icons.search, color: Color(0xFF8806D8)),
        ),
      ),
    );
  }

  Widget _buildCard(CardModel card) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: SizedBox(
        height: 240,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // 🖼️ รูปภาพกลาง
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // ปรับค่าความมนตามต้องการ
                    child: Image.asset(
                      card.iconPath,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // 📝 ข้อความกลางล่าง
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      card.thaiWord,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      card.pronunciation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // ✏️ 🗑️ ปุ่มล่างขวา
              Positioned(
                bottom: 0,
                right: 0,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 22,
                        color: Color(0xFF8806D8),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outlined,
                        size: 22,
                        color: Color(0xFF8806D8),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // ⭐ ปุ่ม favorite มุมบนซ้าย
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: Icon(
                    card.isFav ? Icons.star : Icons.star_border,
                    color: card.isFav ? Colors.amber : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      card.isFav = !card.isFav;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final card = cards[index];
          return _buildCard(card);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: Column(
        children: [
          _searchBox(),
          const SizedBox(height: 20),
          Expanded(child: _buildCardList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => CheckCardPic(),
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
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color(0xFF8806D8), size: 32),
      ),
    );
  }
}
