import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.hospital,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${doctor.city}, ${doctor.state}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                ],
              ),
              // Rating section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 248, 253, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color.fromRGBO(255, 214, 0, 1),
                      size: 24,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${doctor.rating}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Main Container
              Container(
                height: 120,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.doctorScreenBackgroudColor,
                  borderRadius: BorderRadius.circular(12.0),
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
                          image: AssetImage(
                              "assets/images/doctor_placeholder.jpg"),
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
                              fontWeight: FontWeight.w500,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                width: 61,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
              ),
              // Availability Label Positioned at the Top-Right
              Positioned(
                top: -10,
                right: 28,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(228, 255, 223, 1),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Text(
                    "Available Today",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(27, 191, 0, 1),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
