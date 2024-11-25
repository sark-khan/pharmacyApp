// bindings/doctor_bindings.dart
import 'package:get/get.dart';
import "../controllers/doctors_screen_controller.dart";

class DoctorBindings extends Bindings {
  @override
  void dependencies() {
    // Use `permanent: false` to ensure the controller is disposed of when no longer in use
    Get.lazyPut<DoctorController>(() => DoctorController(), fenix: false);
  }
}
