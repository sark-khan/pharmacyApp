import 'package:get/get.dart';
import '../models/doctor.dart';

class ApiService extends GetConnect {
  Future<List<Doctor>> fetchDoctors() async {
    final response =
        await get('https://672f4f9b229a881691f28723.mockapi.io/doctor');
    if (response.status.hasError) {
      throw Exception('Failed to load doctors');
    } else {
      return (response.body as List).map((e) => Doctor.fromJson(e)).toList();
    }
  }
}
