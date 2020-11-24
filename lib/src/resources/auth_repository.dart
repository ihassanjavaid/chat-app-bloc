import 'package:flutter/foundation.dart';
import 'package:the_chat_app/src/models/chat_user.dart';

enum AuthType { LOGIN, SIGNUP }

@immutable
abstract class AuthRepository {
  bool authenticate(ChatUser user, AuthType authType);
}

class AuthenticateUser extends AuthRepository {
  ChatUser _user;

  @override
  bool authenticate(ChatUser user, AuthType authType) {
    switch (authType) {
      case AuthType.LOGIN:
        break;

      case AuthType.SIGNUP:
        break;
      default:
        return false;
    }

    // Destroy auth data
    _destroyAuthObject();
    return false;
  }

  void updateCredentials({String email, String password}) {
    // Create user instance if not already existing
  }

  void _destroyAuthObject() => _user = null;
}
