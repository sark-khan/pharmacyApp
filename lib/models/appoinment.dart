import 'dart:convert';

class AppointmentData {
  String doctorName;
  String patient;
  String qpId;
  String status;
  DateTime dateTime;
  String refundStatus;
  bool isRescheduled;
  AppointmentData(
      {required this.doctorName,
      required this.patient,
      required this.qpId,
      required this.status,
      required this.refundStatus,
      required this.dateTime,
      required this.isRescheduled});

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      AppointmentData(
        refundStatus: json["refundStatus"],
        doctorName: json["doctorName"],
        patient: json["patient"],
        qpId: json["qpId"],
        isRescheduled: json["isRescheduled"],
        status: json['status'],
        dateTime: DateTime.parse(json["dateTime"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "doctorName": doctorName,
  //       "patient": patient,
  //       "qpId": qpId,
  //       "status": status,
  //       "appointmentDate": appointmentDate.toIso8601String(),
  //     };
}
