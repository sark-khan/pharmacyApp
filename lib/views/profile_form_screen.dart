import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import './apppointment_screen.dart';

class ProfileFormScreen extends StatefulWidget {
  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final List<String> genderOptions = ["Male", "Female", "Transgender"];

  final List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];

  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
            Get.back();
          },
        ),
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        // centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: AppColors.doctorScreenBackgroudColor,
          child: SingleChildScrollView(
            // padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
                  child: Text(
                    "Hi, Mahesh Bohra",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(37, 37, 37, 1)),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionHeader("Full Name"),
                      buildTextField("Jai Shankar Saini"),
                      SizedBox(height: 20),
                      buildDoubleField(
                        "Father/Husband Name",
                        "Age(Years)",
                        "Sr. Jai Shankar Saini",
                        "32",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.08), // Set the border color
                            width: 1, // Set the border width to 1px
                          ),
                          // Optional: for rounded corners
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Communication",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildSectionHeader("Phone"),
                      buildTextField("+91 7777777777"),
                      SizedBox(
                        height: 20,
                      ),
                      buildSectionHeader("Email"),
                      buildTextField("patient@gmail.com"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("Date Of Birth"),
                                buildDatePicker("10-199-12", context)
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("Blood Group"),
                                DropDownList(bloodGroups[0], bloodGroups)
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("Gender"),
                                DropDownList(genderOptions[0], genderOptions),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.08), // Set the border color
                            width: 1, // Set the border width to 1px
                          ),
                          // Optional: for rounded corners
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Address Info",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildSectionHeader("House No./Street/Area/Near By"),
                      buildTextField("P-01/AA"),
                      SizedBox(
                        height: 20,
                      ),
                      buildSectionHeader("Colony/Street/Locality/Village"),
                      buildTextField("Sector 12"),
                      SizedBox(
                        height: 20,
                      ),
                      buildSectionHeader("City"),
                      buildTextField("Bikaner"),
                      SizedBox(
                        height: 20,
                      ),
                      buildTripleField(
                        "State",
                        "Country",
                        "Pincode",
                        "Rajasthan",
                        "India",
                        "333333",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 72,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primary),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Border radius of 12
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Handle update info action
                    },
                    child: Text(
                      "Update Info",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(113, 125, 136, 1),
      ),
    );
  }

  Future<void> _setDate(BuildContext context) async {
    DateTime? _picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (_picker != null) {
      setState(() {
        controller.text = _picker.toString().split(" ")[0];
      });
    }
  }

  Widget buildDatePicker(String hintText, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 36,
        child: TextField(
          readOnly: true,
          controller: controller,
          onTap: () {
            _setDate(context);
          },
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color.fromRGBO(37, 37, 37, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true, // Reduces the overall height
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 36,
        child: TextField(
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color.fromRGBO(37, 37, 37, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true, // Reduces the overall height
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ),
    );
  }

  Widget DropDownList(String selectedValue, List<String> options) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 36,
        child: DropdownButtonFormField(
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            border: InputBorder.none, // Remove the underline
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          focusColor: Colors.white,
          value: selectedValue,
          onChanged: (value) {
            print("vale");
            print(value);
          },
          items: options
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color.fromRGBO(37, 37, 37, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ))
              .toList(),
          // items: [
          //   DropdownMenuItem(
          //     value: "Male",
          //     child: Text(
          //       "Male",
          //       style: GoogleFonts.poppins(
          //           textStyle: TextStyle(
          //               color: Color.fromRGBO(37, 37, 37, 1),
          //               fontWeight: FontWeight.w500,
          //               fontSize: 12)),
          //     ),
          //   ),
          //   DropdownMenuItem(
          //     child: Text(
          //       "Female",
          //       style: GoogleFonts.poppins(
          //           textStyle: TextStyle(
          //               color: Color.fromRGBO(37, 37, 37, 1),
          //               fontWeight: FontWeight.w500,
          //               fontSize: 12)),
          //     ),
          //     value: "Female",
          //   ),
          //   DropdownMenuItem(
          //     child: Text(
          //       "Transgender",
          //       style: GoogleFonts.poppins(
          //           textStyle: TextStyle(
          //               color: Color.fromRGBO(37, 37, 37, 1),
          //               fontWeight: FontWeight.w500,
          //               fontSize: 12)),
          //     ),
          //     value: "Transgender",
          //   )
          // ],
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color.fromRGBO(37, 37, 37, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
        ),
      ),
    );
  }

  Widget buildDoubleField(
    String label1,
    String label2,
    String hint1,
    String hint2,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label1),
              buildTextField(hint1),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label2),
              buildTextField(hint2),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTripleField(
    String label1,
    String label2,
    String label3,
    String hint1,
    String hint2,
    String hint3,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label1),
              buildTextField(hint1),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label2),
              buildTextField(hint2),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label3),
              buildTextField(hint3),
            ],
          ),
        ),
      ],
    );
  }
}
