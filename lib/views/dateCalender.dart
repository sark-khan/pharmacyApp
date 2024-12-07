import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import 'package:intl/intl.dart';
import '../controllers/hostpital_detaill_screen.dart';
import '../utils/helper_class.dart';
import './doctor_booking_form.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final HospitalDetailsController controller =
      Get.find<HospitalDetailsController>(tag: "HospitalDetailScreen");
  final DateTime currentDate = DateTime.now();
  DateTime? selectedDate;
  DateTime selectedMonth = DateTime.now();
  String selectedSlot = "";
  List<dynamic> slots = [];
  int _currentPage = 0;
  int _slotsPerPage = 6;

  late List<dynamic> _cachedSlots = [];

  @override
  void initState() {
    super.initState();
    _updateCachedSlots();
  }

  void _updateCachedSlots() {
    final startIndex = _currentPage * _slotsPerPage;
    final endIndex = (startIndex + _slotsPerPage).clamp(0, slots.length);

    setState(() {
      _cachedSlots = slots.sublist(startIndex, endIndex);
    });
  }

  // Handle page change
  void _changePage(int direction) {
    setState(() {
      final newPage = _currentPage + direction;
      if (newPage >= 0 && newPage < (slots.length / _slotsPerPage).ceil()) {
        _currentPage = newPage;
        _updateCachedSlots(); // Update cached slots when page changes
      }
    });
  }

  String convertTo12HourFormat(String time24) {
    List<String> parts = time24.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String period = hour >= 12 ? "PM" : "AM";
    int hour12 = hour % 12;
    if (hour12 == 0) hour12 = 12;
    String formattedTime =
        "${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
    return formattedTime;
  }

  List<DateTime> getFutureDates() {
    DateTime today = DateTime.now();
    DateTime startOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month, 1);
    DateTime endOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    if (selectedMonth.month == today.month &&
        selectedMonth.year == today.year) {
      startOfMonth = today;
    }
    return List.generate(
      endOfMonth.difference(startOfMonth).inDays + 1,
      (index) => startOfMonth.add(Duration(days: index)),
    );
  }

  bool isDateEqual(DateTime date1, DateTime date2) {
    bool areDatesEqual = DateTime(date1.year, date1.month, date1.day)
        .isAtSameMomentAs(DateTime(date2.year, date2.month, date2.day));
    return areDatesEqual;
  }

  Future<void> requestForSlots(String date) async {
    ReturnObj result = await controller.fetchSlotsOfDoctor(
        date, controller.doctorDetails["slug"]);
    setState(() {
      _currentPage = 0;
    });
    setState(() {
      if (result.status == true) {
        slots = result.data;
        _updateCachedSlots();
      } else {
        slots = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = getFutureDates();

    return Column(children: [
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        // color: Colors.white,
        child: Column(children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(DateFormat('MMMM yyyy').format(selectedMonth),
                      style: GoogleFonts.poppins(
                          height: 30 / 14,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (context, index) {
                    DateTime date = dates[index];
                    bool isSelectedDate = selectedDate != null
                        ? isDateEqual(date, selectedDate ?? DateTime.now())
                        : false;
                    return GestureDetector(
                      onTap: () async {
                        // Handle date selection
                        setState(() {
                          selectedDate =
                              DateTime(date.year, date.month, date.day);
                          selectedSlot = "";
                        });
                        await requestForSlots(
                            DateFormat('yyyy-MM-dd').format(date).toString());
                      },
                      child: Container(
                        constraints: BoxConstraints(minWidth: 46),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5,
                              color: isSelectedDate
                                  ? Color.fromRGBO(5, 102, 211, 1)
                                  : Color.fromRGBO(208, 218, 227, 1)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                DateFormat('EEE')
                                    .format(date), // Day name (e.g., "Mon")
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 20 / 12,
                                    color: isSelectedDate
                                        ? Color.fromRGBO(5, 102, 211, 1)
                                        : Color.fromRGBO(113, 125, 136, 1))),
                            const SizedBox(height: 4),
                            Text(
                                DateFormat('d')
                                    .format(date), // Day number (e.g., "23")
                                style: GoogleFonts.poppins(
                                    color: isSelectedDate
                                        ? Color.fromRGBO(5, 102, 211, 1)
                                        : Color.fromRGBO(11, 14, 16, 0.8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    height: 20 / 14)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    color: AppColors.doctorScreenBackgroudColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Showing Available Time Only",
                          style: GoogleFonts.poppins(
                              height: 30 / 14,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        Spacer(),
                        Text("${slots.length} Slots",
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(27, 43, 58, 1),
                                height: 30 / 14,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 24, // Set the width
                          height: 24, // Set the height
                          child: Center(
                            child: GestureDetector(
                              onTap: () => _changePage(-1),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 12, // Set the size of the icon
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 24, // Set the width
                          height: 24, // Set the height
                          child: Center(
                            child: GestureDetector(
                              onTap: () => _changePage(1),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 12, // Set the size of the icon
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // SizedBox(
                    //   height: (42 * 2) + (10),
                    //   child: GridView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 3, // 3 columns
                    //       crossAxisSpacing: 10.0, // Horizontal spacing
                    //       mainAxisSpacing: 10.0, // Vertical spacing
                    //       childAspectRatio:
                    //           3, // Adjust aspect ratio to fit slot dimensions
                    //     ),
                    //     itemCount: _cachedSlots.length,
                    //     itemBuilder: (context, index) {
                    //       return _cachedSlots[index];
                    //     },
                    //   ),
                    // ),
                    Obx(() {
                      if (controller.isSlotsLoading.value == true) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }
                      if (slots.isEmpty) {
                        return Center(
                          child: Text(
                            "No slots available",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    height: 16 / 14)),
                          ),
                        );
                      }
                      return Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 10.0,
                        children: [
                          for (var slot in _cachedSlots)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSlot =
                                      slot; // Ensure selectedSlot is updated with the string value
                                });
                              },
                              child: Container(
                                height: 42,
                                width: 107,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  border: selectedSlot == slot
                                      ? Border.all(
                                          width: 1, color: AppColors.primary)
                                      : Border(),
                                ),
                                child: Center(
                                  child: Text(
                                    convertTo12HourFormat(
                                        slot), // Display the slot as a string
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      height: 30 / 12,
                                      color: selectedSlot == slot
                                          ? AppColors.primary
                                          : Color.fromRGBO(58, 61, 64, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: (selectedDate != null && selectedSlot.isNotEmpty)
              ? () {
                  Get.to(() => DoctorBookingForm(), arguments: {
                    "selectedDate": selectedDate,
                    "selectedSlot": selectedSlot
                  });
                }
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: (selectedDate != null && selectedSlot.isNotEmpty)
                    ? AppColors.primary
                    : Color.fromRGBO(141, 179, 234, 1)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 40,
                ),
                Container(
                  height: 16,
                  width: 10,
                  child: Image.asset(
                    "assets/images/ruppe_icon_white.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "${controller.doctorDetails["appointmentPrice"]}",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 24 / 18),
                ),
                Spacer(),
                Text(
                  "Add Patient Info",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 16 / 16),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  height: 16,
                  width: 16,
                  child: Image.asset(
                    "assets/images/arrow_forward_white.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      )
    ]);
  }
}
