import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/appoinment.dart';
import '../utils/dio_client.dart';
import '../utils/helper_class.dart';
import '../utils/auth_helper.dart';
import '../utils/dio_client.dart';
import '../utils/routes.dart';

class AppoinmentController extends GetxController {
  var appointmentList = <AppointmentData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    isLoading.value = true;
    try {
      var token = AuthHelper.getToken() ?? "";
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final response =
          await DioClient.dio.get("/patient/appointments", options: options);

      if (response.statusCode == 200) {
        var data = response.data;
        var listOfAppointments = data?["data"] ?? [];
        appointmentList.value = List.from(
            listOfAppointments.map((e) => AppointmentData.fromJson(e)));
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      if (e.response?.statusCode == 401) {
        // Unauthorized error
        Get.snackbar(
          '',
          'Your session has expired. Please login again.',
          duration: Duration(seconds: 1),
        );
        await Future.delayed(Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.loginRoute);

        // Optionally, log out the user or navigate to login screen
        // AuthHelper.logout(); // Add your logout logic here
      } else {
        Get.snackbar(
          'Error',
          e.response?.data?['message'] ?? 'Failed to fetch appointments',
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      // Handle other exceptions
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchAppoinments() async {
  //   isLoading.value = true;
  //   try {
  //     var token = AuthHelper.getToken() ?? "";
  //     Options options = Options(headers: {'Authorization': 'Bearer $token'});
  //     final response =
  //         await DioClient.dio.get("/patient/appointments", options: options);
  //     if (response.statusCode == 200) {
  //       var data = response.data;
  //       var listOfAppointments = data?["data"] ?? [];
  //       print(listOfAppointments);
  //       appointmentList.value = List.from(
  //           listOfAppointments.map((e) => AppointmentData.fromJson(e)));
  //     }
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar('', 'Failed to fetch appintment');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
