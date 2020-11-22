import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:the_chat_app/src/models/user_model.dart';
import 'package:the_chat_app/src/resources/services/auth_service.dart';

/*enum MessageType {
  announcement,
  privateMessage,
}*/

Future<void> checkInternConnection() async {
  final ConnectivityResult connectivityStatus =
      await (Connectivity().checkConnectivity());

  if (connectivityStatus == ConnectivityResult.none)
    throw 'No internet connection';
}

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> registerUser({@required ChatUser chatUser}) async {
    await checkInternConnection();

    DocumentReference documentReference = _firestore.collection('users').doc();
    await documentReference.set(chatUser.toMap());
  }

  Future<ChatUser> getUserData() async {
    ChatUser chatUser;
    final email = Auth().getCurrentUser();

    await checkInternConnection();

    final userDocuments = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (var userDocument in userDocuments.docs) {
      chatUser = ChatUser.fromMap(userDocument.data());
    }

    return chatUser;
  }
}
