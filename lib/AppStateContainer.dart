/*
import 'package:flutter/material.dart';

class AppState {
  final String appName = 'Салон Красоты "BeautyClinic"';
  int totalServicesCount = 0;
  int deletedServicesCount = 0;
  DateTime? lastActionTime;
  String currentScreen = '';

  void updateServiceCount(int count) {
    totalServicesCount = count;
    lastActionTime = DateTime.now();
  }

  void incrementDeletedCount() {
    deletedServicesCount++;
    lastActionTime = DateTime.now();
  }

  void setCurrentScreen(String screen) {
    currentScreen = screen;
  }
}

class AppStateContainer extends InheritedWidget {
  final AppState state;

  const AppStateContainer({
    super.key,
    required this.state,
    required super.child,
  });

  static AppStateContainer of(BuildContext context) {
    final AppStateContainer? result =
    context.dependOnInheritedWidgetOfExactType<AppStateContainer>();
    assert(result != null, 'No AppStateContainer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppStateContainer oldWidget) {
    return state.totalServicesCount != oldWidget.state.totalServicesCount ||
        state.deletedServicesCount != oldWidget.state.deletedServicesCount ||
        state.currentScreen != oldWidget.state.currentScreen;
  }
}
 */