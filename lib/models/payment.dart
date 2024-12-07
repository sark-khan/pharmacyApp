class PaymentData {
  String patient;
  String netAmount;
  String qpId;
  String txnNo;
  String status;
  String doctorName;
  DateTime createdAt;
  String type;

  PaymentData(
      {required this.patient,
      required this.netAmount,
      required this.qpId,
      required this.doctorName,
      required this.txnNo,
      required this.status,
      required this.type,
      required this.createdAt});

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        patient: json["patient"] ?? "",
        type: json["type"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        netAmount: json["netAmount"].toString(), // Convert netAmount to String
        qpId: json["qpId"] ?? "",
        txnNo: json["txnNo"] ?? "",
        status: json["status"] ?? "",
        doctorName: json["doctorName"] ?? "",
      );
}
