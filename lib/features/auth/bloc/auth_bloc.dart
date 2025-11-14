import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 1000));
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthAuthenticated(
          email: event.email,
          username: event.email.split('@').first,
        ));
      } else {
        emit(AuthError('Заполните все поля'));
      }
    } catch (e) {
      emit(AuthError('Ошибка входа: $e'));
    }
  }

  void _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 1000));
      if (event.email.isNotEmpty && event.password.isNotEmpty && event.password.length >= 6) {
        emit(AuthAuthenticated(
          email: event.email,
          username: event.email.split('@').first,
        ));
      } else {
        emit(AuthError('Пароль должен содержать минимум 6 символов'));
      }
    } catch (e) {
      emit(AuthError('Ошибка регистрации: $e'));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }
}