import 'package:flutter/material.dart';
// import 'package:material_symbols_icons/material_symbols_icons.dart';
// import 'pages/card_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const MainScreen(), // Use MainScreen instead of HomePage
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define the pages for each tab
  final List<Widget> _pages = [
    // const CardPage(),
    const Center(child: Text('Archeivement', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Card Collections', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Tips and Tricks', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Conversation', style: TextStyle(fontSize: 20)))

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],// Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF8806D8),
        items: [
          BottomNavigationBarItem(icon: Image.asset(
            'assets/icons/editor_choice.png', 
            width: 24, 
            height: 24,
            )
            , label: 'Tropy'),
          BottomNavigationBarItem(icon: Image.asset(
            'assets/icons/card.png', 
            width: 24, 
            height: 24,
            )
            , label: 'Card'),
          BottomNavigationBarItem(icon: Image.asset(
            'assets/icons/tips.png', 
            width: 24, 
            height: 24,
            )
            , label: 'Tips and Tricks'),
            BottomNavigationBarItem(icon: Image.asset(
            'assets/icons/conversation.png', 
            width: 24, 
            height: 24,
            )
            , label: 'conversation'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
