import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/appoinment.dart';
import '../models/payment.dart';

class PaymentController extends GetxController {
  var paymentList = <PaymentData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    isLoading.value = true;
    try {
      // await Future.delayed(Duration(seconds: 5));
      final response =
          await http.get(Uri.parse('http://localhost:4221/payments'));

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        print(data['data']);
        // print(data);
        List<dynamic> responseData = data['data'];
        // print(responseData);
        paymentList.value =
            responseData.map((json) => PaymentData.fromJson(json)).toList();
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
