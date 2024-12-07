import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/appoinment.dart';
import '../utils/app_constant.dart';
import '../utils/helper_class.dart';
import 'package:dio/dio.dart';
import '../utils/dio_client.dart';

class AuthController extends GetxController {
  var appointmentList = <AppointmentData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<ReturnObj> requestSendOtp(phoneNumber) async {
    isLoading.value = true;
    try {
      var response = await DioClient.dio.post(
        "/auth/send-otp",
        data: {"phoneNumber": phoneNumber},
      );

      if (response.statusCode == 200) {
        return ReturnObj(status: true, message: response.data["message"]);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to send OTP. Please try again later. $e');
      return ReturnObj(
        status: false,
        message: "Failed to send OTP. Please try again later.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<ReturnObj> requestVerifyOtp(Map<String, dynamic> body) async {
    isLoading.value = true;
    try {
      var response = await DioClient.dio.post(
        "/auth/verify-otp",
        data: body,
      );

      if (response.statusCode == 200) {
        return ReturnObj(
            status: true,
            message: response.data["message"],
            data: response.data);
      }
      return ReturnObj(message: response.data["message"], status: false);
    } catch (e) {
      Get.snackbar('Error', 'Failed to verfiy OTP. Please try again later.');
      return ReturnObj(
        status: false,
        message: "Failed to verify OTP. Please try again later.",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
