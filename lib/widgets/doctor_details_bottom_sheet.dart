import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class DocterDetailsBottomSheet extends StatefulWidget {
  const DocterDetailsBottomSheet({super.key});

  @override
  State<DocterDetailsBottomSheet> createState() =>
      _DocterDetailsBottomSheetState();
}

class _DocterDetailsBottomSheetState extends State<DocterDetailsBottomSheet> {
  final List<Map<String, String>> openingHours = [
    {"Sunday": "10:00 AM - 10:00 PM"},
    {"Monday": "Closed"},
    {"Tuesday": "09:00 AM - 09:00 PM"},
    {"Wednesday": "10:00 AM - 08:00 PM"},
    {"Thursday": "Closed"},
    {"Friday": "11:00 AM - 07:00 PM"},
    {"Saturday": "10:00 AM - 11:00 PM"}
  ];

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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/doctor_placeholder.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              // Doctor's Information
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dr. Jeevan singh",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Sexiologist Doctor",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Text(
                                      "8+ Years Experience",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.6),
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
                                "Dr. Vikas Pareek (MD, General Medicine) With 18 years of experience, Dr. Vikas Pareek is a highly skilled General Medicine practitioner. His MD qualification underscores his dedication to excellence in healthcare. Dr. Pareek's extensive expertise and commitment to patient care have earned him respect and trust among patients and colleagues alike.",
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
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${"Jevvan shankar Hosputal"} - ${"Rajasthan"}',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                  height: 22 / 14,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.6))),
                                        ),
                                        const SizedBox(height: 2),
                                        Text("ENT Doctor - Cardiogloy",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    height: 22 / 14,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.6)))),
                                        const SizedBox(height: 2),
                                        Text(
                                            "December 2022 - Present • 2 Yrs 1 Mon",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
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
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${"Sp medical College & Hosputal"} - ${"Bikaner"}',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                  height: 22 / 14,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.6))),
                                        ),
                                        const SizedBox(height: 2),
                                        Text("MBBS",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    height: 22 / 14,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.6)))),
                                        const SizedBox(height: 2),
                                        Text("2006",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
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
                                      String hours =
                                          openingHours[index][day] ?? "Closed";
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.08)),
                                        )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(day,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.8),
                                                        fontSize: 14,
                                                        height: 30 / 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                            Text(hours,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color: hours == "Closed"
                                                            ? Colors.red
                                                            : Colors.black,
                                                        fontSize: 14,
                                                        height: 30 / 14,
                                                        fontWeight:
                                                            FontWeight.w400)))
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 9,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
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
                color: Colors.white,
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
}
