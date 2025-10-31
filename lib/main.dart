import 'package:flutter/material.dart';
import 'package:flutter_project1/features/facial_care/models/facial_service.dart';
import 'package:flutter_project1/features/facial_care/screens/add_facial_service_screen.dart';
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
            child: const facial_care.FacialCareContainer(),
          ),
        ),
        GoRoute(
          path: '/facial_care',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const facial_care.FacialCareContainer(),
          ),
        ),
        GoRoute(
          path: '/body_care',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const body_care.BodyCareContainer(),
          ),
        ),
        GoRoute(
          path: '/hair_removal',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const hair_removal.HairRemovalContainer(),
          ),
        ),
        GoRoute(
          path: '/massage',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const massage.MassageContainer(),
          ),
        ),
        GoRoute(
          path: '/spa',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const spa.SpaContainer(),
          ),
        ),
        GoRoute(
          path: '/facial_care/add',
          pageBuilder: (context, state) {
            final Function(FacialService) onServiceAdded = state.extra as Function(FacialService);
            return MaterialPage(
                child: AddFacialServiceScreen(onServiceAdded: onServiceAdded),
            );
          }
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
        automaticallyImplyLeading: false,
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
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Лицо'),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: 'Тело'),
          BottomNavigationBarItem(icon: Icon(Icons.content_cut), label: 'Депиляция'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Массаж'),
          BottomNavigationBarItem(icon: Icon(Icons.pool), label: 'SPA'),
        ],
      ),
    );
  }
}