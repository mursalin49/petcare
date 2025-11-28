import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DogWalkingController extends GetxController {
  // --- Rates Controllers (NEW) ---
  final baseRateController = TextEditingController(text: '28.00');
  final rate60MinController = TextEditingController(text: '28.00');
  final holidayRateController = TextEditingController(text: '28.00');
  final additionalRateController = TextEditingController(text: '28.00');
  final puppyRateController = TextEditingController(text: '28.00');
  final pickupDropOffController = TextEditingController(text: '28.00');

  // --- Other Controllers ---
  final maxWalksController = TextEditingController(text: '4'); // for maxWalksPerDay
  final locationController = TextEditingController(text: '1000, BD');
  final serviceAreaController = TextEditingController(text: '5'); // for serviceAreaDistance

  var selectedService = 'Dog Walking'.obs;
  var showAdditionalRates = false.obs;
  var updateAdditionalRates = true.obs;

  // --- NEW: Offer Puppy for free ---
  var offerPuppyForFree = false.obs;

  // --- Availability ---
  var maxWalksPerDay = 4.obs; // Kept the RxInt for other logic if needed
  var availableTimes = '6am - 11am'.obs;
  var selectedDays = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri'].obs;

  // --- NEW: Potty Break Frequency ---
  var selectedPottyBreak = '0-2 hours'.obs;

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  // ... (Other state variables remain the same) ...
  var useHomeAddress = true.obs;
  var selectedDistanceType = 'Miles'.obs;
  var serviceAreaDistance = 5.obs;
  var selectedTravelModes = {
    'Walking': true.obs, 'Cycling': false.obs, 'Driving': false.obs
  }.obs;
  var petSizes = {
    'Small dog (0-15 lbs)': true.obs, 'Medium dog (16-40 lbs)': true.obs, 'Large dog (41-100 lbs)': true.obs, 'Giant dog (100+ lbs)': true.obs,
  }.obs;
  var acceptsPuppies = true.obs;
  var cancellationPolicy = {
    'Same day': true.obs, 'One day': true.obs, 'Two day': true.obs, 'Three day': true.obs,
  }.obs;

  void toggleAdditionalRates() {
    showAdditionalRates.value = !showAdditionalRates.value;
  }

  void toggleCheckbox(Map<String, RxBool> map, String key, bool value) {
    if (map.containsKey(key)) {
      map[key]!.value = value;
    }
  }

  @override
  void onClose() {
    // Dispose all controllers
    baseRateController.dispose();
    rate60MinController.dispose();
    holidayRateController.dispose();
    additionalRateController.dispose();
    puppyRateController.dispose();
    pickupDropOffController.dispose();
    maxWalksController.dispose();
    locationController.dispose();
    serviceAreaController.dispose();
    super.onClose();
  }
}