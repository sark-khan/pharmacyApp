import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/appoinment.dart';

class AppoinmentController extends GetxController {
  var appointmentList = <AppointmentData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ();
    fetchAppoinments();
  }

  Future<void> fetchAppoinments() async {
    isLoading.value = true;
    try {
      // await Future.delayed(Duration(seconds: 5));
      final response =
          await http.get(Uri.parse('http://localhost:4221/fetchappoinments'));

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        print(data['data']);
        // print(data);
        List<dynamic> responseData = data['data'];
        // print(responseData);
        appointmentList.value =
            responseData.map((json) => AppointmentData.fromJson(json)).toList();
        print("ye bro we receive appoinemtn");

        // applyFilters();
      } else {
        Get.snackbar('Error',
            'Failed to fetch appinemtn. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch appintment: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
