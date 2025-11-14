import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/appointments/appointments_screen.dart';
import 'features/auth/auth_screen.dart';
import 'features/facial_care/screens/add_facial_service_screen.dart';
import 'features/body_care/screens/add_body_service_screen.dart';
import 'features/hair_removal/screens/add_hair_removal_service_screen.dart';
import 'features/massage/screens/add_massage_service_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/services/services_screen.dart';
import 'features/facial_care/facial_care_feature.dart' as facial_care;
import 'features/body_care/body_care_feature.dart' as body_care;
import 'features/hair_removal/hair_removal_feature.dart' as hair_removal;
import 'features/massage/massage_feature.dart' as massage;
import 'features/spa/screens/add_spa_service_screen.dart';
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
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) => MaterialPage(
        child: AuthScreen(),
      ),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => MaterialPage(
            child: ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/services',
          pageBuilder: (context, state) => MaterialPage(
            child: ServicesScreen(),
          ),
        ),
        GoRoute(
          path: '/appointments',
          pageBuilder: (context, state) => MaterialPage(
            child: AppointmentsScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => MaterialPage(
            child: SettingsScreen(),
          ),
        ),

        GoRoute(
          path: '/facial_care',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? facial_care.FacialCareContainer.withServices(state.extra as List<facial_care.FacialService>)
                : const facial_care.FacialCareContainer(),
          ),
        ),
        GoRoute(
          path: '/body_care',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? body_care.BodyCareContainer.withServices(state.extra as List<body_care.BodyService>)
                : const body_care.BodyCareContainer(),
          ),
        ),
        GoRoute(
          path: '/hair_removal',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? hair_removal.HairRemovalContainer.withServices(state.extra as List<hair_removal.HairRemovalService>)
                : const hair_removal.HairRemovalContainer(),
          ),
        ),
        GoRoute(
          path: '/massage',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? massage.MassageContainer.withMassages(state.extra as List<massage.MassageService>)
                : const massage.MassageContainer(),
          ),
        ),
        GoRoute(
          path: '/spa',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? spa.SpaContainer.withPrograms(state.extra as List<spa.SpaService>)
                : const spa.SpaContainer(),
          ),
        ),

        GoRoute(
          path: '/add_facial_service',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: AddFacialServiceScreen(
                onServiceAdded: extra?['onServiceAdded'] as Function(facial_care.FacialService),
                currentServices: extra?['currentServices'] as List<facial_care.FacialService>? ?? [],
              ),
            );
          },
        ),
        GoRoute(
          path: '/add_body_service',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: AddBodyServiceScreen(
                onServiceAdded: extra?['onServiceAdded'] as Function(body_care.BodyService),
                currentServices: extra?['currentServices'] as List<body_care.BodyService>? ?? [],
              ),
            );
          },
        ),
        GoRoute(
          path: '/add_hair_removal_service',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: AddHairRemovalServiceScreen(
                onServiceAdded: extra?['onServiceAdded'] as Function(hair_removal.HairRemovalService),
                currentServices: extra?['currentServices'] as List<hair_removal.HairRemovalService>? ?? [],
              ),
            );
          },
        ),
        GoRoute(
          path: '/add_massage_service',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: AddMassageServiceScreen(
                onMassageAdded: extra?['onServiceAdded'] as Function(massage.MassageService),
                currentMassages: extra?['currentServices'] as List<massage.MassageService>? ?? [],
              ),
            );
          },
        ),
        GoRoute(
          path: '/add_spa_service',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: AddSpaServiceScreen(
                onSpaServiceAdded: extra?['onServiceAdded'] as Function(spa.SpaService),
                currentPrograms: extra?['currentServices'] as List<spa.SpaService>? ?? [],
              ),
            );
          },
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
    '/profile',
    '/services',
    '/appointments',
    '/settings',
  ];

  final List<String> _screenTitles = [
    'Профиль',
    'Услуги',
    'Записи',
    'Настройки',
  ];

  int _getCurrentIndex(String location) {
    if (location.startsWith('/services') ||
        location.startsWith('/facial_care') ||
        location.startsWith('/body_care') ||
        location.startsWith('/hair_removal') ||
        location.startsWith('/massage') ||
        location.startsWith('/spa') ||
        location.startsWith('/add_')) {
      return 1;
    }

    for (int i = 0; i < _routes.length; i++) {
      if (location == _routes[i] || location.startsWith(_routes[i])) {
        return i;
      }
    }
    return 0;
  }

  String _getScreenTitle(String location) {
    final int index = _getCurrentIndex(location);

    if (location.startsWith('/facial_care') || location == '/add_facial_service') {
      return 'Уход за лицом';
    } else if (location.startsWith('/body_care') || location == '/add_body_service') {
      return 'Уход за телом';
    } else if (location.startsWith('/hair_removal') || location == '/add_hair_removal_service') {
      return 'Депиляция';
    } else if (location.startsWith('/massage') || location == '/add_massage_service') {
      return 'Массаж';
    } else if (location.startsWith('/spa') || location == '/add_spa_service') {
      return 'SPA-программы';
    }

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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Услуги'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Записи'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}