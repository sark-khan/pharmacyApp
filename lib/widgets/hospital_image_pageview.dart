import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hostpital_detaill_screen.dart';
import '../utils/app_constant.dart';

class HospitalImagePageview extends StatelessWidget {
  HospitalImagePageview({super.key});
  final HospitalDetailsController controller =
      Get.find<HospitalDetailsController>(tag: "HospitalDetailScreen");
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 246,
      child: PageView(
        children: [
          Image.network(
            (controller.hospitalDetails?["image"]?.isNotEmpty ?? false)
                ? "${AppConstant.ImageDomain}/${controller.hospitalDetails["image"]}"
                : "${AppConstant.ImageDomain}/fallback-Hospital.jpg",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
