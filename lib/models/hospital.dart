class Hospital {
  final double rating;
  final String name;
  final String city;
  final String state;
  final bool isAvailableToday;
  final int noOfDoctors;

  Hospital(
      {required this.name,
      required this.rating,
      required this.isAvailableToday,
      required this.noOfDoctors,
      required this.city,
      required this.state});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
        name: json['name'] as String,
        rating: (json['rating'] as num)
            .toDouble(), // Ensures the rating is a double
        isAvailableToday: json['isAvailableToday'] as bool,
        city: json['city'] as String,
        state: json['state'] as String,
        noOfDoctors: json["noOfDoctors"] as int);
  }
}
