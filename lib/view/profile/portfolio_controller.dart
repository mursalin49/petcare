import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class PortfolioController extends GetxController {
  final box = GetStorage();
  var portfolioImages = <String>[].obs; // Stores local file paths
  static const portfolioKey = 'portfolioImagePaths';

  @override
  void onInit() {
    super.onInit();
    List<dynamic>? storedPaths = box.read(portfolioKey);
    if (storedPaths != null) {
      portfolioImages.assignAll(storedPaths.cast<String>());
    }
  }

  // --- ADD IMAGE ---
  Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();
    // ✅ ফিক্সড: pickedFile ভেরিয়েবলটি সংজ্ঞায়িত করা হলো
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final directory = await getApplicationDocumentsDirectory();
      final String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      final String localPath = '${directory.path}/$uniqueFileName';

      //

      final File savedImage = await imageFile.copy(localPath);

      portfolioImages.add(savedImage.path);
      await box.write(portfolioKey, portfolioImages.toList());

      Get.snackbar('Success', 'Image added to portfolio!');
    }
  }

  // --- DELETE IMAGE ---
  Future<void> deleteImage(String path) async {
    portfolioImages.remove(path);
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Could not delete local file: $e');
    }
    await box.write(portfolioKey, portfolioImages.toList());
  }

  // --- REPLACE IMAGE (For editing) ---
  Future<void> replaceImage(String oldPath) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final directory = await getApplicationDocumentsDirectory();
      final String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString() + '_edited.jpg';
      final String newPath = '${directory.path}/$uniqueFileName';
      final File savedImage = await imageFile.copy(newPath);

      final index = portfolioImages.indexOf(oldPath);
      if (index != -1) {
        portfolioImages[index] = newPath;

        // Delete Old File from Disk
        try {
          final oldFile = File(oldPath);
          if (await oldFile.exists()) {
            await oldFile.delete();
          }
        } catch (e) {
          print('Error deleting old file: $e');
        }

        await box.write(portfolioKey, portfolioImages.toList());
        Get.snackbar('Success', 'Portfolio image updated successfully!');
      } else {
        Get.snackbar('Error', 'Original image path not found.');
      }
    } else {
      Get.snackbar('Alert', 'No new image selected.');
    }
  }
}