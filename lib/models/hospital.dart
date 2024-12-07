class Hospital {
  final int doctorsCount;
  final String address;
  final String image;
  final bool isAvailableToday;
  final double rating;
  final String slug;
  final String title;

  Hospital({
    required this.doctorsCount,
    required this.rating,
    required this.isAvailableToday,
    required this.slug,
    required this.title,
    required this.image,
    required this.address,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      title:
          json['title'] as String? ?? '', // Default to an empty string if null
      rating: (json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'] as double? ?? 0.0), // Default to 0.0 if null
      isAvailableToday:
          json['isAvailableToday'] as bool? ?? false, // Default to false
      image: json['image'] as String? ?? '', // Default to an empty string
      address: json['address'] as String? ?? '', // Default to an empty string
      slug: json['slug'] as String? ?? '', // Default to an empty string
      doctorsCount: json['DoctorsCount'] as int? ?? 0,
    ); // Default to 0 if null
  }
}
