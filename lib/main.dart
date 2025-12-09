import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/di/injection_container.dart' as di;
import 'ui/features/auth/bloc/auth_bloc.dart';
import 'ui/features/appointments/bloc/appointments_bloc.dart';
import 'ui/features/profile/bloc/profile_bloc.dart';
import 'ui/features/finance/bloc/finance_bloc.dart';
import 'ui/features/inventory/bloc/inventory_bloc.dart';
import 'ui/features/settings/bloc/settings_bloc.dart';
import 'ui/features/services/bloc/services_bloc.dart';
import 'ui/features/auth/auth_screen.dart';
import 'ui/features/appointments/appointments_screen.dart';
import 'ui/features/finance/finance_screen.dart';
import 'ui/features/inventory/inventory_screen.dart';
import 'ui/features/profile/profile_screen.dart';
import 'ui/features/settings/settings_screen.dart';
import 'ui/features/services/services_screen.dart';
import 'ui/features/facial_care/screens/facial_care_screen.dart';
import 'ui/features/facial_care/screens/add_facial_service_screen.dart';
import 'ui/features/body_care/screens/body_care_screen.dart';
import 'ui/features/body_care/screens/add_body_service_screen.dart';
import 'ui/features/hair_removal/screens/hair_removal_screen.dart';
import 'ui/features/hair_removal/screens/add_hair_removal_service_screen.dart';
import 'ui/features/massage/screens/massage_screen.dart';
import 'ui/features/massage/screens/add_massage_service_screen.dart';
import 'ui/features/spa/screens/spa_screen.dart';
import 'ui/features/spa/screens/add_spa_service_screen.dart';
import 'ui/features/facial_care/bloc/facial_care_bloc.dart';
import 'ui/features/body_care/bloc/body_care_bloc.dart';
import 'ui/features/hair_removal/bloc/hair_removal_bloc.dart';
import 'ui/features/massage/bloc/massage_bloc.dart';
import 'ui/features/spa/bloc/spa_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const CosmetologyApp());
}

class CosmetologyApp extends StatelessWidget {
  const CosmetologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.getIt<AuthBloc>(),
        ),
        BlocProvider<AppointmentsBloc>(
          create: (context) => di.getIt<AppointmentsBloc>()..add(LoadAppointments()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => di.getIt<ProfileBloc>(),
        ),
        BlocProvider<ServicesBloc>(
          create: (context) => di.getIt<ServicesBloc>()..add(LoadServices()),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => di.getIt<SettingsBloc>()..add(LoadSettings()),
        ),
        BlocProvider<FinanceBloc>(
          create: (context) => di.getIt<FinanceBloc>()..add(LoadFinanceData()),
        ),
        BlocProvider<InventoryBloc>(
          create: (context) => di.getIt<InventoryBloc>()..add(LoadInventory()),
        ),
        BlocProvider<FacialCareBloc>(
          create: (context) => di.getIt<FacialCareBloc>()..add(LoadFacialServices()),
        ),
        BlocProvider<BodyCareBloc>(
          create: (context) => di.getIt<BodyCareBloc>()..add(LoadBodyServices()),
        ),
        BlocProvider<HairRemovalBloc>(
          create: (context) => di.getIt<HairRemovalBloc>()..add(LoadHairRemovalServices()),
        ),
        BlocProvider<MassageBloc>(
          create: (context) => di.getIt<MassageBloc>()..add(LoadMassageServices()),
        ),
        BlocProvider<SpaBloc>(
          create: (context) => di.getIt<SpaBloc>()..add(LoadSpaServices()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final isDarkTheme = state is SettingsLoaded ? state.settings.isDarkTheme : false;

          return MaterialApp.router(
            title: 'Салон Красоты "BeautyClinic"',
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _router,
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      primarySwatch: Colors.pink,
      fontFamily: 'Roboto',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.pink[50],
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink[100],
        elevation: 2,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.pink,
      fontFamily: 'Roboto',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 2,
      ),
      dialogBackgroundColor: const Color(0xFF1E1E1E),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1A1A1A),
      ),
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
          path: '/inventory',
          pageBuilder: (context, state) => MaterialPage(
            child: InventoryScreen(),
          ),
        ),
        GoRoute(
          path: '/finance',
          pageBuilder: (context, state) => MaterialPage(
            child: FinanceScreen(),
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
          pageBuilder: (context, state) => const MaterialPage(
            child: FacialCareScreen(),
          ),
        ),
        GoRoute(
          path: '/body_care',
          pageBuilder: (context, state) => const MaterialPage(
            child: BodyCareScreen(),
          ),
        ),
        GoRoute(
          path: '/hair_removal',
          pageBuilder: (context, state) => const MaterialPage(
            child: HairRemovalScreen(),
          ),
        ),
        GoRoute(
          path: '/massage',
          pageBuilder: (context, state) => const MaterialPage(
            child: MassageScreen(),
          ),
        ),
        GoRoute(
          path: '/spa',
          pageBuilder: (context, state) => const MaterialPage(
            child: SpaScreen(),
          ),
        ),

        GoRoute(
          path: '/add_facial_service',
          pageBuilder: (context, state) => const MaterialPage(
            child: AddFacialServiceScreen(),
          ),
        ),
        GoRoute(
          path: '/add_body_service',
          pageBuilder: (context, state) => const MaterialPage(
            child: AddBodyServiceScreen(),
          ),
        ),
        GoRoute(
          path: '/add_hair_removal_service',
          pageBuilder: (context, state) => const MaterialPage(
            child: AddHairRemovalServiceScreen(),
          ),
        ),
        GoRoute(
          path: '/add_massage_service',
          pageBuilder: (context, state) => const MaterialPage(
            child: AddMassageServiceScreen(),
          ),
        ),
        GoRoute(
          path: '/add_spa_service',
          pageBuilder: (context, state) => const MaterialPage(
            child: AddSpaServiceScreen(),
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
    '/profile',
    '/services',
    '/appointments',
    '/inventory',
    '/finance',
  ];

  final List<String> _screenTitles = [
    'Профиль',
    'Услуги',
    'Записи',
    'Склад',
    'Финансы',
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

    if (location.startsWith('/inventory')) {
      return 3;
    }

    if (location.startsWith('/finance')) {
      return 4;
    }

    if (location.startsWith('/settings')) {
      return 0;
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
    } else if (location.startsWith('/inventory')) {
      return 'Склад и материалы';
    } else if (location.startsWith('/finance')) {
      return 'Финансы';
    } else if (location.startsWith('/settings')) {
      return 'Настройки';
    }

    return _screenTitles[index];
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выход из системы'),
          content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
                context.pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Вы успешно вышли из системы'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text('Выйти', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();
    final int currentIndex = _getCurrentIndex(currentLocation);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Future.microtask(() => context.go('/auth'));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getScreenTitle(currentLocation)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 2,
          automaticallyImplyLeading: false,
          actions: [
            if (currentLocation != '/auth')
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Выйти из системы',
                onPressed: () => _showLogoutConfirmationDialog(context),
              ),
          ],
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
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.spa),
              label: 'Услуги',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Записи',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2),
              label: 'Склад',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Финансы',
            ),
          ],
        ),
      ),
    );
  }
}