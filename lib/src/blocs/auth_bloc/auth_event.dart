part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitializeAuth extends AuthEvent {}

class ShowRegisterationEvent extends AuthEvent {}

class ShowLoginEvent extends AuthEvent {}

class AuthenticateEvent extends AuthEvent {
  final AuthType type;

  AuthenticateEvent(this.type);
}

class CredentialsEntryEvent extends AuthEvent {
  final String credential;
  final CredentialType type;

  CredentialsEntryEvent(this.credential, this.type);
}

class RegistrationDataEntry extends AuthEvent {
  final String data;
  final String dataFor;

  RegistrationDataEntry(this.data, this.dataFor);
}
