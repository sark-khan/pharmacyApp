import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import "../models/appoinment.dart";
import "package:intl/intl.dart";

class AppointmentCard extends StatelessWidget {
  final AppointmentData appointmentData;
  const AppointmentCard({super.key, required this.appointmentData});

  String getFormattedDate(DateTime date) {
    print(date);
    String formattedDate = DateFormat('EEE, MMM dd, hh:mm a').format(date);
    print(formattedDate);
    return formattedDate;
  }

  Color getStatusBackGroundColor(String status) {
    print(appointmentData.appointmentDate);
    if (status == "Completed") return Color(0xFFD4FFCD);
    if (status == "Scheduled") return Color(0xFFFFF9C5);
    if (status == "Cancelled") return Color(0xFFFFD8D8);
    return Colors.amber;
  }

  Color getStatusColor(String status) {
    if (status == "Completed") return Color(0xFF1BBF00);
    if (status == "Scheduled") return Color(0xFFFFC700);
    if (status == "Cancelled") return Color(0xFFFF0000);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    appointmentData.appointmentId,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: getStatusBackGroundColor(appointmentData.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    appointmentData.status,
                    style: TextStyle(
                      color: getStatusColor(appointmentData.status),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
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
                  text: appointmentData.doctorName,
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
          SizedBox(height: 10),
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
                  text: getFormattedDate(appointmentData.appointmentDate),
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
          SizedBox(height: 8),
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
                    text: appointmentData.patientName,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textLightBlack),
                    )),
              ],
            ),
          ),
          appointmentData.status == "Scheduled"
              ? SizedBox(
                  height: 10,
                )
              : SizedBox(),
          appointmentData.status == "Scheduled"
              ? Container(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Color.fromRGBO(255, 199, 0, 0.2)),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/images/reschedule_icon.png"),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Reschedule",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(242, 116, 0, 1))),
                                ),
                              ],
                            ) // Add content here
                            ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Color.fromRGBO(255, 50, 50, 1)),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/cancel_icon.png"),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Cancel",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(
                                              255, 243, 243, 1))),
                                ),
                              ],
                            ) // Add content here
                            ),
                      ),
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
