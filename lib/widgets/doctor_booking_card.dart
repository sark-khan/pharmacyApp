import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class DoctorBookingCard extends StatelessWidget {
  const DoctorBookingCard({super.key});

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/doctor_placeholder.jpg"),
                    fit: BoxFit.cover,
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
                  child: Image.asset(
                    'assets/images/available_icon_red.png',
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
                  "Dr. Jeevan singh",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Sexiologist • 8+ Years",
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
                            "4.2",
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
                            "250",
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
                    Container(
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
