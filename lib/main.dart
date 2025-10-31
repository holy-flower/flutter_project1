import 'package:flutter/material.dart';
import 'features/facial_care/facial_care_feature.dart' as facial_care;
import 'features/body_care/body_care_feature.dart' as body_care;
import 'features/hair_removal/hair_removal_feature.dart' as hair_removal;
import 'features/massage/massage_feature.dart' as massage;
import 'features/spa/spa_feature.dart' as spa;

void main() {
  runApp(const CosmetologyApp());
}

class CosmetologyApp extends StatelessWidget {
  const CosmetologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Салон Красоты "BeautyClinic"',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: const CustomMainNavigationScreen(initialIndex: 0),
    );
  }
}

class CustomMainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const CustomMainNavigationScreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<CustomMainNavigationScreen> createState() => _CustomMainNavigationScreenState();
}

class _CustomMainNavigationScreenState extends State<CustomMainNavigationScreen> {
  late int _currentScreenIndex;

  final List<Widget> _screens = [
    const facial_care.FacialCareContainer(),
    const body_care.BodyCareContainer(),
    const hair_removal.HairRemovalContainer(),
    const massage.MassageContainer(),
    const spa.SpaContainer()
  ];

  final List<String> _screenTitles = [
    'Уход за лицом',
    'Уход за телом',
    'Депиляция',
    'Массаж',
    'SPA-программы',
  ];

  @override
  void initState() {
    super.initState();
    _currentScreenIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CustomMainNavigationScreen(initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitles[_currentScreenIndex]),
        backgroundColor: Colors.pink[100],
        elevation: 2,
        automaticallyImplyLeading: false,
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