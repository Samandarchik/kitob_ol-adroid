import 'dart:convert';

class JobModel {
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

  JobModel({
    required this.id,
    required this.publisherName,
    required this.title,
    required this.description,
    required this.status,
    required this.salaryFrom,
    required this.salaryTo,
    required this.cityName,
    required this.createdAt,
    required this.districtName,
    required this.phoneNumber,
    required this.viewCount,
    required this.workingStyles,
    required this.workingTypes,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json["id"] ?? "",
      publisherName: json["vacancy_publisher_name"] ?? "",
      title: json["vacancy_title"] ?? "",
      description: json["vacancy_description"] ?? "",
      status: json["status"] ?? "",
      salaryFrom: int.tryParse(json['salary_from'].toString()) ?? 0,
      salaryTo: int.tryParse(json['salary_to'].toString()) ?? 0,
      cityName: _parseJsonField(json, 'vacancy_city_name'),
      districtName: _parseJsonField(json, 'vacancy_district_name'),
      phoneNumber: json["phone_number"] ?? "",
      viewCount: json["vacancy_view_count"] ?? 0,
      workingStyles: json["working_styles"] ?? "",
      workingTypes: json["working_types"] ?? "",
      createdAt: json["vacancy_created_at"] ?? "",
    );
  }

  /// JSON stringlarni Map sifatida qaytaruvchi yordamchi funksiya
  static Map<String, String> _parseJsonField(
      Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key)
          ? Map<String, String>.from(jsonDecode(json[key]))
          : {};
    } catch (e) {
      return {};
    }
  }
}
