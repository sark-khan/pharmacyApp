import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/auth_helper.dart';
import 'package:hospital_app/utils/colors.dart';
import '../controllers/bottom_filter_controller.dart';
import '../controllers/doctors_screen_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/hospitals_screen_controller.dart';

class FiltersBottomSheet extends StatefulWidget {
  final String screenLocation;
  const FiltersBottomSheet({Key? key, required this.screenLocation})
      : super(key: key);
  @override
  _FiltersBottomSheetState createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late FiltersController controller;
  late DoctorController doctorsScreenController = DoctorController();
  late HomeController homeController = HomeController();
  late HospitalController hospitalsScreenController = HospitalController();

  String selectedSort = "";
  void _resetFilters() {
    controller.selectedDepartment.value = "";
    controller.selectedTreatmentAreas.clear();
    controller.selectedSortingMethod.value = "";
    if (homeController.selectedLocation.value.isNotEmpty) {
      if (widget.screenLocation == "DoctorScreen") {
        doctorsScreenController.requestFetchDoctorsForDoctorsSceen(
            homeController.selectedLocation.value, {});
      } else {
        hospitalsScreenController.requestFetchHospitalsForHosptialScreen(
            homeController.selectedLocation.value, {});
      }
    }
  }

  void initState() {
    super.initState();
    controller = Get.find<FiltersController>(tag: widget.screenLocation);
    // Delay setup until after the initial widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController = Get.find<HomeController>();
      doctorsScreenController =
          Get.put(DoctorController(), tag: 'DoctorSearchScreen');
      hospitalsScreenController =
          Get.put(HospitalController(), tag: "HospitalScreen");
    });
  }

  void _appFiltersAndFetchList() {
    print(homeController.selectedLocation.value);
    if (homeController.selectedLocation.value.isNotEmpty) {
      var payload = <String, dynamic>{};
      if (controller.selectedDepartment.value.isNotEmpty) {
        payload['dept'] = controller.selectedDepartment.value;
      }
      if (controller.selectedTreatmentAreas.isNotEmpty) {
        if (widget.screenLocation == "DoctorScreen") {
          payload["treat"] = controller.selectedTreatmentAreas.keys.join(",");
        } else {
          payload["services"] =
              controller.selectedTreatmentAreas.keys.join(",");
        }
      }
      if (controller.selectedSortingMethod.isNotEmpty) {
        payload["sortBy"] = controller.selectedSortingMethod.value;
      }
      print("data is fetching calle ");
      print(payload);
      if (widget.screenLocation == "DoctorScreen") {
        doctorsScreenController.requestFetchDoctorsForDoctorsSceen(
            homeController.selectedLocation.value, payload);
      } else {
        hospitalsScreenController.requestFetchHospitalsForHosptialScreen(
            homeController.selectedLocation.value, payload);
      }
    }
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
          child: Column(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filters & Sorting",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _resetFilters();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 24,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color:
                                    Colors.white, // Light grey background color
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(5, 102, 211,
                                        0.25), // RGBA color with 25% opacity
                                    offset: Offset(
                                        0, 0), // X and Y offset for the shadow
                                    blurRadius: 8, // Spread of the shadow
                                    spreadRadius:
                                        0, // No extra spread, similar to CSS
                                  ),
                                ],
                              ),
                              child: Text(
                                "Reset Filter",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: _buildFilterSections(),
                ),
              ),
            ],
          ),
        ),

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
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/close_icon.png",
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

  Widget _buildFilterSections() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        children: [
          Obx(() {
            return _buildFilterSection(
              "Departments",
              controller.departments.entries.map((entry) {
                // Access key as `entry.key` and value as `entry.value`
                return _buildCheckbox(entry.value, entry.key,
                    controller.selectedDepartment.value);
              }).toList(),
            );
          }),
          SizedBox(height: 10),
          Obx(() {
            print(
                "Selected Department: ${controller.selectedDepartment.value}");
            var treatmentList = controller
                    .treatmentAreas[controller.selectedDepartment.value] ??
                [];

            return !controller.selectedDepartment.value.isNotEmpty ||
                    treatmentList.length == 0
                ? SizedBox()
                : _buildFilterSection("Treatment Areas", [
                    for (var entry in treatmentList)
                      _buildTreamentCheckBox(entry["treatmentTitle"],
                          entry["treatmentSlug"], entry["selected"]),
                  ]);
          }),
          SizedBox(height: 10),
          Obx(() {
            return _buildFilterSection(
              "Sort",
              widget.screenLocation == "DoctorScreen"
                  ? controller.sortingMethods.entries.map((entry) {
                      // Access key as `entry.key` and value as `entry.value`
                      return _buildRadio(controller.selectedSortingMethod.value,
                          entry.value, entry.key);
                    }).toList()
                  : controller.hospitalSortingMethods.entries.map((entry) {
                      // Access key as `entry.key` and value as `entry.value`
                      return _buildRadio(controller.selectedSortingMethod.value,
                          entry.value, entry.key);
                    }).toList(),
            );
          }),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _appFiltersAndFetchList();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Apply Filter",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 24 / 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<Widget> childrens) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _buildSectionTitle(title),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: childrens,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        )),
      ),
    );
  }

  Widget _buildCheckbox(String label, String slug, String selectedValue) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxTheme(
            data: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4), // Rounded square corners
              ),
              side: BorderSide(
                color: Color.fromRGBO(
                    208, 218, 227, 1), // Border color to match your image
                width: 1, // Border width
              ),
              fillColor: WidgetStateProperty.resolveWith((states) {
                return selectedValue == slug
                    ? AppColors.primary
                    : Colors.transparent;
                // if (states.contains(WidgetState.selected)) {
                //   return AppColors.primary;
                // }
                // return Colors.transparent;
              }), // Transparent fill when unchecked
              checkColor:
                  WidgetStateProperty.all(Colors.white), // Color when checked
            ),
            child: Checkbox(
              value: selectedValue == slug,
              onChanged: (value) {
                setState(() {
                  controller.selectedDepartment.value = slug;
                  controller.selectedTreatmentAreas.clear();
                });
              },
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.5))),
          ),
        ],
      ),
    );
  }

  Widget _buildTreamentCheckBox(String label, String slug, bool selected) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxTheme(
            data: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4), // Rounded square corners
              ),
              side: BorderSide(
                color: Color.fromRGBO(
                    208, 218, 227, 1), // Border color to match your image
                width: 1, // Border width
              ),
              fillColor: WidgetStateProperty.resolveWith((states) {
                return controller.selectedTreatmentAreas[slug] == true
                    ? AppColors.primary
                    : Colors.transparent;
                // if (states.contains(WidgetState.selected)) {
                //   return AppColors.primary;
                // }
                // return Colors.transparent;
              }), // Transparent fill when unchecked
              checkColor:
                  WidgetStateProperty.all(Colors.white), // Color when checked
            ),
            child: Checkbox(
              value: controller.selectedTreatmentAreas[slug] == true,
              onChanged: (value) {
                setState(() {
                  if (controller.selectedTreatmentAreas.containsKey(slug)) {
                    controller.selectedTreatmentAreas.remove(slug);
                  } else {
                    controller.selectedTreatmentAreas[slug] = true;
                  }
                  // controller.selectedDepartment.value = label;
                });
              },
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.5))),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String selectedValue, String label, String value) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: controller.selectedSortingMethod
              .value, // Set directly to selectedSortingMethod
          focusColor: Colors.transparent,
          onChanged: (newValue) {
            setState(() {
              controller.selectedSortingMethod.value =
                  value; // Update the selectedSortingMethod with the new value
            });
          },
          activeColor: AppColors.primary, // The active color when selected
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.5))),
        ),
      ],
    );
  }
}
