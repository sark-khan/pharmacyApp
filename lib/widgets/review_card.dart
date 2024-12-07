import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class ReviewOfPatient extends StatelessWidget {
  final Map<String, dynamic> data;
  ReviewOfPatient({super.key, required this.data});

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
            children: List.generate(data["rating"] ?? 1, (index) {
              return Image.asset(
                'assets/images/star_icon.png', // Replace with your filled star asset path
                width: 24,
                height: 24,
              );
            }),
          ),
          SizedBox(height: 16),
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: Text(
                maxLines: 10,
                data['comment'] ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            data["user"]?["fullName"] ?? "",
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
