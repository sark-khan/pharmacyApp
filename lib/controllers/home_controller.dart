import 'package:get/get.dart';
import '../models/doctor.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  var doctors = <Doctor>[].obs;
  var isLoading = true.obs;
  var location = "Sri Dungargarh".obs;
  void updateLocation(String newLocation) {
    location.value = newLocation;
  }
}
