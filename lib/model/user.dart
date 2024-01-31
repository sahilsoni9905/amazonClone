class User {
  final String id;
  final String name;
  final String password;
  final String address;
  final String type;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.address,
      required this.type,
      required this.token});
}
