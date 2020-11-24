import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_chat_app/src/models/auth_model.dart';
import 'package:the_chat_app/src/resources/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRespository;
  AuthUser _authUser;

  AuthBloc(this._authRespository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is RegisterEvent) {
      // Show registration page contents
      yield AuthRegister();
    } else if (event is AuthSuccessEvent) {
      final AuthUser user = event.user;

      yield AuthSuccess(user);
    } else if (event is CredentialsEntryEvent) {
      final type = event.type;
      final val = event.updatedVal;

      if (type == CredentialType.Username)
        _authUser.username = val;
      else
        _authUser.setPassword = val;
    } else if (event is LoginEvent) {
      yield AuthLoading();

      final flag = _authRespository.authenticate(_authUser, AuthType.LOGIN);

      if (flag) {
        yield AuthSuccess(_authUser);
      } else {
        yield AuthInitial();
      }
    }
  }
}
