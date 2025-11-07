import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Role
  var selectedRole = "Pet Sitter".obs;

  void setRole(String role) {
    selectedRole.value = role;
  }

  // Switch profile
  var switchProfile = false.obs;

  void toggleSwitch(bool value) {
    switchProfile.value = value;
  }

  // Earnings
  var totalIncome = 900.50.obs;
  var thisMonth = 842.00.obs;
  var lastMonth = 753.50.obs;
  var pending = 135.00.obs;
}
