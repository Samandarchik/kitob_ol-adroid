class UserDataModel {
  final String? name;
  final String? lastName;
  final String? birthday;
  final String? number;
  final String? email;
  final String? imageUrl;
  final String? role;

  UserDataModel({
    this.name,
    this.lastName,
    this.birthday,
    this.number,
    this.email,
    this.imageUrl,
    this.role = "user",
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        name: json['first_name'],
        lastName: json['last_name'],
        birthday: json['date_of_birth'],
        number: json['phone_number'],
        email: json['email'],
        imageUrl: json['image_url'],
        role: json['role']);
  }
  Map<String, dynamic> toJson(String imageUrl) {
    return {
      "first_name": name,
      "last_name": lastName,
      "date_of_birth": birthday,
      "phone_number": number,
      "email": email,
      "image_url": imageUrl,
    };
  }
}
