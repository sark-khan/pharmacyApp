import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import './apppointment_screen.dart';
import '../utils/helper_class.dart';
import 'package:flutter/services.dart';
import '../controllers/profile_controller.dart';
import '../utils/auth_helper.dart';
import '../utils/routes.dart';

class ProfileFormScreen extends StatefulWidget {
  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final List<String> genderOptions = [
    "Male",
    "Female",
    "Non-Binary",
    "Prefer not to say",
    "Other"
  ];

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
  final List<String> states = [
    'Andaman and Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh',
    'Chhattisgarh',
    'Dadra and Nagar Haveli',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Lakshadweep',
    'Ladakh',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Puducherry',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  TextEditingController controller = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _bloodGroup = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      var fullName = _fullName.text.trim();
      var fatherName = _fatherName.text.trim();
      var email = _email.text.trim();
      var bloodGroup = _bloodGroup.text.trim();
      var gender = _gender.text.trim();
      var age = _age.text.trim();
      var street = _street.text.trim();
      var city = _city.text.trim();
      var state = _state.text.trim();
      var pincode = _pincode.text.trim();
      Map<String, dynamic> payload = {};
      if (fullName.isNotEmpty) payload['fullName'] = fullName;
      if (fatherName.isNotEmpty) payload['fatherName'] = fatherName;
      if (email.isNotEmpty) payload['email'] = email;
      if (bloodGroup.isNotEmpty) payload['bloodGroup'] = bloodGroup;
      if (gender.isNotEmpty) payload['gender'] = gender;
      if (age.isNotEmpty) {
        int? parsedAge = int.tryParse(age);
        if (parsedAge != null) {
          payload['age'] = parsedAge;
        }
      }
      if (street.isNotEmpty) payload['street'] = street;
      if (city.isNotEmpty) payload['city'] = city;
      if (state.isNotEmpty) payload['state'] = state;
      if (pincode.isNotEmpty) {
        int? parsedPincode = int.tryParse(pincode);
        if (parsedPincode != null) {
          payload['pincode'] = parsedPincode;
        }
      }
      if (payload.isNotEmpty) {
        var storage = GetStorage();
        var response = await profileController.requestUpdateProfile(payload);
        var data = response.data;
        if (response.status) {
          var userDetails = data.data["data"];
          storage.write("userDetails", userDetails);
          Get.offNamed(AppRoutes.profileRoute);
        } else if (data.statusCode == 401) {
          await AuthHelper.clearToken();
          Get.offNamed(AppRoutes.loginRoute);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var storage = GetStorage();
    var userDetails = storage.read("userDetails");

    final String fullName = userDetails["fullName"] ?? "";
    final String email = userDetails["email"] ?? "";
    final String phone = userDetails["phone"] ?? "";
    final String fatherName = userDetails["fatherName"] ?? "";
    final String bloodGroup = userDetails["bloodGroup"] ?? "";
    final String age = userDetails["age"].toString() ?? "";
    final String gender = userDetails["gender"] ?? "";
    final String street = userDetails?["address"]?["street"] ?? "";
    final String city = userDetails?["address"]?["city"] ?? "";
    final String state = userDetails?["address"]?["state"] ?? "";
    final String pinCode = userDetails?["address"]?["pinCode"].toString() ?? "";
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
          width: double.infinity,
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
                    "Hi, ${StringFunctions.convertToTitleCase(fullName)}",
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
                      buildTextField("${fullName}", _fullName, true),
                      SizedBox(height: 20),
                      buildDoubleField("Father/Husband Name", "Age(Years)",
                          "${fatherName}", "${age}", _fatherName, _age),
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
                      buildTextField("+91 ${phone}", _phone, false),
                      SizedBox(
                        height: 20,
                      ),
                      buildSectionHeader("Email"),
                      buildTextField("${email}", _email, true),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("Blood Group"),
                                DropDownList(
                                    bloodGroup, bloodGroups, _bloodGroup),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("Gender"),
                                DropDownList(gender, genderOptions, _gender)
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
                      buildTextField("${street}", _street, true),
                      SizedBox(
                        height: 20,
                      ),
                      buildSectionHeader("City"),
                      buildTextField("${city}", _city, true),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          // Wrap the first child with Flexible to allow space adjustment
                          Flexible(
                            flex: 2, // Ensure equal space distribution
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("State"),
                                Container(
                                  // Add horizontal margin for spacing
                                  child: DropDownList(state, states, _state),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: 10), // Add spacing between the two fields
                          Flexible(
                            flex: 1, // Ensure the second child gets equal space
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildSectionHeader("Pincode"),
                                Container(
                                  child:
                                      buidlNumberFeild(pinCode, _pincode, true),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
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
                      _updateUserProfile();
                      print("we");
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

  Widget buildTextField(
      String hintText, TextEditingController _controller, bool isEnabled) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 36,
        child: TextField(
          enabled: isEnabled,
          controller: _controller,
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

  Widget buidlNumberFeild(
      String hintText, TextEditingController _controller, bool isEnabled) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 36,
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$'))
          ],
          enabled: isEnabled,
          controller: _controller,
          onChanged: (value) {
            // Optional: Validation feedback to the user
            if (value.isEmpty) {
              print("Field is empty");
            } else if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
              print("Invalid number (no leading zeros allowed)");
            } else {
              print("Valid number");
            }
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

  // Widget DropDownList(String selectedValue, List<String> options,
  //     TextEditingController controller) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 4),
  //     child: SizedBox(
  //       height: 36,
  //       child: DropdownButtonFormField(
  //         dropdownColor: Colors.white,
  //         decoration: InputDecoration(
  //           border: InputBorder.none, // Remove the underline
  //         ),
  //         borderRadius: BorderRadius.all(Radius.circular(10)),
  //         focusColor: Colors.white,
  //         value: selectedValue.isNotEmpty ? selectedValue : null,
  //         onChanged: (value) {
  //           controller.text = value as String;
  //         },
  //         hint: Text(
  //           "Select",
  //           style: GoogleFonts.poppins(
  //             textStyle: TextStyle(
  //               color: Color.fromRGBO(150, 150, 150, 1),
  //               fontWeight: FontWeight.w400,
  //               fontSize: 12,
  //             ),
  //           ),
  //         ),
  //         items: options
  //             .map((e) => DropdownMenuItem<String>(
  //                   value: e,
  //                   child: Text(
  //                     e,
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                             color: Color.fromRGBO(37, 37, 37, 1),
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 12)),
  //                   ),
  //                 ))
  //             .toList(),
  //         style: GoogleFonts.poppins(
  //             textStyle: TextStyle(
  //                 color: Color.fromRGBO(37, 37, 37, 1),
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 12)),
  //       ),
  //     ),
  //   );
  // }

  Widget DropDownList(String selectedValue, List<String> options,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 36,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          dropdownColor: Colors.white,
          isDense: true,
          borderRadius: BorderRadius.circular(10),
          value: selectedValue.isNotEmpty ? selectedValue : null,
          onChanged: (value) {
            controller.text = value!;
          },
          hint: Text(
            "Select",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Color.fromRGBO(150, 150, 150, 1),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          items: options.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color.fromRGBO(37, 37, 37, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDoubleField(
    String label1,
    String label2,
    String hint1,
    String hint2,
    TextEditingController controller1,
    TextEditingController controller2,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label1),
              buildTextField(hint1, controller1, true),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader(label2),
              buidlNumberFeild(hint2, controller2, true),
            ],
          ),
        ),
      ],
    );
  }
}
