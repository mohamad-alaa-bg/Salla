class LoginData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;

  LoginData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory LoginData.fromJson(dataResponse) {
    return LoginData(
            id: dataResponse['id'],
            name: dataResponse['name'],
            email: dataResponse['email'],
            phone: dataResponse['phone'],
            image: dataResponse['image'],
            points: dataResponse['points'],
            credit: dataResponse['credit'],
            token: dataResponse['token'],
          );
  }
}
