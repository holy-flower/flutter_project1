import 'package:flutter/material.dart';
import 'package:flutter_project1/features/newFile.dart';
import 'package:go_router/go_router.dart';
import 'features/body_care/models/body_service.dart';
import 'features/body_care/screens/add_body_service_screen.dart';
import 'features/body_care/state/body_care_container.dart';
import 'features/facial_care/facial_care_feature.dart' as facial_care;
import 'features/body_care/body_care_feature.dart' as body_care;
import 'features/facial_care/models/facial_service.dart';
import 'features/facial_care/screens/add_facial_service_screen.dart';
import 'features/facial_care/state/facial_care_container.dart';
import 'features/hair_removal/hair_removal_feature.dart' as hair_removal;
import 'features/hair_removal/models/hair_removal_service.dart';
import 'features/hair_removal/screens/add_hair_removal_service_screen.dart';
import 'features/hair_removal/state/hair_removal_container.dart';
import 'features/massage/massage_feature.dart' as massage;
import 'features/massage/models/massage_service.dart';
import 'features/massage/screens/add_massage_service_screen.dart';
import 'features/massage/state/massage_container.dart';
import 'features/spa/models/spa_service.dart';
import 'features/spa/screens/add_spa_service_screen.dart';
import 'features/spa/spa_feature.dart' as spa;
import 'features/spa/state/spa_container.dart';

void main() {
  runApp(const CosmetologyApp());
}

class CosmetologyApp extends StatelessWidget {
  const CosmetologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateContainer(
        child:MaterialApp.router(
          title: 'Салон Красоты "BeautyClinic"',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            fontFamily: 'Roboto',
          ),
          routerConfig: _router,
        ),
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
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? FacialCareContainer.withServices(state.extra as List<FacialService>)
                : const FacialCareContainer(),
          ),
        ),
        GoRoute(
          path: '/body_care',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? BodyCareContainer.withServices(state.extra as List<BodyService>)
                : const BodyCareContainer(),
          ),
        ),
        GoRoute(
          path: '/hair_removal',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? HairRemovalContainer.withServices(state.extra as List<HairRemovalService>)
                : const HairRemovalContainer(),
          ),
        ),
        GoRoute(
          path: '/massage',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? MassageContainer.withMassages(state.extra as List<MassageService>)
                : const MassageContainer(),
          ),
        ),
        GoRoute(
          path: '/spa',
          pageBuilder: (context, state) => MaterialPage(
            child: state.extra != null
                ? SpaContainer.withPrograms(state.extra as List<SpaService>)
                : const SpaContainer(),
          ),
        ),

        GoRoute(
          path: '/add_facial_service',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MaterialPage(
              child: AddFacialServiceScreen(
                onServiceAdded: extra?['onServiceAdded'] as Function(FacialService),
                currentServices: extra?['currentServices'] as List<FacialService>,
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
                onServiceAdded: extra?['onServiceAdded'] as Function(BodyService),
                currentServices: extra?['currentServices'] as List<BodyService>,
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
                onServiceAdded: extra?['onServiceAdded'] as Function(HairRemovalService),
                currentServices: extra?['currentServices'] as List<HairRemovalService>,
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
                onMassageAdded: extra?['onMassageAdded'] as Function(MassageService),
                currentMassages: extra?['currentMassages'] as List<MassageService>,
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
                onSpaServiceAdded: extra?['onSpaServiceAdded'] as Function(SpaService),
                currentPrograms: extra?['currentPrograms'] as List<SpaService>,
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