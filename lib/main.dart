import 'package:flutter/material.dart';
import 'screens/facial_care_screen.dart';

void main() {
  runApp(const CosmetologyApp());
}

class CosmetologyApp extends StatelessWidget {
  const CosmetologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Салон Красоты "BeauiClinic"',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentScreenIndex = 0;

  final List<Widget> _screens = [
    const FacialCareScreen()
  ];


  final List<String> _screenTitles = [
    'Уход за лицом',
    'Уход за телом',
    'Депиляция',
    'Массаж',
    'SPA-программы',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitles[_currentScreenIndex]),
        backgroundColor: Colors.pink[100],
        elevation: 2,
      ),
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Лицо',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Тело',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_cut),
            label: 'Депиляция',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Массаж',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pool),
            label: 'SPA',
          ),
        ],
      ),
    );
  }
}