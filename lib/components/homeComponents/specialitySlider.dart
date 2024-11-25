import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialtySlider extends StatelessWidget {
  // Sample data for each specialty item
  final List<Map<String, dynamic>> specialties = [
    {
      'icon': Icons.psychology,
      'label': 'Neurology',
      'color': Colors.amber.shade100,
    },
    {
      'icon': Icons.pregnant_woman,
      "label": "Obstetrics",
      'color': Colors.orange.shade100,
    },
    {
      'icon': Icons.accessibility,
      'label': 'Orthopedics',
      'color': Colors.orange.shade100,
    },
    {
      'icon': Icons.face_retouching_natural,
      'label': 'Dermatology',
      'color': Colors.green.shade100,
    },
    {
      'icon': Icons.child_friendly,
      'label': 'Gynecology',
      'color': Colors.purple.shade100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      child: Padding(
        padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: 12),
          itemCount: specialties.length,
          itemBuilder: (context, index) {
            return Container(
              width: 110,
              height: 96,
              decoration: BoxDecoration(
                color: specialties[index]['color'],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    specialties[index]['icon'],
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8),
                  Text(
                    specialties[index]['label'],
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
