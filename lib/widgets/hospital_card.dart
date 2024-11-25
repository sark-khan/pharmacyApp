import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../models/hospital.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  bool forHomeScreen = false;
  HospitalCard(
      {super.key, required this.hospital, required this.forHomeScreen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                forHomeScreen ? Color.fromRGBO(241, 244, 248, 1) : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  "https://thumbs.dreamstime.com/b/hospital-building-modern-parking-lot-59693686.jpg",
                  height: 148,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${hospital.name}",
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "${hospital.city}, ${hospital.state}",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
              SizedBox(height: 8),
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
                      color: forHomeScreen
                          ? Colors.white
                          : AppColors.doctorScreenBackgroudColor,
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
                          "${hospital.rating}",
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
                  Text(
                    "${hospital.noOfDoctors}+ Doctors",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          top: 152,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(228, 255, 223, 1),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: Text(
              "Open Today",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(27, 191, 0, 1),
              ),
            ),
          ),
        )
      ],
    );
  }
}
