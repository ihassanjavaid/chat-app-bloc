part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {}

class CredentialsEntryEvent extends AuthEvent {
  final String updatedVal;
  final CredentialType type;

  CredentialsEntryEvent(this.updatedVal, this.type);
}

class AuthSuccessEvent extends AuthEvent {
  final AuthUser user;

  AuthSuccessEvent(this.user);
}
