import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AuthEvent {}

class Login extends AuthEvent {
  final String username;
  final String password;

  Login({required this.username, required this.password});
}

class Logout extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;

  AuthAuthenticated(this.token);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is Login) {
      yield AuthLoading();
      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));
        yield AuthAuthenticated('fake_token');
      } catch (e) {
        yield AuthError('فشل تسجيل الدخول');
      }
    } else if (event is Logout) {
      yield AuthUnauthenticated();
    }
  }
}

