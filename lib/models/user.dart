class User {
  int? userId;
  String? name;
  String? icNumber;
  String? phone;
  String? type;
  String? token;
  String? renewalToken;
  String? email;

  User({this.userId, this.name, this.icNumber, this.phone, this.email, this.type, this.token, this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return new User(
        userId: responseData['id'],
        name: responseData['name'],
        icNumber: responseData['icNumber'],
        phone: responseData['phone'],
        email: responseData['email'],
        type: responseData['type'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']
    );
  }
}