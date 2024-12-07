import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/hospital.dart';
import '../utils/dio_client.dart';
import '../utils/helper_class.dart';

class HospitalController extends GetxController {
  var hostpitalsList = <Hospital>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ();
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

  Future<void> requestFetchHospitals(location) async {
    isLoading.value = true;
    try {
      var response = await DioClient.dio.get("/patient/dashboard/hospitals",
          queryParameters: {"city": location});

      if (response.statusCode == 200) {
        var data = response.data;

        var responseData = data?['data'] ?? [];
        var result = List<Hospital>.from(
            responseData.map((json) => Hospital.fromJson(json)));
        hostpitalsList.value = result;
      }
    } catch (e) {
      hostpitalsList.value = [];
      Get.snackbar('Error', 'Failed to fetch Hospitals list');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestFetchHospitalsForHosptialScreen(
      String location, Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        "city": location,
        "page": 1,
        ...payload, // Merge the payload parameters into the body
      };
      var response = await DioClient.dio
          .get("/patient/hospitals/search", queryParameters: body);
      print("fetchign hospitals list");

      if (response.statusCode == 200) {
        var data = response.data;
        var responseData = data?['data']?[0]?["data"] ?? [];
        var result = List<Hospital>.from(
            responseData.map((json) => Hospital.fromJson(json)));
        hostpitalsList.value = result;
      }
    } catch (e) {
      hostpitalsList.value = [];
      Get.snackbar('Error', 'Failed to fetch Hospitals list');
    } finally {
      isLoading.value = false;
    }
  }
}
