import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/doctor.dart';

class DoctorController extends GetxController {
  var doctors = <Doctor>[].obs;
  var filteredDoctors = <Doctor>[].obs;
  var selectedDepartments = <String>[].obs;
  var selectedTreatmentAreas = <String>[].obs;
  var selectedSortOption = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("delted");
    Get.delete<DoctorController>();
    super.dispose();
  }

  Future<void> fetchDoctors() async {
    isLoading.value = true;
    try {
      // await Future.delayed(Duration(seconds: 5));
      final response =
          await http.get(Uri.parse('http://localhost:4221/fetchdoctors'));

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        // print(data);
        List<dynamic> responseData = data['data'];
        // List<dynamic> responseData = [];s
        // print(responseData);
        filteredDoctors.value =
            responseData.map((json) => Doctor.fromJson(json)).toList();
        print("ye bro we receive");
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

  void applyFilters() {
    List<Doctor> tempList = List.from(doctors);

    if (selectedDepartments.isNotEmpty) {
      tempList = tempList
          .where((doctor) => selectedDepartments.contains(doctor.department))
          .toList();
    }

    if (selectedSortOption.value.isNotEmpty) {
      if (selectedSortOption.value == 'rating_desc') {
        tempList.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (selectedSortOption.value == 'price_asc') {
        tempList.sort((a, b) => a.fee.compareTo(b.fee));
      }
    }

    filteredDoctors.assignAll(tempList);
  }

  void resetFilters() {
    selectedDepartments.clear();
    selectedTreatmentAreas.clear();
    selectedSortOption.value = '';
    applyFilters();
  }
}
