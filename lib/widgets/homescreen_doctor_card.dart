import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../models/doctor.dart';

class HomeScreenDoctorCard extends StatelessWidget {
  final Doctor doctor;
  const HomeScreenDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: AppColors.doctorScreenBackgroudColor,
      ),
      child: Row(
        children: [
          // Doctor's Image
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage("assets/images/doctor_placeholder.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          // Doctor's Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${doctor.name}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${doctor.department} • ${doctor.experience}+ Years",
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
                          Image.asset(
                            "assets/images/star_icon.png",
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
                          Image.asset("assets/images/ruppe_icon.png"),
                          Text(
                            "${doctor.fee}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(0, 0, 0, 0.8),
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
        ],
      ),
    );
  }
}


//  Positioned(
//             top: -10,
//             right: 28,
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(228, 255, 223, 1),
//                 borderRadius: BorderRadius.circular(14.0),
//                 border: Border.all(width: 2, color: Colors.white),
//               ),
//               child: Text(
//                 "Available Today",
//                 style: GoogleFonts.poppins(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                   color: Color.fromRGBO(27, 191, 0, 1),
//                 ),
//               ),
//             ),
//           ),