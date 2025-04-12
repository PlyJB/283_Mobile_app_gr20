import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:pic2thai/pages/acheivement.dart';
import 'package:pic2thai/pages/cardCollection.dart';
import 'package:pic2thai/pages/conversation.dart';
import 'package:pic2thai/pages/tips.dart';
import 'package:pic2thai/pages/checkCardPic.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CustomFont',
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.heading,
          bodyLarge: AppTextStyles.body,
        ),
      ),
      home: const MainScreen(), // Use MainScreen instead of HomePage
    );
  }
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Itim',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body = TextStyle(fontFamily: 'Itim', fontSize: 16);
}

class MainScreen extends StatefulWidget {
  final int selectedIndex;
  final  String imagePath;
  const MainScreen({super.key, this.selectedIndex = 1, this.imagePath = ''});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  Database? _db;


  @override
  void initState() {
    super.initState();
    _initDatabase();
    _selectedIndex = widget.selectedIndex;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'cards_map.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE cards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Thai TEXT NOT NULL,
            Pronounce TEXT NOT NULL,
            English TEXT NOT NULL,
            Note TEXT,
            Icon TEXT NOT NULL,
            isFav INTEGER NOT NULL DEFAULT 0
            )
          ''');
      },
    );
    return _db!;
  }

  final List<String> _titles = [
    "Achievement",
    "Card Collections",
    "Tips & Tricks",
    "Conversation",
  ];

  void _onItemTapped(int index) {
    Navigator.of(
      context,
    ).pushReplacement(_fadeRoute(MainScreen(selectedIndex: index)));
  }

  Widget _getBody(int index, Database db) {
    switch (index) {
      case 0:
        return AchievementPage(database: db, learnedConversations: 0);
      case 1:
        return CardCollectionPage(database: db, imagePath: widget.imagePath,);
      case 2:
        return TipsPage();
      case 3:
        return const ConversationPage();
      default:
        return CardCollectionPage(database: db, imagePath: widget.imagePath,);
    }
  }

  Widget _buildNavItem({required int index, required String assetPath}) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () {
        _onItemTapped(index);
      },
      borderRadius: BorderRadius.circular(50),

      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.purpleAccent : Colors.transparent,
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          assetPath,
          width: 60,
          height: 60,
          color: Colors.white,
        ),
      ),
    );
  }

  // with Logo
  // Alignment _getAlignByIndex(int index) {
  //   switch (index) {
  //     case 0:
  //       return Alignment(-0.95, 0); // ซ้ายสุด
  //     case 1:
  //       return Alignment(-0.6, 0); // ซ้ายกลาง
  //     case 2:
  //       return Alignment(0.53, 0); // ขวากลาง
  //     case 3:
  //       return Alignment(0.95, 0); // ขวาสุด
  //     default:
  //       return Alignment.center;
  //   }
  // }

  Alignment _getAlignByIndex(int index) {
    switch (index) {
      case 0:
        return Alignment(-0.92, 0); // ซ้ายสุด
      case 1:
        return Alignment(-0.35, 0); // ซ้ายกลาง
      case 2:
        return Alignment(0.3, 0); // ขวากลาง
      case 3:
        return Alignment(0.9, 0); // ขวาสุด
      default:
        return Alignment.center;
    }
  }

  PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  PageRouteBuilder slideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1, 0),
            end: Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
    future: _initDatabase(),
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (snapshot.hasError) {
        return Scaffold(
          body: Center(child: Text("เกิดข้อผิดพลาด: ${snapshot.error}")),
        );
      }

      final db = snapshot.data!;
      return _buildMainUI(db);
    },
  );
  }
  Widget _buildMainUI(Database db) {
  return Scaffold(
      body: Stack(
        children: [
          _getBody(_selectedIndex, db),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: _getAlignByIndex(_selectedIndex),
              child: Text(
                _titles[_selectedIndex],
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            color: const Color(0xFF8806D8),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  assetPath: 'assets/icons/editor_choice.png',
                ),
                _buildNavItem(index: 1, assetPath: 'assets/icons/card.png'),
                // const SizedBox(width: 98),
                _buildNavItem(index: 2, assetPath: 'assets/icons/tips.png'),
                _buildNavItem(
                  index: 3,
                  assetPath: 'assets/icons/conversation.png',
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 30,
          //   child: Container(
          //     width: 98,
          //     height: 98,
          //     decoration: BoxDecoration(
          //       color: Color(0xFF8806D8),
          //       shape: BoxShape.circle,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Image.asset(
          //         'assets/icons/logo.png',
          //         width: 40,
          //         height: 40,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}