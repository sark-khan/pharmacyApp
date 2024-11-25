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

class HospitalPage extends StatelessWidget {
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
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 6),
                        itemCount: specialties.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 28,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 244, 245, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${specialties[index]}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      height: 586,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: DoctorBookingCard(),
                            onTap: () {
                              _showFilterBottomSheet(context);
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "About",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  "जीवन रक्षा हॉस्पिटल एवं ट्रोमा सेंटर में हड्डी और जोड़ों के रोग के योग्य और अनुभवी विशेषज्ञ चौबीसों घंटे व्यापक सेवाएं प्रदान करते हैं। हम यह सुनिश्चित करते हैं कि आपको हड्डी और जोड़ों से जुड़े हुए रोग का सर्वोत्तम उपचार और देखभाल मिले।",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          height: 26 / 14,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                "Reviews",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 200,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 16),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ReviewOfPatient();
                                  },
                                  // shrinkWrap:
                                  //     true, // Allow ListView to shrink to its content
                                ),
                              ),
                            ]))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
