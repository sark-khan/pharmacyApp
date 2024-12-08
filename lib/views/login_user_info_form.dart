import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'dart:async';
import '../controllers/auth_controller.dart';
import '../utils/helper_class.dart';
import '../utils/auth_helper.dart';
import '../utils/routes.dart';
import 'package:flutter/services.dart';
import '../utils/app_constant.dart';
import '../controllers/profile_controller.dart';

class LoginUserInfoForm extends StatefulWidget {
  const LoginUserInfoForm({super.key});

  @override
  State<LoginUserInfoForm> createState() => _LoginUserInfoFormState();
}

class _LoginUserInfoFormState extends State<LoginUserInfoForm> {
  var storage = GetStorage();
  AuthController controller = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Focus nodes to manage focus transitions
  final RegExp _emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  @override
  void initState() {
    super.initState();

    final arguments = Get.arguments;
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      String fullName = _nameController.text.trim();
      String email = _emailController.text.trim();
      String city = _cityController.text.trim();
      Map<String, dynamic> data = {};
      if (fullName.isNotEmpty) {
        data['fullName'] = fullName;
      }
      if (email.isNotEmpty) {
        data['email'] = email;
      }
      if (city.isNotEmpty) {
        data['city'] = city;
      }
      var response = await profileController.requestUpdateProfile(data);
      if (response.status) {
        var data = response.data;
        var userDetails = data.data["data"];
        storage.write("userDetails", userDetails);
        Get.offNamed(AppRoutes.HomeRoute);
      } else {
        await AuthHelper.clearToken();
        Get.offNamed(AppRoutes.loginRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.doctorScreenBackgroudColor,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 80,
                  child: ClipRRect(
                    child: Image.network(
                      "${AppConstant.ImageDomain}/qpLogo.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                // height: 220,
                width: 398,
                constraints: BoxConstraints(maxWidth: 420),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Add Details",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          height: 20 / 20,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                height: 20 / 10,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(113, 125, 136, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 36,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                controller: _nameController,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(37, 37, 37, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(174, 174, 174, 1),
                                          fontWeight: FontWeight.w400,
                                          height: 20 / 12,
                                          fontSize: 12)),
                                  isDense: true, // Reduces the overall height
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Text(
                              "Email",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                height: 20 / 10,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(113, 125, 136, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 36,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(70)
                                ],
                                controller: _emailController,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(37, 37, 37, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                decoration: InputDecoration(
                                  hintText: "Enter Your Email Address",
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(174, 174, 174, 1),
                                          fontWeight: FontWeight.w400,
                                          height: 20 / 12,
                                          fontSize: 12)),
                                  isDense: true, // Reduces the overall height
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (!_emailRegex.hasMatch(value)) {
                                      return "Please enter a valid email address";
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Text(
                              "City",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                height: 20 / 10,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(113, 125, 136, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 36,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(100)
                                ],
                                controller: _cityController,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(37, 37, 37, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                decoration: InputDecoration(
                                  hintText: "Your City Name (Optional)",
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(174, 174, 174, 1),
                                          fontWeight: FontWeight.w400,
                                          height: 20 / 12,
                                          fontSize: 12)),
                                  isDense: true, // Reduces the overall height
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: _validateAndSubmit,
                              child: Container(
                                height: 36,
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        AppColors.doctorScreenBackgroudColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Submit & Explore",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color:
                                                  Color.fromRGBO(37, 37, 37, 1),
                                              fontWeight: FontWeight.w400,
                                              height: 1,
                                              fontSize: 16)),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                          fit: BoxFit.cover,
                                          "assets/images/login_forward_icon.svg"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              )
            ]),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
