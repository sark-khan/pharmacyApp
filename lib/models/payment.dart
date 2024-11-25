import 'dart:convert';

List<PaymentData> appoinmentFromJson(String str) => List<PaymentData>.from(
    json.decode(str).map((x) => PaymentData.fromJson(x)));

String appoinmentToJson(List<PaymentData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentData {
  String patientName;
  DateTime paymentDateAndTime;
  double amount;
  String opdNumber;
  String taxationNumber;
  String status;

  PaymentData(
      {required this.patientName,
      required this.paymentDateAndTime,
      required this.amount,
      required this.opdNumber,
      required this.taxationNumber,
      required this.status});

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        patientName: json["patientName"],
        paymentDateAndTime: DateTime.parse(json["paymentDateAndTime"]),
        amount: json["amount"]?.toDouble(),
        opdNumber: json["opdNumber"],
        taxationNumber: json["taxationNumber"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "patientName": patientName,
        "paymentDateAndTime": paymentDateAndTime.toIso8601String(),
        "amount": amount,
        "opdNumber": opdNumber,
        "taxationNumber": taxationNumber,
        "status": status,
      };
}
