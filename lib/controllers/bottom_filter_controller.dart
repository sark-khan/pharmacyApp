import 'package:get/get.dart';
import '../utils/dio_client.dart';

class FiltersController extends GetxController {
  // Filter options
  var departments = <String, dynamic>{}.obs;
  var selectedDepartment = "".obs;
  var treatmentAreas = <String, dynamic>{}.obs;
  var selectedTreatmentAreas = <String, dynamic>{}.obs;

  var sortingMethods = <String, dynamic>{
    "priceLow": "Price: Low to High",
    "priceHigh": "Price: High to Low",
    "rating": "Doctor’s Rating: High to low",
    "appointments": "Appointments avialable: Hight to low"
  }.obs;
  var selectedSortingMethod = "".obs;

  var hospitalSortingMethods = <String, dynamic>{
    "rating": "Hospital’s Rating: High to low",
    "appointments": "Appointments avialable: Hight to low"
  }.obs;

  var selectedSort = "".obs;
  @override
  void onInit() {
    super.onInit();
    // Fetch filter options when the controller is initialized
    fetchFilterOptions();
  }

  Future<void> fetchFilterOptions() async {
    try {
      final response = await DioClient.dio.get("/patient/list/dept-areas");
      if (response.statusCode == 201) {
        var data = response.data;
        var listOfDepartmens = data?["data"] ?? [];
        for (var ele in listOfDepartmens) {
          departments[ele["slug"]] = ele["title"];

          treatmentAreas[ele["slug"]] = ele["treatmentAreas"]?.map((doc) {
            return {
              "treatmentTitle": doc["title"],
              "treatmentSlug": doc["slug"],
              "selected": false,
            };
          }).toList();
        }
        // print(treatmentAreas);
      } else {
        throw Exception(
            "Failed to fetch departments areas: ${response.statusCode}");
      }
    } catch (error) {
      print(error);
      Get.snackbar('Error', 'Failed to fetch departments areas');
    }
  }
}
