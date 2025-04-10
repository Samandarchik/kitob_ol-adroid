class UserDataModel {
  final String name;
  final String lastName;
  final String birthday;
  final String number;
  final String email;
  final String? imageUrl;
  final String role;

  UserDataModel(
    this.name,
    this.lastName,
    this.birthday,
    this.number,
    this.email,
    this.imageUrl,
    this.role,
  );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      json["first_name"] ?? "null",
      json["last_name"] ?? "null",
      json["date_of_birth"] ?? "null",
      json["phone_number"] ?? "null",
      json["email"] ?? "null",
      json["image_url"] ?? "null",
      json["role"] ?? "null",
    );
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
