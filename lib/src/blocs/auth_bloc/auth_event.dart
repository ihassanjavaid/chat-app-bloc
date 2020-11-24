part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {}

class AuthSuccessEvent extends AuthEvent {
  final ChatUser user;

  AuthSuccessEvent(this.user);
}
