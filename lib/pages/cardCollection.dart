import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pic2thai/models/card_model.dart';
import 'package:pic2thai/pages/camera.dart';
import 'package:pic2thai/pages/checkCardPic.dart';
import 'package:pic2thai/pages/acheivement.dart';
import 'package:pic2thai/pages/createCard.dart';
import 'package:pic2thai/pages/editCard.dart';
import 'package:pic2thai/main.dart';
import 'package:sqflite/sqflite.dart';

class CardCollectionPage extends StatefulWidget {
  final String imagePath;
  final Database database;
  const CardCollectionPage({
    super.key,
    required this.database,
    required this.imagePath,
  });

  @override
  State<CardCollectionPage> createState() => _CardCollectionPageState();
}

class _CardCollectionPageState extends State<CardCollectionPage> {
  List<CardModel> cards = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCards();
    });
  }


  Future<void> _getCards() async {
    final List<Map<String, dynamic>> data = await widget.database.query(
      'cards',
    );
    final List<CardModel> loadedCards = [];
    for (var map in data) {
      loadedCards.add(
        CardModel(
          id: map['id'],
          thaiWord: map['Thai'],
          pronunciation: map['Pronounce'],
          engWord: map['English'],
          note: map['Note'],
          iconPath: map['Icon'],
          isFav: map['isFav'] == 1,
        ),
      );
    }
    setState(() {
      cards = loadedCards;
    });
  }


  String searchQuery = '';

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
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
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
          hintText: 'Search card',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: const Icon(Icons.menu, color: Color(0xFF8806D8)),
          suffixIcon: const Icon(Icons.search, color: Color(0xFF8806D8)),
        ),
      ),
    );
  }

  /// update card to favorite
  void _toggleFavorite(CardModel card) async {
    setState(() {
      card.isFav = !card.isFav;
    });

    await widget.database.update(
      'cards',
      {'isFav': card.isFav ? 1 : 0},
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  // card template
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
                      style: AppTextStyles.heading.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      // const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      card.pronunciation,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      // const TextStyle(color: Colors.grey),
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
                    // edit buttpn
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 22,
                        color: Color(0xFF8806D8),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => EditCardDetail(
                                  id: card.id,
                                  thai: card.thaiWord,
                                  pronun: card.pronunciation,
                                  eng: card.engWord,
                                  note: card.note,
                                  iconPath: card.iconPath,
                                  database: widget.database,
                                ),
                          ),
                        );
                      },
                    ),
                    // delete button
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outlined,
                        size: 22,
                        color: Color(0xFF8806D8),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      height: 20,
                                      color: Color(0xFF8806D8),
                                    ),
                                    const Icon(
                                      Icons.delete,
                                      color: Color(0xFF8806D8),
                                      size: 50,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Are you sure you want to delete?',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.body,
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // No Button
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            foregroundColor: Color(0xFF8806D8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('No'),
                                        ),
                                        // Yes Button
                                        // ============TODO===============
                                        //Delete card
                                        ElevatedButton(
                                          onPressed: () async {
                                            // Do delete logic here
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text("Card deleted!"),
                                                  ],
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                margin: const EdgeInsets.all(
                                                  16,
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                            await widget.database.delete(
                                              'cards',
                                              where: 'id = ?',
                                              whereArgs: [card.id],
                                            );
                                            await _getCards(); // อัปเดตรายการหลังลบ
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF8806D8),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -16,
                left: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: card.isFav ? Color(0xFF8806D8) : Colors.grey,
                    size: 50,
                  ),
                  // onPressed: () {
                  //   setState(() {
                  //     card.isFav = !card.isFav;
                  //   });
                  // },
                  onPressed: () => _toggleFavorite(card),
                ),
              ),
              // ⭐ ปุ่ม favorite มุมบนซ้าย
              Positioned(
                top: -8,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.star,
                    color: card.isFav ? Colors.amber : Colors.white,
                    size: 20,
                  ),
                  onPressed: () => _toggleFavorite(card),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardList() {
    final filteredCards =
        cards.where((card) {
          final thai = card.thaiWord.toLowerCase();
          final eng = card.engWord.toLowerCase();
          final pronun = card.pronunciation.toLowerCase();
          return thai.contains(searchQuery) ||
              eng.contains(searchQuery) ||
              pronun.contains(searchQuery);
        }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: filteredCards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final card = filteredCards[index];
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
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      CameraPage(database: widget.database),
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
