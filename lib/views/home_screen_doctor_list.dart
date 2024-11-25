// views/doctor_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../controllers/doctors_screen_controller.dart';
import '../models/doctor.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../components/doctorsComponents/search_results.dart';
import '../widgets/doctor_card.dart';
import './bottom_navigation_bar.dart';
import '../utils/routes.dart';
import '../widgets/homescreen_doctor_card.dart';

// class HomeScreenDoctorList extends StatefulWidget {
//   @override
//   State<HomeScreenDoctorList> createState() => _HomeScreenDoctorListState();
// }

// class _HomeScreenDoctorListState extends State<HomeScreenDoctorList> {
//   late DoctorController controller;
//   final List<String> specialties = [
//     "All",
//     "Cardioly",
//     "OrthoPodcas",
//     "Surgery",
//     "GynoCology"
//   ];
//   @override
//   void initState() {
//     super.initState();
//     // Initialize DoctorController each time HomeScreenDoctorList is shown
//     controller = Get.put(DoctorController(), tag: 'HomeScreenDoctorList');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 24, right: 24),
//             child: Row(
//               children: [
//                 Text(
//                   "Our Medical Specialists",
//                   style: GoogleFonts.poppins(
//                       textStyle:
//                           TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   onTap: () {
//                     Get.toNamed(AppRoutes.DoctorsRoute);
//                   },
//                   child: Text(
//                     "See All",
//                     style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             height: 20 / 14)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 26,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 24),
//             child: Container(
//               color: Colors.white,
//               height: 28,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 separatorBuilder: (context, index) => SizedBox(width: 12),
//                 itemCount: specialties.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                       // height: 28,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: Color.fromRGBO(242, 244, 245, 1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         "${specialties[index]}",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                                 color: Color.fromRGBO(0, 0, 0, 0.6),
//                                 fontWeight: FontWeight.w500,
//                                 height: 12 / 14,
//                                 fontSize: 14)),
//                       ));
//                 },
//               ),
//             ),
//           ),
//           Obx(() {
//             print("we are in this bro ");
//             print(controller.isLoading.value);
//             if (controller.isLoading.value == true) {
//               print("we are in this bro3232323 ");
//               return Expanded(
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.primary,
//                   ),
//                 ),
//               );
//             }

//             var limitedDoctors = controller.filteredDoctors.take(5).toList();

//             return Column(
//               children: [
//                 for (var doctor in limitedDoctors)
//                   Padding(
//                     padding: EdgeInsets.only(top: 24, left: 24, right: 24),
//                     child: HomeScreenDoctorCard(doctor: doctor),
//                   ),
//                 SizedBox(
//                   height: 24,
//                 )
//               ],
//             );
//           })
//         ],
//       ),
//     );
//   }
// }

class HomeScreenDoctorList extends StatefulWidget {
  @override
  State<HomeScreenDoctorList> createState() => _HomeScreenDoctorListState();
}

class _HomeScreenDoctorListState extends State<HomeScreenDoctorList> {
  late DoctorController controller;
  final List<String> specialties = [
    "All",
    "Cardiology",
    "Orthopedics",
    "Surgery",
    "Gynecology"
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.put(DoctorController(), tag: 'HomeScreenDoctorList');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Title and See All button
          Row(
            children: [
              Text(
                "Our Medical Specialists",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.DoctorsRoute);
                },
                child: Text(
                  "See All",
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 26),
          // Specialties List
          Container(
            height: 28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemCount: specialties.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 244, 245, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    specialties[index],
                    style: GoogleFonts.poppins(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
          // Doctor list display
          Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            var limitedDoctors = controller.filteredDoctors.take(5).toList();

            return Column(
              children: [
                for (var doctor in limitedDoctors)
                  Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: HomeScreenDoctorCard(doctor: doctor),
                  ),
                SizedBox(height: 24),
              ],
            );
          })
        ],
      ),
    );
  }
}
