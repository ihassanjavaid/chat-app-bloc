import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_chat_app/src/models/auth_model.dart';
import 'package:the_chat_app/src/models/chat_user.dart';
import 'package:the_chat_app/src/resources/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRespository;
  AuthUser _authUser;
  ChatUser _chatUser = ChatUser('firstName', 'lastName', 'email');

  AuthBloc(this._authRespository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is ShowRegisterationEvent) {
      // Show registration page contents
      yield AuthRegister();
    } else if (event is ShowLoginEvent) {
      // Show login page contents
      yield AuthLogin();
    } else if (event is AuthenticateEvent) {
      bool flag;
      yield AuthLoading();

      // Attempt to authenticate
      flag = await _authRespository.authenticate(_authUser, event.type);

      if (flag) {
        // Authentication successful
        yield AuthSuccess();
        _authUser = null;
        AuthUser.destroyInstance();
      } else {
        // Authentication failure
        yield AuthFailed(
            "Authentication failure, did you provide the correct credentials?");
      }
    } else if (event is CredentialsEntryEvent) {
      final type = event.type;
      final val = event.credential;

      if (_authUser == null) _authUser = AuthUser.getInstance();
      try {
        if (type == CredentialType.Username)
          _authUser.username = val;
        else
          _authUser.setPassword = val;
      } catch (err) {
        print(err.toString());
      }
    } else if (event is RegistrationDataEntry) {
      final data = event.data;
      final dataFor = event.dataFor;

      switch (dataFor) {
        case 'first_name':
          _chatUser.firstName = data;
          break;

        case 'last_name':
          _chatUser.lastName = data;
          break;

        case 'email':
          _chatUser.email = data;
          break;
        default:
      }
    }
  }
}
