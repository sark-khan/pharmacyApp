class Doctor {
  final String name;
  final double rating;
  final int fee;
  final String department;
  final String experience;
  final String hospital;
  final String city;
  final String state;
  final bool isAvailableToday;

  Doctor(
      {required this.name,
      required this.rating,
      required this.fee,
      required this.department,
      required this.experience,
      required this.isAvailableToday,
      required this.hospital,
      required this.city,
      required this.state});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] as String,
      rating:
          (json['rating'] as num).toDouble(), // Ensures the rating is a double
      fee: json['fee'] as int,
      department: json['department'] as String,
      experience: json['experience'] as String,
      isAvailableToday: json['isAvailableToday'] as bool,
      city: json['city'] as String,
      hospital: json['hospital'] as String,
      state: json['state'] as String,
    );
  }
}
