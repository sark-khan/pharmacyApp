import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/appoinment.dart';
import '../utils/helper_class.dart';
import '../utils/dio_client.dart';
import 'package:dio/dio.dart';
import '../utils/auth_helper.dart';
import '../views/login.dart';
import '../utils/routes.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var userDetails = <String, dynamic>{}.obs;
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  Future<ReturnObj> requestUpdateProfile(Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      var token = AuthHelper.getToken() ?? "";
      var options = Options(headers: {'Authorization': "Bearer ${token}"});

      var response = await DioClient.dio
          .post("/patient/update", data: payload, options: options);

      if (response.statusCode == 201) {
        return ReturnObj(
            status: true, message: response.data["message"], data: response);
      }
      return ReturnObj(
          message: response.data["message"], data: response, status: false);
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
        return ReturnObj(message: e.response?.data?['message'], status: false);

        // Optionally, log out the user or navigate to login screen
        // AuthHelper.logout(); // Add your logout logic here
      } else {
        Get.snackbar(
          'Error',
          e.response?.data?['message'] ?? 'Failed to uodate profile',
          duration: Duration(seconds: 2),
        );
        return ReturnObj(message: e.response?.data?['message'], status: false);
      }
    } catch (e) {
      // Handle other exceptions
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        duration: Duration(seconds: 2),
      );
      return ReturnObj(message: "failed to update profile", status: false);
    } finally {
      isLoading.value = false;
    }
  }
}
