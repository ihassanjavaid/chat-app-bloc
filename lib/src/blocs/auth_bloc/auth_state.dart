part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLogin extends AuthState {}

class AuthRegister extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ChatUser user;

  AuthSuccess(this.user);
}
