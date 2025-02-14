import 'package:get/get.dart';
import 'package:omiga_ipl/controllers/connection_controller.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
  }
}
