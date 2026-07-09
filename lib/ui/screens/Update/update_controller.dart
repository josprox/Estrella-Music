import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  final updateInfo = Rxn<Map<String, dynamic>>();
  final isLoading = true.obs;
  final error = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpdateInfo();
  }

  Future<void> fetchUpdateInfo() async {
    try {
      isLoading(true);
      error("");
      
      final String? checkUpdates = dotenv.env["UPDATE_CHECK_URL"];
      if (checkUpdates == null) {
        error("Update check URL not found in .env");
        return;
      }

      final dio = Dio();
      final response = await dio.get(checkUpdates);
      
      if (response.statusCode == 200) {
        updateInfo.value = response.data;
      } else {
        error("Error fetching update info: ${response.statusCode}");
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
