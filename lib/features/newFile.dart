import 'package:flutter/cupertino.dart';

class AppStateContainer extends InheritedWidget {
  final String state = 'active';

  const AppStateContainer({
    super.key,
    required super.child,
  });

  static AppStateContainer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateContainer>()!;
  }

  @override
  bool updateShouldNotify(AppStateContainer oldWidget) => false;
}