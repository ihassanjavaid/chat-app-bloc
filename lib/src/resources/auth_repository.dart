import 'package:flutter/foundation.dart';
import 'package:the_chat_app/src/models/auth_model.dart';

enum AuthType { LOGIN, SIGNUP }
enum CredentialType { Username, Password }

@immutable
abstract class AuthRepository {
  bool authenticate(AuthUser user, AuthType authType);
}

class AuthenticateUser extends AuthRepository {
  @override
  bool authenticate(AuthUser user, AuthType authType) {
    switch (authType) {
      case AuthType.LOGIN:
        break;

      case AuthType.SIGNUP:
        break;
      default:
        return false;
    }

    return false;
  }
}
