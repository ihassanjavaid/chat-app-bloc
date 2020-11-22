class User {
  final String firstName;
  final String lastName;
  final String email;

  User(this.firstName, this.lastName, this.email);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.email == email;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ email.hashCode;

  @override
  String toString() =>
      'User(firstName: $firstName, lastName: $lastName, email: $email)';
}
