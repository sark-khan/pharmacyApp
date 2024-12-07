import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/doctor.dart';
import '../utils/dio_client.dart';
import "package:get_storage/get_storage.dart";

class DoctorController extends GetxController {
  var doctors = <Doctor>[].obs;
  var filteredDoctors = <Doctor>[].obs;
  var selectedDepartments = <String>[].obs;
  var selectedTreatmentAreas = <String>[].obs;
  var selectedSortOption = ''.obs;
  var isLoading = false.obs;
  var totalCount = 0.obs;
  var specialties = [
    "All",
    "Cardiology",
    "Neurology",
    "Oncology",
    "Pediatrics",
    "Orthopedics",
    "Dermatology",
    "Ophthalmology",
    "Gynecology",
    "Obstetrics",
    "Urology",
    "Gastroenterology",
    "Endocrinology",
    "Pulmonology",
    "Rheumatology",
    "Nephrology",
    "Hematology",
    "Emergency Medicine",
    "Psychiatry",
    "Anesthesiology",
    "Radiology",
    "Pathology",
    "Infectious Diseases",
    "Otolaryngology (ENT)",
    "Allergy and Immunology",
    "Geriatrics"
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    print("delted");
    Get.delete<DoctorController>();
    super.dispose();
  }

  Future<void> requestFetchDoctors(String location, String department) async {
    try {
      Map<String, dynamic> body = <String, dynamic>{"city": location};
      if (department != "" && department != "All") {
        body["dept"] = department;
      }
      final response = await DioClient.dio
          .get("/patient/dashboard/doctors", queryParameters: body);
      if (response.statusCode == 200) {
        var data = response.data;

        var listOfDoctors = data?["data"] ??
            []; // Extract the list of doctors from the response
        if (listOfDoctors.isNotEmpty) {
          // Map the list of dynamic objects to a list of Doctor objects
          var result = List<Doctor>.from(
              listOfDoctors.map((json) => Doctor.fromJson(json)));
          print(result);
          doctors.value = result; // Assign doctors data to observable list
        } else {
          doctors.value = []; // Clear doctors list if no data is returned
        }
      } else {
        throw Exception("Failed to fetch doctors: ${response.statusCode}");
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to get the Doctor list');
    }
  }

  Future<void> requestFetchDoctorsForDoctorsSceen(
      String location, Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        "city": location,
        "page": 1,
        ...payload, // Merge the payload parameters into the body
      };
      final response = await DioClient.dio
          .get("/patient/doctors/search", queryParameters: body);

      if (response.statusCode == 200) {
        var data = response.data;

        var listOfDoctors = data?["data"]?["data"] ??
            []; // Extract the list of doctors from the response
        if (listOfDoctors.isNotEmpty) {
          // Map the list of dynamic objects to a list of Doctor objects

          var result = List<Doctor>.from(
              listOfDoctors.map((json) => Doctor.fromJson(json)));

          doctors.value = result; // Assign doctors data to observable list
        } else {
          doctors.value = []; // Clear doctors list if no data is returned
        }
      } else {
        throw Exception("Failed to fetch doctors: ${response.statusCode}");
      }
    } catch (error) {
      print(error);
      Get.snackbar('Error', 'Failed to get the Doctor list ujhu $error');
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

    filteredDoctors.assignAll(tempList);
  }

  void resetFilters() {
    selectedDepartments.clear();
    selectedTreatmentAreas.clear();
    selectedSortOption.value = '';
    applyFilters();
  }
}
