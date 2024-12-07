import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import './apppointment_screen.dart';
import './bottom_navigation_bar.dart';
import '../utils/routes.dart';
import './profile_form_screen.dart';
import './payments_screen.dart';
import '../utils/helper_class.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userDetails = storage.read("userDetails");
    final String fullName = userDetails?["fullName"] ?? "Guest";
    final String email = userDetails?["email"] ?? "";
    return Scaffold(
        backgroundColor: AppColors.doctorScreenBackgroudColor,
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 122,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(5, 102, 211, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, ${StringFunctions.convertToTitleCase(fullName)}",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${StringFunctions.capitalizeFirstLetter(email)}",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.6))),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => AppointmentScreen());
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 16),
                                    child: Container(
                                      height: 52,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                              "assets/images/appoinment_icon.png"),
                                          Text(
                                            "Appoinments",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14)),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => PaymentsScreen());
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 16),
                                    child: Container(
                                      height: 52,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                              "assets/images/payment_icon.png"),
                                          Text(
                                            "Payments",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14)),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ProfileFormScreen());
                        },
                        child: Container(
                          height: 48,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                      "assets/images/appoinment_icon.png"),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Text(
                                    "My Profile",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                  )
                                ],
                              ),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
            selectedIndex:
                AppRoutes.routesIndex[AppRoutes.profileRoute] as int));
  }
}
