import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../utils/colors.dart';
import './login_verification_otp.dart';
import '../controllers/auth_controller.dart';
import '../utils/helper_class.dart';
import '../utils/app_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phoneController.text;
      authController.isLoading.value = true;
      ReturnObj response = await authController.requestSendOtp(phoneNumber);
      if (response.status == true) {
        Get.to(() => LoginOtpVerficationScreen(),
            arguments: {"phoneNumber": phoneNumber});
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
                constraints: BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Login Into QuickParamarsh",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          height: 20 / 20,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone",
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
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(37, 37, 37, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                decoration: InputDecoration(
                                  hintText: "Enter Your Phone No.",
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
                                    return "Phone number cannot be empty";
                                  } else if (value.length != 10) {
                                    return "Phone number must be 10 digits";
                                  } else if (!RegExp(r'^[0-9]+$')
                                      .hasMatch(value)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                      "Get OTP",
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
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
