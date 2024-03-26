class Users {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? phone;

  Users(
      {this.id,
      this.username,
      required this.email,
      required this.password,
      this.phone});
}
