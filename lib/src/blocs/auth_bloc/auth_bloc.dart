import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_chat_app/src/models/chat_user.dart';
import 'package:the_chat_app/src/resources/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRespository;

  AuthBloc(this._authRespository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is RegisterEvent) {
      // Show registration page contents
      yield AuthRegister();
    } else if (event is AuthSuccessEvent) {
      final ChatUser user = event.user;

      yield AuthSuccess(user);
    }
  }
}
