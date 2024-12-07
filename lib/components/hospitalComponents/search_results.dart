import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../../widgets/filter_bottom_sheet.dart';
import '../../controllers/bottom_filter_controller.dart';
import '../../controllers/hospitals_screen_controller.dart';

class SearchResultsHeader extends StatefulWidget {
  final String searchLocation;
  SearchResultsHeader({Key? key, required this.searchLocation})
      : super(key: key);
  @override
  State<SearchResultsHeader> createState() => _SearchResultsHeaderState();
}

class _SearchResultsHeaderState extends State<SearchResultsHeader> {
  late HospitalController hospitalController = HospitalController();
  @override
  void _showFilterBottomSheet(BuildContext context) {
    if (!Get.isRegistered<FiltersController>(tag: widget.searchLocation)) {
      Get.put(FiltersController(), tag: widget.searchLocation);
    } else {}
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      builder: (BuildContext context) {
        return FiltersBottomSheet(
          screenLocation: widget.searchLocation,
        );
      },
    );
  }

  void initState() {
    super.initState();
    // Delay setup until after the initial widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hospitalController = Get.put(HospitalController(), tag: 'HospitalScreen');
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white, // White background color
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(
                      5, 102, 211, 0.25), // RGBA color with 25% opacity
                  offset: Offset(0, 0), // X and Y offset for the shadow
                  blurRadius: 8, // Spread of the shadow
                  spreadRadius: 0, // No extra spread, similar to CSS
                ),
              ],
            ),
            child: Center(
              child: Transform.rotate(
                angle: pi / 2, // Rotate 90 degrees
                child: Icon(
                  Icons.tune,
                  color: Colors.grey.shade600, // Light grey icon color
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Obx(() {
            if (hospitalController == null ||
                hospitalController.isLoading == true) {
              return SizedBox();
            }
            return Expanded(
              child: Text(
                "Found ${hospitalController.hostpitalsList.length ?? 0}+ Results For Your Search",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),

          SizedBox(width: 8),
          // Sort Button
          GestureDetector(
            onTap: () {
              _showFilterBottomSheet(context);
            },
            child: Container(
              height: 32,
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.white, // Light grey background color
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(
                        5, 102, 211, 0.25), // RGBA color with 25% opacity
                    offset: Offset(0, 0), // X and Y offset for the shadow
                    blurRadius: 8, // Spread of the shadow
                    spreadRadius: 0, // No extra spread, similar to CSS
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sort, // Sort icon
                    color: Colors.black,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Sort",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
