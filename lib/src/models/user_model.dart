import 'dart:convert';

class ChatUser {
  final String firstName;
  final String lastName;
  final String email;

  ChatUser(this.firstName, this.lastName, this.email);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChatUser &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.email == email;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ email.hashCode;

  @override
  String toString() =>
      'User(firstName: $firstName, lastName: $lastName, email: $email)';

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChatUser(
      map['firstName'],
      map['lastName'],
      map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUser.fromJson(String source) =>
      ChatUser.fromMap(json.decode(source));
}
