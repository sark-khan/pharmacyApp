class Doctor {
  final String id;
  final int appointmentPrice;
  final String department;
  final int experienceCount;
  final String gender;
  final String honorific;
  final String hospitalName;
  final String hospitalSlug;
  final String image;
  final bool isAvailableToday;
  final String name;
  final String qpId;
  final double rating;
  final String slug;
  final int totalAppointments;

  // Non-final, optional fields
  String? departmentSlug;
  String? hospitalAddress;
  double? hospitalRating;

  Doctor({
    required this.id,
    required this.name,
    required this.image,
    required this.qpId,
    required this.slug,
    required this.honorific,
    required this.gender,
    required this.appointmentPrice,
    required this.experienceCount,
    required this.department,
    required this.rating,
    required this.totalAppointments,
    required this.hospitalName,
    required this.hospitalSlug,
    required this.isAvailableToday,
    this.departmentSlug,
    this.hospitalAddress,
    this.hospitalRating,
  });

  // From JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      qpId: json['qpId'] ?? '',
      slug: json['slug'] ?? '',
      honorific: json['honorific'] ?? '',
      gender: json['gender'] ?? '',
      appointmentPrice: json['appointmentPrice'] ?? 0,
      experienceCount: json['experienceCount'] ?? 0,
      department: json['department'] ?? '',
      rating: (json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'] ?? 0.0) as double,
      totalAppointments: json['totalAppointments'] ?? 0,
      hospitalName: json['hospitalName'] ?? '',
      hospitalSlug: json['hospitalSlug'] ?? '',
      image: json['image'] ?? '',
      isAvailableToday: json['isAvailableToday'] ?? false,
      departmentSlug: json['departmentSlug'],
      hospitalAddress: json['hospitalAddress'],
      hospitalRating: (json['hospitalRating'] is int
          ? (json['hospitalRating'] as int).toDouble()
          : json['hospitalRating']) as double?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'qpId': qpId,
      'slug': slug,
      'honorific': honorific,
      'gender': gender,
      'appointmentPrice': appointmentPrice,
      'experienceCount': experienceCount,
      'department': department,
      'rating': rating,
      'totalAppointments': totalAppointments,
      'hospitalName': hospitalName,
      'hospitalSlug': hospitalSlug,
      'isAvailableToday': isAvailableToday,
      'departmentSlug': departmentSlug,
      'hospitalAddress': hospitalAddress,
      'hospitalRating': hospitalRating,
    };
  }
}
