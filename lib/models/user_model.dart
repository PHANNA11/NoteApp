class User {
  late int id;
  late String userName;
  late String email;
  late String password;
  //late String image;
  User({
    required this.id,
    required this.email,
    required this.password,
    required this.userName,
  });
  Map<String, dynamic> fromJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }

  User.toJson(Map<String, dynamic> res)
      : id = res['id'],
        userName = res['userName'],
        email = res['email'],
        password = res['password'];

  // User.toJson(Map<String, dynamic> res)
  //     : id = res['id'],
  //       userName = res['userName'],
  //       email = res['email'],
  //       password = res['password'];
}
