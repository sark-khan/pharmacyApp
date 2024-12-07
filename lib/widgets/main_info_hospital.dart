import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../controllers/hostpital_detaill_screen.dart';
import '../utils/helper_class.dart';

class MainInfoOfHospital extends StatelessWidget {
  final HospitalDetailsController controller =
      Get.find<HospitalDetailsController>(tag: "HospitalDetailScreen");
  MainInfoOfHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 216),
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.black, width),
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(217, 217, 217, 0.6)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringFunctions.convertToTitleCase(
                              controller.hospitalDetails["title"]),
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          StringFunctions.convertToTitleCase(
                              controller.hospitalDetails["location"]),
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 56,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.doctorScreenBackgroudColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/star_icon.png",
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "${controller.hospitalDetails["rating"] ?? 0}",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 30,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: controller
                                        .hospitalDetails["isAvailableToday"] ==
                                    true
                                ? Color.fromRGBO(218, 255, 211, 1)
                                : Color.fromRGBO(255, 216, 216, 1)),
                        child: Center(
                          child: Text(
                            controller.hospitalDetails["isAvailableToday"] ==
                                    true
                                ? "Open"
                                : "Closed",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: controller.hospitalDetails[
                                          "isAvailableToday"] ==
                                      true
                                  ? Color.fromRGBO(27, 191, 0, 1)
                                  : Color.fromRGBO(255, 0, 0, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 1,
              color: Color.fromRGBO(5, 102, 211, 0.2),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.hospitalDetails["doctorsCount"] ?? 0}+ Doctors",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 0.92),
                    )),
                  ),
                  Text(
                    controller.hospitalDetails?["departmentDetails"]
                            ?.map((ele) => ele["title"])
                            .join(", ")
                            .toString() ??
                        "",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
