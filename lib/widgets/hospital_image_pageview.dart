import 'package:flutter/material.dart';

class HospitalImagePageview extends StatelessWidget {
  const HospitalImagePageview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 246,
      child: PageView(
        children: [
          Image.asset('assets/images/hospital1.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/hospital2.jpg', fit: BoxFit.cover),
        ],
      ),
    );
  }
}
