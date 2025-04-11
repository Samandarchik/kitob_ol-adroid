class Language {
  final String id;
  final Map<String, String> name;

  Language({required this.id, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
    );
  }
}

class Author {
  final String id;
  final String name;
  final String surname;
  final String biography;

  Author(
      {required this.id,
      required this.name,
      required this.surname,
      required this.biography});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      biography: json['biography'],
    );
  }
}

class Cities {
  final String id;
  final Map<String, String> name;

  Cities({required this.id, required this.name});

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
    );
  }
}

class Districts {
  final String id;
  final Map<String, String> name;

  Districts({required this.id, required this.name});

  factory Districts.fromJson(Map<String, dynamic> json) {
    return Districts(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
    );
  }
}

class Category {
  final String id;
  final Map<String, String> name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
    );
  }
}

class Publisher {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String type;
  final bool status;

  Publisher(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.type,
      required this.status});

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      type: json['type'],
      status: json['status'].toString() == "true",
    );
  }
}
