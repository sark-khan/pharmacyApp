import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroComponent extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Color(0xFF0566D3), // Background color of the container
          gradient: LinearGradient(
            colors: [
              AppColors.primaryLight, // Top right ellipse color
              AppColors.primary, // Bottom solid background color
            ],
            stops: [
              0.10,
              1.0
            ], // Spread the first color to 25%, then transition to the second color
            begin: Alignment.topRight, // Start from the top right
            end:
                Alignment.bottomCenter, // End the gradient at the bottom center
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36))),
      height: 410.5,
      padding: EdgeInsets.only(top: 60, left: 28, right: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        'assets/images/location_icon.png',
                        color: Colors
                            .white, // Optional: Apply a color tint if needed
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => Row(
                              children: [
                                Text(
                                  controller.location.value,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white),
                              ],
                            )),
                        Text(
                          "Location",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: AppColors.subtitle)),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(5), // 5px padding
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(8), // Radius of 8
                    ),
                    height: 50,
                    width: 50,
                    child: Container(
                      child: Image.asset(
                        'assets/images/doctor_placeholder.jpg',

                        fit: BoxFit
                            .cover, // Ensures the image covers the container
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 44),
          Text(
            "Welcome Back",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            )),
          ),
          SizedBox(height: 10),
          Text(
            "Let’s find\nyour best doctor!",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            )),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.searchBarBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            height: 58.5,
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: AppColors.subtitle),
                hintText: 'Search doctors, hospitals & services...',
                hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: AppColors.subtitle,
                )),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
