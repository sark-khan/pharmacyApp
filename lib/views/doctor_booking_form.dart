import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import './bottom_navigation_bar.dart';
import '../widgets/main_info_hospital.dart';
import '../widgets/doctor_booking_card.dart';
import '../widgets/review_card.dart';
import "../widgets/doctor_details_bottom_sheet.dart";
import '../widgets/hospital_image_pageview.dart';
import './dateCalender.dart';

class DoctorBookingForm extends StatefulWidget {
  @override
  State<DoctorBookingForm> createState() => _DoctorBookingFormState();
}

class _DoctorBookingFormState extends State<DoctorBookingForm> {
  bool isForSomeoneElse = false;
  final List<String> specialties = [
    "All",
    "Cardioly",
    "OrthoPodcas",
    "Surgery",
    "GynoCology"
  ];

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height *
              0.75, // oppen  75% of the screen height
          child: DocterDetailsBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            children: [
              HospitalImagePageview(),
              Column(
                children: [
                  MainInfoOfHospital(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.doctorScreenBackgroudColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                height: 48,
                                width: 48,
                                child: Image.asset(
                                  "assets/images/doctor_placeholder.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Vikas Pareek",
                                    style: GoogleFonts.poppins(
                                        height: 24 / 16,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Cardiology • 7+ Years Experience",
                                    style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        height: 16 / 12,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _showFilterBottomSheet(context);
                                },
                                child: Container(
                                  width: 12.08,
                                  height: 7.24,
                                  child: Image.asset(
                                    "assets/images/arrow_down.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          "Tue,Aug 23,2024  • 12:30 PM",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 30 / 14),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.doctorScreenBackgroudColor),
                          child: Row(
                            children: [
                              Container(
                                height: 12,
                                child: Image.asset(
                                  "assets/images/arrow_back.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Text("Change Slot",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromRGBO(27, 43, 58, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 30 / 14))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Toggle Switch
                        Row(
                          children: [
                            Transform.scale(
                              scaleX: 0.8,
                              scaleY: 0.8,
                              child: Switch(
                                activeColor: Colors
                                    .white, // Thumb color when the switch is ON
                                activeTrackColor: AppColors
                                    .primary, // Track color when the switch is ON
                                inactiveThumbColor: Color.fromRGBO(
                                    208,
                                    218,
                                    227,
                                    1), // Thumb color when the switch is OFF
                                inactiveTrackColor: Colors.grey.shade100,
                                value: isForSomeoneElse,
                                onChanged: (value) {
                                  setState(() {
                                    isForSomeoneElse = value;
                                  });
                                },
                              ),
                            ),
                            Text("For Someone Else",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    height: 20 / 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Patient Name
                        buildTextField("Patient Name"),
                        SizedBox(height: 10),

                        // Age and Gender
                        Row(
                          children: [
                            Expanded(
                              child: buildTextField("Age"),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: buildTextField("Gender"),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Father/Husband Name
                        buildTextField("Father/Husband Name"),
                        SizedBox(height: 10),
                        buildTextField("Phone Number"),
                        SizedBox(height: 10),
                        buildExpandableField("Address"),

                        // TextField(
                        //   decoration: InputDecoration(
                        //     labelText: "Address",
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   maxLines: 2,
                        // ),
                        SizedBox(height: 10),

                        buildTextField("City"),

                        SizedBox(height: 10),

                        // Pincode
                        buildTextField("Pin Code"),

                        SizedBox(height: 10),

                        buildExpandableField("Comments"),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.primary),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // SizedBox(
                              //   width: 40,
                              // ),
                              Container(
                                height: 16,
                                width: 10,
                                child: Image.asset(
                                  "assets/images/ruppe_icon_white.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "250",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    height: 24 / 18),
                              ),
                              Spacer(),
                              Text(
                                "Pay & Book Slot",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    height: 16 / 16),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                height: 16,
                                width: 16,
                                child: Image.asset(
                                  "assets/images/arrow_forward_white.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // SizedBox(
                              //   width: 40,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
            selectedIndex:
                AppRoutes.routesIndex[AppRoutes.HospitalsRoute] as int));
  }

  Widget buildTextField(String hintText) {
    return SizedBox(
      height: 36,
      child: TextField(
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 20 / 12,
                fontSize: 12)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color.fromRGBO(113, 125, 136, 1),
                  fontWeight: FontWeight.w400,
                  height: 20 / 12,
                  fontSize: 12)),
          isDense: true, // Reduces the overall height
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1.5, color: Color.fromRGBO(208, 218, 227, 1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1.5, color: Color.fromRGBO(208, 218, 227, 1)),
          ),
        ),
      ),
    );
  }

  Widget buildExpandableField(String hintText) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 72, // Minimum height of the container
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.5,
          color: Color.fromRGBO(208, 218, 227, 1),
        ),
      ),
      child: TextField(
        minLines: 1, // Minimum number of lines (allows initial height)
        maxLines: null, // Expands dynamically based on content
        keyboardType: TextInputType.multiline, // Allows multi-line input
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            height: 20 / 12,
            fontSize: 12,
          ),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Color.fromRGBO(113, 125, 136, 1),
              fontWeight: FontWeight.w400,
              height: 20 / 12,
              fontSize: 12,
            ),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          border: InputBorder.none, // Removes all borders from the TextField
          focusedBorder: InputBorder.none, // No border on focus
          enabledBorder: InputBorder.none, // No border when enabled
          disabledBorder: InputBorder.none, // No border when disabled
          errorBorder: InputBorder.none, // No border on error
        ),
      ),
    );
  }

  Widget buildDoubleField(
    String hint1,
    String hint2,
  ) {
    return Row(
      children: [
        Expanded(
          child: buildTextField(hint1),
        ),
        SizedBox(width: 16),
        Expanded(
          child: buildTextField(hint2),
        ),
      ],
    );
  }
}
