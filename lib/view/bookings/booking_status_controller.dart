import 'package:get/get.dart';

class BookingStatusController extends GetxController {
  var selectedStatus = 'On going'.obs;

  void selectStatus(String status) {
    selectedStatus.value = status;
  }
}
