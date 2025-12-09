import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/usecases/auth/login_usecase.dart';
import '../../../../domain/usecases/auth/register_usecase.dart';
import '../../../../domain/usecases/auth/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    LoginUseCase? loginUseCase,
    RegisterUseCase? registerUseCase,
    LogoutUseCase? logoutUseCase,
  })  : loginUseCase = loginUseCase ?? getIt<LoginUseCase>(),
        registerUseCase = registerUseCase ?? getIt<RegisterUseCase>(),
        logoutUseCase = logoutUseCase ?? getIt<LogoutUseCase>(),
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    final result = await loginUseCase(event.email, event.password);
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(
        email: user.email,
        username: user.username ?? user.email.split('@').first,
      )),
    );
  }

  void _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    final result = await registerUseCase(event.email, event.password);
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(
        email: user.email,
        username: user.username ?? user.email.split('@').first,
      )),
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    final result = await logoutUseCase();
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}


