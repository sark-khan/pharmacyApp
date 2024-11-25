import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/hospital.dart';

class HospitalController extends GetxController {
  var hostpitalsList = <Hospital>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    isLoading.value = true;
    try {
      // await Future.delayed(Duration(seconds: 5));
      final response =
          await http.get(Uri.parse('http://localhost:4221/fetchhospitals'));

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        // print(data);
        List<dynamic> responseData = data['data'];
        // print(responseData);
        hostpitalsList.value =
            responseData.map((json) => Hospital.fromJson(json)).toList();
        print("ye bro we receive hospitals");
        // applyFilters();
      } else {
        Get.snackbar('Error',
            'Failed to fetch doctors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch doctors: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
