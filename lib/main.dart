import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return MaterialApp.router(
      title: 'Салон Красоты "BeautyClinic"',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage(
            child: facial_care.FacialCareContainer(),
          ),
        ),
        GoRoute(
          path: '/facial_care',
          pageBuilder: (context, state) => NoTransitionPage(
            child: facial_care.FacialCareContainer(),
          ),
        ),
        GoRoute(
          path: '/body_care',
          pageBuilder: (context, state) => NoTransitionPage(
            child: body_care.BodyCareContainer(),
          ),
        ),
        GoRoute(
          path: '/hair_removal',
          pageBuilder: (context, state) => NoTransitionPage(
            child: hair_removal.HairRemovalContainer(),
          ),
        ),
        GoRoute(
          path: '/massage',
          pageBuilder: (context, state) => NoTransitionPage(
            child: massage.MassageContainer(),
          ),
        ),
        GoRoute(
          path: '/spa',
          pageBuilder: (context, state) => NoTransitionPage(
            child: spa.SpaContainer(),
          ),
        ),
      ],
    ),
  ],
);

class MainNavigationScreen extends StatefulWidget {
  final Widget child;

  const MainNavigationScreen({super.key, required this.child});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentScreenIndex = 0;

  final List<String> _routes = [
    '/facial_care',
    '/body_care',
    '/hair_removal',
    '/massage',
    '/spa'
  ];

  final List<String> _screenTitles = [
    'Уход за лицом',
    'Уход за телом',
    'Депиляция',
    'Массаж',
    'SPA-программы',
  ];

  int _getCurrentIndex(String location) {
    for (int i = 0; i < _routes.length; i++) {
      if (location == _routes[i] || location.endsWith(_routes[i])) {
        return i;
      }
    }
    return 0;
  }

  String _getScreenTitle(String location) {
    final int index = _getCurrentIndex(location);
    return _screenTitles[index];
  }

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();
    final int currentIndex = _getCurrentIndex(currentLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getScreenTitle(currentLocation)),
        backgroundColor: Colors.pink[100],
        elevation: 2,
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.go(_routes[index]);
        },
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

class FacialCareContainer extends StatelessWidget {
  const FacialCareContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Уход за лицом'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/body_care'),
            child: const Text('Перейти к уходу за телом'),
          ),
        ],
      ),
    );
  }
}

class BodyCareContainer extends StatelessWidget {
  const BodyCareContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Уход за телом'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/spa'),
            child: const Text('Перейти к SPA'),
          ),
        ],
      ),
    );
  }
}

class HairRemovalContainer extends StatelessWidget {
  const HairRemovalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Депиляция'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/massage'),
            child: const Text('Перейти к массажу'),
          ),
        ],
      ),
    );
  }
}

class MassageContainer extends StatelessWidget {
  const MassageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Массаж'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/facial_care'),
            child: const Text('Перейти к уходу за лицом'),
          ),
        ],
      ),
    );
  }
}

class SpaContainer extends StatelessWidget {
  const SpaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('SPA-программы'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/hair_removal'),
            child: const Text('Перейти к депиляции'),
          ),
        ],
      ),
    );
  }
}