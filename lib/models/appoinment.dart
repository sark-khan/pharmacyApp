import 'dart:convert';

class AppointmentData {
  String doctorName;
  String patientName;
  String appointmentId;
  String status;
  DateTime appointmentDate;

  AppointmentData({
    required this.doctorName,
    required this.patientName,
    required this.appointmentId,
    required this.status,
    required this.appointmentDate,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      AppointmentData(
        doctorName: json["doctorName"],
        patientName: json["patientName"],
        appointmentId: json["appointmentId"],
        status: json['status'],
        appointmentDate: DateTime.parse(json["appointmentDate"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "doctorName": doctorName,
  //       "patientName": patientName,
  //       "appointmentId": appointmentId,
  //       "status": status,
  //       "appointmentDate": appointmentDate.toIso8601String(),
  //     };
}
