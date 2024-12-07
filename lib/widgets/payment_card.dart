import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/payment.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentCard extends StatelessWidget {
  final PaymentData paymentData;
  const PaymentCard({super.key, required this.paymentData});

  String getFormattedDate(DateTime date) {
    String formattedDate = DateFormat('EEE, MMM dd, hh:mm a').format(date);
    return formattedDate;
  }

  Color getStatusBackGroundColor(String status) {
    if (status == "success") return Color(0xFFD4FFCD);
    if (status == "pending") return Color(0xFFFFF9C5);
    if (status == "userCancelled" || status == "failure")
      return Color(0xFFFFD8D8);
    return Colors.amber;
  }

  Color getStatusColor(String status) {
    if (status == "success") return Color(0xFF1BBF00);
    if (status == "pending") return Color(0xFFFFC700);
    if (status == "userCancelled" || status == "failure")
      return Color(0xFFFF0000);
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.doctorScreenBackgroudColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "INR ${paymentData.netAmount}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: getStatusBackGroundColor(paymentData.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      paymentData.status,
                      style: TextStyle(
                        color: getStatusColor(paymentData.status),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "OPD No. : ",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )),
                TextSpan(
                  text: paymentData.qpId,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.textLightBlack),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "TXN No. : ",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )),
                TextSpan(
                    text: paymentData.txnNo,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textLightBlack),
                    )),
              ],
            ),
          ),
          SizedBox(height: 2),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "Date & Time : ",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )),
                TextSpan(
                  text: getFormattedDate(paymentData.createdAt),
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.textLightBlack),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "Doctor : ",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )),
                TextSpan(
                    text: "Dr ${paymentData.doctorName}",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textLightBlack),
                    )),
              ],
            ),
          ),
          SizedBox(height: 2),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "Patient : ",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )),
                TextSpan(
                    text: paymentData.patient,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textLightBlack),
                    )),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "Payment Method : ",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )),
                TextSpan(
                    text: "${paymentData.type}",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textLightBlack),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
