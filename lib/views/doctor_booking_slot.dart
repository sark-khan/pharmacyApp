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

class DoctorBookingSlot extends StatelessWidget {
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
              0.75, // Open at 60% of the screen height
          child: DocterDetailsBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: AppColors.doctorScreenBackgroudColor,
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
                    padding: EdgeInsets.all(16),
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
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        CalendarWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.primary),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
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
                                  "Add Patient Info",
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
                                SizedBox(
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        )
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
}
