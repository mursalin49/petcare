
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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

    // Clean up any corrupted images
    validateStoredImages();
  }

  // --- SAVE IMAGE TO PORTFOLIO (Used by Add Screen) ---
  Future<void> saveImageToPortfolio(File imageFile) async {
    try {
      // Verify the file exists and is readable
      if (!await imageFile.exists()) {
        Get.snackbar('Error', 'Selected image file not found');
        return;
      }

      final directory = await getApplicationDocumentsDirectory();

      // Get the original file extension
      final String extension = path.extension(imageFile.path).toLowerCase();
      final String validExtension = (extension == '.jpg' ||
          extension == '.jpeg' ||
          extension == '.png')
          ? extension
          : '.jpg';

      final String uniqueFileName =
          '${DateTime.now().millisecondsSinceEpoch}$validExtension';
      final String localPath = '${directory.path}/$uniqueFileName';

      // Copy the file
      final File savedImage = await imageFile.copy(localPath);

      // Verify the copied file exists
      if (await savedImage.exists()) {
        portfolioImages.add(savedImage.path);
        await box.write(portfolioKey, portfolioImages.toList());
        Get.snackbar('Success', 'Image added to portfolio!');
      } else {
        Get.snackbar('Error', 'Failed to save image');
      }
    } catch (e) {
      print('Error saving image: $e');
      Get.snackbar('Error', 'Failed to add image: ${e.toString()}');
    }
  }

  // --- DELETE IMAGE ---
  Future<void> deleteImage(String path) async {
    try {
      portfolioImages.remove(path);

      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }

      await box.write(portfolioKey, portfolioImages.toList());
      Get.snackbar('Success', 'Image deleted successfully');
    } catch (e) {
      print('Error deleting image: $e');
      Get.snackbar('Error', 'Failed to delete image');
    }
  }

  // --- REPLACE IMAGE WITH FILE (For editing) ---
  Future<void> replaceImageWithFile(String oldPath, File newImageFile) async {
    try {
      // Verify the new file exists
      if (!await newImageFile.exists()) {
        Get.snackbar('Error', 'Selected image file not found');
        return;
      }

      final directory = await getApplicationDocumentsDirectory();

      // Get the original file extension
      final String extension = path.extension(newImageFile.path).toLowerCase();
      final String validExtension = (extension == '.jpg' ||
          extension == '.jpeg' ||
          extension == '.png')
          ? extension
          : '.jpg';

      final String uniqueFileName =
          '${DateTime.now().millisecondsSinceEpoch}_edited$validExtension';
      final String newPath = '${directory.path}/$uniqueFileName';

      final File savedImage = await newImageFile.copy(newPath);

      // Verify the new file was saved
      if (await savedImage.exists()) {
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
        Get.snackbar('Error', 'Failed to save new image');
      }
    } catch (e) {
      print('Error replacing image: $e');
      Get.snackbar('Error', 'Failed to replace image: ${e.toString()}');
    }
  }

  // --- REPLACE IMAGE (Original method using picker) ---
  Future<void> replaceImage(String oldPath) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        await replaceImageWithFile(oldPath, imageFile);
      } else {
        Get.snackbar('Alert', 'No new image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
    }
  }

  // --- VALIDATE STORED IMAGES (Call this on init to clean up corrupted files) ---
  Future<void> validateStoredImages() async {
    List<String> validImages = [];

    for (String imagePath in portfolioImages) {
      final file = File(imagePath);
      if (await file.exists()) {
        try {
          // Try to read the file to verify it's valid
          await file.length();
          validImages.add(imagePath);
        } catch (e) {
          print('Invalid image file: $imagePath');
          // Delete invalid file
          try {
            await file.delete();
          } catch (e) {
            print('Could not delete invalid file: $e');
          }
        }
      }
    }

    if (validImages.length != portfolioImages.length) {
      portfolioImages.assignAll(validImages);
      await box.write(portfolioKey, portfolioImages.toList());
    }
  }
}