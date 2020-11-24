import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:the_chat_app/src/models/auth_model.dart';
import 'package:the_chat_app/src/models/chat_user.dart';
import 'package:the_chat_app/src/resources/services/auth_service.dart';
import 'package:the_chat_app/src/resources/services/firestore_service.dart';

enum AuthType { LOGIN, GLogin, AppleLogin, SIGNUP }
enum CredentialType { Username, Password }

@immutable
abstract class AuthRepository {
  Future<bool> authenticate(AuthUser user, AuthType authType);
}

class AuthenticateUser extends AuthRepository {
  @override
  Future<bool> authenticate(AuthUser user, AuthType authType,
      [ChatUser chatUser]) async {
    final Auth _auth = Auth();
    final FirestoreService _firestoreService = FirestoreService();

    switch (authType) {
      case AuthType.LOGIN:
        try {
          await _auth.loginUserWithEmailAndPassword(
              email: _removeSpaces(user.username), password: user.password);
          return true;
        } catch (_) {
          return false;
        }

        break;

      case AuthType.GLogin:
        try {
          await _auth.signInWithG();
          return true;
        } catch (_) {
          return false;
        }

        break;

      case AuthType.AppleLogin:
        if (await AppleSignIn.isAvailable()) {
          final AuthorizationResult result = await AppleSignIn.performRequests([
            AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
          ]);
          switch (result.status) {
            case AuthorizationStatus.authorized:
              print(result.credential.user);

              await _firestoreService.registerUser(
                  chatUser: ChatUser(
                      result.credential.fullName.givenName,
                      result.credential.fullName.familyName,
                      result.credential.email));
              return true;
              break;

            case AuthorizationStatus.error:
              return false;
              break;

            case AuthorizationStatus.cancelled:
              break;
          }
        }
        break;

      case AuthType.SIGNUP:
        try {
          await _auth.registerUser(
              email: _removeSpaces(user.username), password: user.password);

          await _firestoreService.registerUser(
              chatUser: ChatUser(
            chatUser.firstName,
            chatUser.lastName,
            chatUser.email,
          ));
        } catch (_) {}
        break;

      default:
        return false;
    }

    return false;
  }

  void initializeAuth() {
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {});
    }
  }

  String _removeSpaces(String email) => email.replaceAll(' ', '');
}
