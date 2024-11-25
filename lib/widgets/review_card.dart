import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class ReviewOfPatient extends StatelessWidget {
  const ReviewOfPatient({super.key});
  final int rating = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Color.fromRGBO(237, 238, 241, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(rating, (index) {
              return Image.asset(
                'assets/images/star_icon.png', // Replace with your filled star asset path
                width: 24,
                height: 24,
              );
            }),
          ),
          SizedBox(height: 16),
          Text(
            "Such31 31431234 423242423142314231432142134321414341324M43324 1 432142134is album is still my favorite.",
            style: TextStyle(fontSize: 14),
          ),
          Spacer(),
          Text(
            'Rahul Verma',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
