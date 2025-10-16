import 'package:flutter/material.dart';
import 'features/facial_care/facial_care_screen.dart';
import 'features/body_care/body_care_feature.dart' as body_care;
import 'features/hair_removal/hair_removal_screen.dart';
import 'features/massage/massage_screen.dart';
import 'features/spa/spa_screen.dart';

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
    const FacialCareScreen(),
    const body_care.BodyCareContainer(),
    const HairRemovalScreen(),
    const MassageScreen(),
    const SPAScreen()
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