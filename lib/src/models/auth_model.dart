import 'package:the_chat_app/src/models/chat_user.dart';

class AuthUser {
  static AuthUser _authUser;
  ChatUser _chatUser;
  String _password;

  String get username => _chatUser.email;
  String get password => _password;

  set username(String val) => _chatUser.email = val;
  set setPassword(String val) => _password = val;

  static AuthUser getInstance() {
    if (_authUser == null) {
      _authUser = AuthUser._internal();
    }

    return _authUser;
  }

  AuthUser._internal() {
    _chatUser = ChatUser('firstName', 'lastName', 'email');
  }
}
