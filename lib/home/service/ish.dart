class Ish {
  final String id;
  final String publisherName;
  final String title;
  final String description;
  final String status;
  final int salaryFrom;
  final int salaryTo;
  final String workingStyles;
  final String workingTypes;
  final String phoneNumber;
  final int viewCount;
  final Map<String, String> cityName;
  final Map<String, String> districtName;
  final String createdAt;
  bool isFavorite;

  Ish({
    required this.id,
    required this.publisherName,
    required this.title,
    required this.description,
    required this.status,
    required this.salaryFrom,
    required this.cityName,
    required this.createdAt,
    required this.districtName,
    required this.phoneNumber,
    required this.salaryTo,
    required this.viewCount,
    required this.workingStyles,
    required this.workingTypes,
    required this.isFavorite,
  });

  factory Ish.fromJson(Map<String, dynamic> json) {
    return Ish(
        id: json["id"] ?? "", // Providing default empty string if not present
        publisherName: json["publisher_name"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        salaryFrom:
            json["salary_from"] != null ? json["salary_from"] as int : 0,
        cityName: Map<String, String>.from(json["city_name"] ?? {}),
        createdAt: json["created_at"] ?? "",
        districtName: Map<String, String>.from(json["district_name"] ?? {}),
        phoneNumber: json["phone_number"] ?? "",
        salaryTo: json["salary_to"] != null ? json["salary_to"] as int : 0,
        viewCount: json["view_count"] ?? 4,
        workingStyles: json["working_styles"] ?? "",
        workingTypes: json["working_types"] ?? "",
        isFavorite: json["is_favorite"] ?? true);
  }
}
