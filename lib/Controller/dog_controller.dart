import 'package:get/get.dart';

class BoardingController extends GetxController {
  // Service Dropdown State
  var selectedService = 'Boarding'.obs;

  // Rate and Rate Visibility
  var updateRatesBasedOnBase = true.obs;
  var showAdditionalRates = false.obs; // Toggles visibility of extra rates
  var offerGroomingForFree = true.obs; // From image_46c49c.png

  // Availability
  var isFullTimeAvailable = true.obs; // Yes/No for 'Are you home full-time...'
  var selectedPottyBreak = '0-2 hours'.obs;

  // Pet Preferences
  var petCount = 1.obs;
  var petSizes = {
    'Small dog (0-15 lbs)': true.obs,
    'Medium dog (16-40 lbs)': true.obs,
    'Large dog (41-100 lbs)': false.obs,
    'Giant dog (100+ lbs)': false.obs,
  };
  var homeTypes = {
    'House': true.obs,
    'Apartment': false.obs,
    'Farm': false.obs,
  };
  var yardTypes = {
    'Fenced yard': true.obs,
    'Unfenced yard': false.obs,
    'No yard': false.obs,
  };

  // Boarding Expectations and Hosting Abilities (Initial states derived from image_46c79a.png)
  var boardingExpectations = {
    'Smoking inside home': false.obs,
    'Children age 0-5': true.obs,
    'Children age 6-12': true.obs,
    'Dogs are allowed on bed': true.obs,
    'Cats in home': true.obs,
    'Caged pets in home': false.obs,
    'None of the above': false.obs,
  };
  var hostingAbilities = {
    'Pets from different families at the same time': true.obs,
    'Puppies under 1 year old': true.obs,
    'Dogs that are not crate trained': true.obs,
    'Uneudtered male dog': false.obs,
    'Unsprayed female dogs': false.obs,
    'Female dogs in heat': false.obs,
    'None of the above': false.obs,
  };

  // Cancellation Policy
  var cancellationPolicy = {
    'Same day': true.obs,
    'One day': true.obs,
    'Two day': true.obs,
    'Three day': true.obs,
  };

  void toggleAdditionalRates() {
    showAdditionalRates.value = !showAdditionalRates.value;
  }
}