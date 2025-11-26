// Ensure BoardingController is accessible or imported here
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BoardingController extends GetxController {
  final baseRateController = TextEditingController(text: '28.00');
  final holidayRateController = TextEditingController(text: '28.00');
  final puppyRateController = TextEditingController(text: '28.00');
  final extendedStayRateController = TextEditingController(text: '28.00');
  final groomingRateController = TextEditingController(text: '28.00');
  final pickupDropOffRateController = TextEditingController(text: '28.00');

  var showAdditionalRates = false.obs;
  var updateRatesBasedOnBase = true.obs;
  var offerGroomingForFree = false.obs;
  var isFullTimeAvailable = true.obs;
  var selectedPottyBreak = '2-4 hours'.obs;
  var petCount = 1.obs;
  var selectedDays = <String>['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].obs;
  var petSizes = {'Small dog (0-15 lbs)': true.obs, 'Medium dog (16-40 lbs)': true.obs, 'Large dog (41-100 lbs)': false.obs, 'Giant dog (100+ lbs)': false.obs,};
  var homeTypes = {'House': true.obs, 'Apartment': false.obs, 'Farm': false.obs,};
  var yardTypes = {'Fenced yard': true.obs, 'Unfenced yard': false.obs, 'No yard': false.obs,};
  var boardingExpectations = {'Smoking inside home': false.obs, 'Children age 0-5': true.obs, 'Children age 6-12': true.obs, 'Dogs are allowed on bed': true.obs, 'Cats in home': true.obs, 'Caged pets in home': false.obs, 'None of the above': false.obs,};
  var hostingAbilities = {'Pets from different families at the same time': true.obs, 'Puppies under 1 year old': true.obs, 'Dogs that are not crate trained': true.obs, 'Unneutered male dog': false.obs, 'Unspayed female dogs': false.obs, 'Female dogs in heat': false.obs, 'None of the above': false.obs,};
  var cancellationPolicy = {'Same day': true.obs, 'One day': false.obs, 'Two day': false.obs, 'Three day': true.obs,};

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }
  void incrementPetCount() => petCount.value++;
  void decrementPetCount() {
    if (petCount.value > 1) {
      petCount.value--;
    }
  }
  void toggleAdditionalRates() {
    showAdditionalRates.value = !showAdditionalRates.value;
  }
  @override
  void onClose() {
    baseRateController.dispose();
    holidayRateController.dispose();
    puppyRateController.dispose();
    extendedStayRateController.dispose();
    groomingRateController.dispose();
    pickupDropOffRateController.dispose();
    super.onClose();
  }
}