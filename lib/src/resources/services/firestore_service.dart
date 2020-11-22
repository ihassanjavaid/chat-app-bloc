import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:the_chat_app/src/models/user_model.dart';

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

  Future<ChatUser> getUserData(String email) async {
    ChatUser chatUser;

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

  // Future<List<ChatUser>> getAllUsers() async {
  //   List<ChatUser> users = [];

  //   await checkInternConnection();

  //   // Get current user
  //   final currentUser = await _auth.currentUser;

  //   // Fetch all users
  //   final userDocuments = await _firestore.collection('users').getDocuments();

  //   // Get each user
  //   for (var user in userDocuments.documents) {
  //     if (user['email'] != currentUser.email) {
  //       UserData userData = UserData(
  //         displayName: user['displayName'],
  //         email: user['email'],
  //         //isAdmin: user['isAdmin']
  //       );
  //       users.add(userData);
  //     }
  //   }
  //   return users;
  // }

/*Future<void> postMessage(
      {String messageTitle,
      String messageText,
      String receiverEmail,
      String imageReference,
      MessageType messageType}) async {
    await checkInternConnection();

    final DocumentReference documentReference =
        _firestore.collection('messages').document();

    await documentReference.setData({
      'imageReference': imageReference,
      'messageTitle': messageTitle,
      'messageText': messageText,
      'messageType': messageType == MessageType.announcement
          ? 'announcement'
          : 'privateMessage',
      'receiverEmail': receiverEmail,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    }, merge: true);
  }*/

}
