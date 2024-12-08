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
import './login_user_info_form.dart';
import '../utils/app_constant.dart';

class LoginOtpVerficationScreen extends StatefulWidget {
  const LoginOtpVerficationScreen({super.key});

  @override
  State<LoginOtpVerficationScreen> createState() =>
      _LoginOtpVerficationScreenState();
}

class _LoginOtpVerficationScreenState extends State<LoginOtpVerficationScreen> {
  AuthController controller = Get.put(AuthController());
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  // Focus nodes to manage focus transitions
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  String phoneNumber = "";
  Timer? _timer;
  int _remainingTime = 60; // Start with 60 seconds
  bool _isResendEnabled = false;

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    setState(() {
      _remainingTime = 60;
      _isResendEnabled = false;
    });

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Retrieve the phone number passed from arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments['phoneNumber'] != null) {
      phoneNumber = arguments['phoneNumber'];
    }
    _startTimer();
  }

  void _resendOtp() async {
    ReturnObj response = await controller.requestSendOtp(phoneNumber);
    if (response.status == true) {
      _startTimer();

      for (var controller in _controllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();
    }
  }

  void _verifyOtp() async {
    // Collect the entered OTP digits
    String otp = _controllers.map((controller) {
      return controller.text;
    }).join();

    // Check if all digits are entered
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the full OTP")),
      );
      return;
    }
    Map<String, dynamic> payload = {"phoneNumber": phoneNumber, "otp": otp};
    ReturnObj response = await controller.requestVerifyOtp(payload);
    if (response.status == true) {
      final responseData = response.data;
      final token = responseData?["data"]?["token"];
      final userExist = responseData?["data"]["alreadyExist"];

      if (token != null) {
        //before add token check
        await AuthHelper.saveToken(token);
        if (userExist == false) {
          Get.off(() => LoginUserInfoForm());
        } else {
          var storage = GetStorage();
          await storage.write("userDetails", responseData?["data"]?["user"]);
          Get.offNamed(AppRoutes.HomeRoute);
        }
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
                child: Column(children: [
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
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter OTP Received On +91 $phoneNumber",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color.fromRGBO(113, 125, 136, 1),
                          fontSize: 10,
                          height: 20 / 10,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to edit phone number
                          Get.back();
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(
                              color: Color.fromRGBO(121, 127, 132, 1),
                              fontSize: 10,
                              height: 20 / 10,
                              fontWeight: FontWeight.w600,
                              decorationColor: Color.fromRGBO(121, 127, 132, 1),
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.only(
                            right: 6), // Gap between elements
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign:
                                TextAlign.center, // Centers text horizontally
                            maxLength: 1,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding:
                                  EdgeInsets.zero, // Removes extra padding
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 3) {
                                  _focusNodes[index + 1].requestFocus();
                                }
                              } else {
                                if (index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      _verifyOtp();
                    },
                    child: Container(
                      width: 113,
                      padding: EdgeInsets.only(
                          top: 6, left: 23, right: 16, bottom: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.doctorScreenBackgroudColor),
                      child: Row(
                        children: [
                          Text("Login"),
                          SizedBox(width: 10),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Haven't received OTP?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color.fromRGBO(113, 125, 136, 1),
                          fontSize: 10,
                          height: 20 / 10,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      _isResendEnabled
                          ? GestureDetector(
                              onTap: () {
                                //here we resend opt again
                                _resendOtp();
                              },
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                  color: Color.fromRGBO(121, 127, 132, 1),
                                  fontSize: 10,
                                  height: 20 / 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Text(
                              "${_formatTime(_remainingTime)}",
                              style: TextStyle(
                                color: Color.fromRGBO(121, 127, 132, 1),
                                fontSize: 10,
                                height: 20 / 10,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                    ],
                  ),
                ]),
              )
            ]),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }
}
