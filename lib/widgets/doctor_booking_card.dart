import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/helper_class.dart';
import '../utils/colors.dart';
import '../models/doctor.dart';
import '../utils/app_constant.dart';
import 'package:get/get.dart';
import '../views/doctor_booking_slot.dart';

class DoctorBookingCard extends StatelessWidget {
  final Doctor doctor;
  DoctorBookingCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.doctorScreenBackgroudColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          // Doctor's Image
          Container(
            child: Stack(children: [
              Container(
                height: 90,
                width: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8.0), // Ensures the image follows the same border radius
                  child: Image.network(
                    doctor.image.isNotEmpty
                        ? "${AppConstant.ImageDomain}/${doctor.image}"
                        : "${AppConstant.ImageDomain}/doctor-fallback.jpg",
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: 5,
                child: Container(
                  height: 24,
                  width: 24,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  child: doctor.isAvailableToday == true
                      ? SvgPicture.asset(
                          'assets/images/available_icon_green.svg',
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          'assets/images/available_icon_red.svg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ]),
          ),
          const SizedBox(width: 10.0),
          // Doctor's Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${doctor.honorific} ${StringFunctions.convertToTitleCase(doctor.name)}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${doctor.department} • ${doctor.experienceCount ?? 1}+ Years",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    // Rating
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            "assets/images/star_icon.svg",
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            "${doctor.rating}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    // Consultation Fee
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      width: 61,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/ruppe_icon.svg"),
                          Text(
                            "${doctor.appointmentPrice}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(0, 0, 0, 0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => DoctorBookingSlot(
                              slug: doctor.slug,
                            ));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(5, 102, 211, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          height: 30,
                          child: Center(
                            child: Text(
                              "Book",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
