class ApiUser {
  final String email;
  final String userName;
  final String userSurName;
  final String phone;
  final String photoPath;

  ApiUser.fromApi(Map<String, dynamic> map)
      : email = map['email'],
        userName = map['name'],
        userSurName = map['surName'],
        phone = map['phone'],
        photoPath = map['profilePic'];
}