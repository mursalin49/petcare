import 'package:get/get.dart';

class ContactController extends GetxController {
  var selectedContact = ''.obs;

  void selectContact(String name) {
    selectedContact.value = name;
  }
}
