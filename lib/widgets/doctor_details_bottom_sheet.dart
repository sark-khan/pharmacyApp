import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/models/doctor.dart';
import '../utils/colors.dart';
import '../controllers/hostpital_detaill_screen.dart';
import '../utils/app_constant.dart';
import '../utils/helper_class.dart';
import '../widgets/review_card.dart';
import '../utils/auth_helper.dart';

class DocterDetailsBottomSheet extends StatefulWidget {
  final String slug;
  DocterDetailsBottomSheet({super.key, required this.slug});

  @override
  State<DocterDetailsBottomSheet> createState() =>
      _DocterDetailsBottomSheetState();
}

class _DocterDetailsBottomSheetState extends State<DocterDetailsBottomSheet> {
  final HospitalDetailsController controller =
      Get.put(HospitalDetailsController(), tag: "DoctorBottomSheet");
  var token = AuthHelper.getToken();
  final List<Map<String, String>> openingHours = [
    {"Sunday": "sun"},
    {"Monday": "mon"},
    {"Tuesday": "tue"},
    {"Wednesday": "wed"},
    {"Thursday": "thu"},
    {"Friday": "fri"},
    {"Saturday": "sat"}
  ];
  @override
  void initState() {
    // TODO: implement initState
    controller.fetchParticularDoctorDetails(widget.slug);
    controller.fetchDoctorReviews(widget.slug);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<HospitalDetailsController>(tag: "DoctorBottomSheet");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.doctorScreenBackgroudColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: Obx(() {
              if (controller.isLoading.value == true) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (controller.doctorDetails.isEmpty) {
                return Center(
                  child: Text(
                    "Doctor details not found",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            height: 20 / 14)),
                  ),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Fixed Header
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 4,
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Doctor's Profile",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                              height: 112,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Row(
                                children: [
                                  // Doctor's Image
                                  Container(
                                    height: 96,
                                    width: 96,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        (controller.doctorDetails?["image"]
                                                    ?.isNotEmpty ??
                                                false)
                                            ? "${AppConstant.ImageDomain}/${controller.doctorDetails["image"]}"
                                            : "${AppConstant.ImageDomain}/doctor-fallback.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  // Doctor's Information
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${controller.doctorDetails["honorific"]} ${StringFunctions.convertToTitleCase(controller.doctorDetails["name"])}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          "${controller.doctorDetails["department"]}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          "${controller.doctorDetails["experienceCount"]}+ Years Experience",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            height: 30 / 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    softWrap: true,
                                    controller.doctorDetails["bio"] ?? "",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            height: 20 / 14,
                                            color: Color.fromRGBO(0, 0, 0, 0.6),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Practice Experience",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            height: 30 / 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 16,
                                      ),
                                      shrinkWrap:
                                          true, // Prevents infinite height issue
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                              .doctorDetails["profile"]
                                                  ?["experience"]
                                              .length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.doctorDetails[
                                                              "profile"]
                                                          ?["experience"][index]
                                                      ["hospitalName"] ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.0,
                                                      height: 22 / 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.6))),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                                "${controller.doctorDetails["profile"]?["experience"][index]?["year"]?["start"]} - ${controller.doctorDetails["profile"]?["experience"][index]?["year"]?["end"]}",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        height: 22 / 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.5)))),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Education",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            height: 30 / 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 16,
                                      ),
                                      shrinkWrap:
                                          true, // Prevents infinite height issue
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                              .doctorDetails["profile"]
                                                  ?["education"]
                                              .length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.doctorDetails["profile"]?["education"][index]["institute"]}",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.0,
                                                      height: 22 / 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.6))),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                                "${controller.doctorDetails["profile"]?["education"][index]["title"]}",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0,
                                                        height: 22 / 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.6)))),
                                            const SizedBox(height: 2),
                                            Text(
                                                "${controller.doctorDetails["profile"]?["education"][index]["endYear"]}",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        height: 22 / 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.5)))),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Opening Hours",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            height: 30 / 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: openingHours.length,
                                        itemBuilder: (context, index) {
                                          String day = openingHours[index]
                                              .keys
                                              .first; // Get the day name
                                          String shortDay =
                                              openingHours[index][day] ?? "";
                                          var isEnabled = controller
                                                          .doctorDetails[
                                                      "weeklySchedule"]
                                                  ?[shortDay]?["isEnabled"] ==
                                              true;
                                          var slots = controller.doctorDetails[
                                                      "weeklySchedule"]
                                                  ?[shortDay]?["slots"] ??
                                              [];

                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.08)),
                                            )),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(day,
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.8),
                                                            fontSize: 14,
                                                            height: 30 / 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))),
                                                Column(
                                                  children: [
                                                    if (isEnabled) ...[
                                                      for (var slot in slots)
                                                        Text(
                                                          "${slot["start"]} - ${slot["end"]}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              height: 30 / 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                    ] else
                                                      Text(
                                                        "Closed",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 14,
                                                            height: 30 / 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Reviews",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            (token?.isEmpty ?? true)
                                                ? SizedBox()
                                                : Container(
                                                    height: 32,
                                                    padding: EdgeInsets.only(
                                                        left: 12, right: 12),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .doctorScreenBackgroudColor, // Light grey background color
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .upload, // Sort icon
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          "Add Review",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Obx(() {
                                          if (controller
                                              .doctorReviews.isEmpty) {
                                            return Center(
                                              child: Text(
                                                "No Review found",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Container(
                                              height: 250,
                                              child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(width: 16),
                                                itemCount: controller
                                                    .doctorReviews.length,
                                                itemBuilder: (context, index) {
                                                  Map<String, dynamic> data =
                                                      controller
                                                          .doctorReviews[index];
                                                  return ReviewOfPatient(
                                                      data: data);
                                                },
                                                // shrinkWrap:
                                                //     true, // Allow ListView to shrink to its content
                                              ));
                                        })
                                      ]))
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              );
            })),

        // Close Button positioned 20px above the top border, outside the clipped area
        Positioned(
          top: -62,
          left: (MediaQuery.of(context).size.width / 2) - 24,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/close_icon.svg",
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
