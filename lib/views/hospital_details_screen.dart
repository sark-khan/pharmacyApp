import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/controllers/home_controller.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import './bottom_navigation_bar.dart';
import '../widgets/main_info_hospital.dart';
import '../widgets/doctor_booking_card.dart';
import '../widgets/review_card.dart';
import "../widgets/doctor_details_bottom_sheet.dart";
import '../widgets/hospital_image_pageview.dart';
import '../controllers/hostpital_detaill_screen.dart';
import '../models/doctor.dart';

class HospitalPage extends StatefulWidget {
  final String slug;
  HospitalPage({super.key, required this.slug});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final HospitalDetailsController controller =
      Get.put(HospitalDetailsController(), tag: "HospitalDetailScreen");

  void _showFilterBottomSheet(BuildContext context, String slug) {
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
          child: DocterDetailsBottomSheet(
            slug: slug,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller.fetchHospitalDetails(widget.slug);
    controller.fetchDoctorsList(widget.slug);
    controller.fetchHospitalReviews(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: AppColors.doctorScreenBackgroudColor,
        body: Obx(() {
          if (controller.isLoading == true) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          }
          if (controller.hospitalDetails.isEmpty) {
            return Center(
              child: Text(
                "No Data Found",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.textDarkBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 20 / 16)),
              ),
            );
          }
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
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
                    controller.hospitalDetails?["departmentDetails"].length > 0
                        ? Container(
                            color: Colors.white,
                            height: 55,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 10, bottom: 10),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 6),
                                itemCount: controller
                                        .hospitalDetails["departmentDetails"]
                                        .length +
                                    1,
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
                                        index == 0
                                            ? "All"
                                            : controller.hospitalDetails[
                                                    "departmentDetails"]
                                                [index - 1]["title"] as String,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.6),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                      ));
                                },
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    controller.doctorList.length > 0
                        ? Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Column(
                              children: [
                                for (var doctor in controller.doctorList)
                                  GestureDetector(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: DoctorBookingCard(
                                        doctor: doctor,
                                      ),
                                    ),
                                    onTap: () {
                                      _showFilterBottomSheet(
                                          context, doctor.slug);
                                    },
                                  ),
                                SizedBox(height: 10)
                              ],
                            ),
                          )
                        : SizedBox(),
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
                                Text(controller.hospitalDetails["bio"] ?? "",
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
                                  height: 250,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 16),
                                    itemCount: controller.reviews.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          controller.reviews[index];
                                      return ReviewOfPatient(data: data);
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
          );
        }),
        bottomNavigationBar: BottomNavBar(
            selectedIndex:
                AppRoutes.routesIndex[AppRoutes.HospitalsRoute] as int));
  }
}
