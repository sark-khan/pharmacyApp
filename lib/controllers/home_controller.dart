import 'package:get/get.dart';
import 'package:hospital_app/utils/auth_helper.dart';
import '../models/doctor.dart';
import '../services/api_service.dart';
import '../utils/dio_client.dart';
import '../utils/helper_class.dart';
import "package:get_storage/get_storage.dart";

class HomeController extends GetxController {
  var storage = GetStorage();
  var doctors = <Doctor>[].obs;
  var isLoading = false.obs;
  var locations = <String, dynamic>{}.obs;
  var location = "".obs;
  var selectedLocation = "".obs;
  var locationList = [].obs;
  var searchResults = [].obs;
  @override
  void onInit() async {
    super.onInit();
    await requestFetchLocations();
  }

  Future<void> requestForSeachResults(
      String location, Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> body = {
        "city": location,
        ...payload, // Merge the payload parameters into the body
      };
      final response =
          await DioClient.dio.get("/patient/search", queryParameters: body);

      if (response.statusCode == 200) {
        var data = response.data;

        var results = data?["data"] ??
            []; // Extract the list of doctors from the response
        if (results.isNotEmpty) {
          searchResults.value =
              List.from(results); // Assign doctors data to observable list
        } else {
          doctors.value = []; // Clear doctors list if no data is returned
        }
      }
    } catch (error) {
      Get.snackbar('', 'Failed to get search results.',
          duration: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 1));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestFetchLocations() async {
    try {
      final response = await DioClient.dio.get("/patient/locations");
      if (response.statusCode == 200) {
        var listOfLocations = response.data?['data']?['locations'] ?? [];
        if (listOfLocations.length > 0) {
          locationList.value = listOfLocations.map((json) {
            return {
              "qpId": json["qpId"],
              "city": json["title"],
            };
          }).toList();
          locations.value = {
            for (var location in listOfLocations) location["qpId"]: location
          };
          var finalLocation = listOfLocations[0]?["qpId"];
          selectedLocation.value = finalLocation;
          storage.write("selectedLocation", finalLocation);
        }
      } else {
        throw Exception("Failed to fetch locations: ${response.statusCode}");
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to get the locations');
    }
  }
}
