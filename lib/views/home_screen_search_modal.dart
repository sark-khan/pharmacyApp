import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../views/hospital_details_screen.dart';
import "../views/doctor_booking_slot.dart";

class HomeScreenSearchModal extends StatefulWidget {
  final HomeController controller;
  HomeScreenSearchModal({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomeScreenSearchModal> createState() => _HomeScreenSearchModalState();
}

class _HomeScreenSearchModalState extends State<HomeScreenSearchModal> {
  Timer? _debounce;
  final TextEditingController searchController = TextEditingController();
  var isSearched = false;
  @override
  void initState() {
    super.initState();
    widget.controller.searchResults.value = [];
    searchController.addListener(_onSearchChanged);
    setState(() {});
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.trim();
      if (query.isNotEmpty) {
        Map<String, dynamic> payload = {};
        payload["q"] = query;
        widget.controller.requestForSeachResults(
            widget.controller.selectedLocation.value, payload);
      } else {
        setState(() {
          isSearched = false;
        });
        print('Query is empty'); // To debug empty input cases
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background overlay
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent background
          ),
        ),
        // Modal content
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 56, left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight:
                          Radius.circular(20)), // Optional: Rounded corners
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
                child: Column(children: [
                  Container(
                    height: 41,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F8), // Light grey background color
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    child: TextField(
                      onChanged: (Value) {
                        setState(() {
                          isSearched = true;
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey, // Icon color
                        ),
                        hintText:
                            'Search doctors, hospitals & services', // Placeholder text
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color:
                              Colors.black.withOpacity(0.6), // Hint text color
                        )),
                        border: InputBorder.none, // Remove underline
                      ),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Text color
                      )),
                    ),
                  ),
                  Obx(() {
                    if (widget.controller.isLoading.value == true) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primary,
                        )),
                      );
                    }
                    if (isSearched == true &&
                        widget.controller.searchResults.isEmpty) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(
                            'No results found.',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.black
                                  .withOpacity(0.6), // Hint text color
                            )),
                          ),
                        ),
                      );
                    }
                    if (widget.controller.searchResults.isEmpty) {
                      return SizedBox();
                    } else {
                      return Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        constraints: BoxConstraints(
                          maxHeight: 300, // Fixed height for the list
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.controller.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                widget.controller.searchResults[index]
                                        ?["title"] ??
                                    "",
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(color: Colors.grey.shade700)),
                              ),
                              onTap: () {
                                // Handle suggestion selection
                                var mapper =
                                    widget.controller.searchResults[index];
                                print(mapper);
                                var link = mapper["redirectUrl"] ?? "";
                                var type = mapper["type"];
                                if (type == "doctor") {
                                  if (link.toString().contains("/")) {
                                    String hospitalSlug = link.split("/")[1];
                                    String doctorSlug = link.split("/")[2];
                                    if (hospitalSlug.isNotEmpty &&
                                        doctorSlug.isNotEmpty) {
                                      Get.off(
                                          () => DoctorBookingSlot(
                                              slug: doctorSlug),
                                          arguments: {"slug": hospitalSlug});
                                    }
                                  }
                                } else if (type == "hospital") {
                                  if (link.contains("/")) {
                                    String queryString = link.split("/")[1];
                                    if (queryString != null &&
                                        queryString.isNotEmpty) {
                                      Get.to(() =>
                                          HospitalPage(slug: queryString));
                                    }
                                  }
                                } else if (link
                                    .toString()
                                    .startsWith("/hospitals")) {
                                  Map<String, String> queryParameters = {};
                                  if (link.contains("?")) {
                                    String queryString = link.split("?")[1];
                                    queryParameters =
                                        Uri.splitQueryString(queryString);
                                  }
                                  Get.offNamed(AppRoutes.HospitalsRoute,
                                      arguments: queryParameters);
                                } else if (link
                                    .toString()
                                    .startsWith("/doctors")) {
                                  Map<String, String> queryParameters = {};
                                  if (link.contains("?")) {
                                    String queryString = link.split("?")[1];
                                    queryParameters =
                                        Uri.splitQueryString(queryString);
                                  }
                                  Get.offNamed(AppRoutes.DoctorsRoute,
                                      arguments: queryParameters);
                                }

                                // Navigator.pop(context); // Close modal
                              },
                            );
                          },
                        ),
                      );
                    }
                  }),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Dummy filter function to simulate search results
}
