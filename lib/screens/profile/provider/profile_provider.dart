// // // screens/profile/provider/profile_provider.dart
// // import 'dart:developer';
// // import 'dart:io';
// // import 'package:admin/models/api_response.dart';
// // import 'package:admin/utility/snack_bar_helper.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../../../services/http_services.dart';
// // import '../../../core/data/data_provider.dart';
// // import '../../login/provider/user_provider.dart';

// // class ProfileProvider extends ChangeNotifier {
// //   HttpService service = HttpService();
// //   final DataProvider _dataProvider;
// //   final editProfileFormKey = GlobalKey<FormState>();

// //   TextEditingController nameCtrl = TextEditingController();
// //   TextEditingController phoneCtrl = TextEditingController();
// //   TextEditingController locationCtrl = TextEditingController();

// //   File? selectedImage;
// //   XFile? imgXFile;
// //   bool isLoading = false;

// //   ProfileProvider(this._dataProvider);

// //   // Load current user data
// //   void loadUserData(UserProvider userProvider) {
// //     final user = userProvider.user;
// //     if (user != null) {
// //       nameCtrl.text = user.name ?? '';
// //       phoneCtrl.text = user.phone ?? '';
// //       locationCtrl.text = user.location ?? '';
// //     }
// //   }

// //   // Pick profile image
// //   void pickImage() async {
// //     final ImagePicker picker = ImagePicker();
// //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       selectedImage = File(image.path);
// //       imgXFile = image;
// //       notifyListeners();
// //     }
// //   }

// //   // Create form data (same pattern as category)
// //   Future<FormData> createFormData({
// //     required XFile? imgXFile,
// //     required Map<String, dynamic> formData,
// //   }) async {
// //     if (imgXFile != null) {
// //       MultipartFile multipartFile;
// //       if (kIsWeb) {
// //         String fileName = imgXFile.name;
// //         Uint8List byteImg = await imgXFile.readAsBytes();
// //         multipartFile = MultipartFile(byteImg, filename: fileName);
// //       } else {
// //         String fileName = imgXFile.path.split('/').last;
// //         multipartFile = MultipartFile(imgXFile.path, filename: fileName);
// //       }
// //       formData['profileImage'] = multipartFile;
// //     }
// //     final FormData form = FormData(formData);
// //     return form;
// //   }

// //   // Update profile
// //   Future<void> updateProfile(UserProvider userProvider) async {
// //     try {
// //       isLoading = true;
// //       notifyListeners();

// //       final user = userProvider.user;
// //       if (user?.sId == null) {
// //         SnackBarHelper.showErrorSnackBar("User not found");
// //         return;
// //       }

// //       Map<String, dynamic> formDataMap = {
// //         'name': nameCtrl.text.trim(),
// //         'phone': phoneCtrl.text.trim(),
// //         'location': locationCtrl.text.trim(),
// //       };

// //       final FormData form = await createFormData(
// //         imgXFile: imgXFile,
// //         formData: formDataMap,
// //       );

// //       final response = await service.updateItem(
// //         endpointUrl: 'users',
// //         itemId: user!.sId!,
// //         itemData: form,
// //       );

// //       if (response.isOk) {
// //         ApiResponse apiResponse = ApiResponse<dynamic>.fromJson(
// //           response.body,
// //           (json) => json,
// //         );

// //         if (apiResponse.success == true) {
// //           // Update local user data
// //           final updatedUser = user.copyWith(
// //             name: nameCtrl.text.trim(),
// //             phone: phoneCtrl.text.trim(),
// //             location: locationCtrl.text.trim(),
// //             profileImage:
// //                 apiResponse.data?['profileImage'] ?? user.profileImage,
// //           );

// //           await userProvider.saveLoginInfo(updatedUser);
// //           clearFields();
// //           SnackBarHelper.showSuccessSnackBar(
// //               apiResponse.message ?? 'Profile updated successfully');
// //           log("Profile updated");
// //           Get.back();
// //         } else {
// //           SnackBarHelper.showErrorSnackBar(
// //               "Failed to update profile: ${apiResponse.message}");
// //         }
// //       } else {
// //         SnackBarHelper.showErrorSnackBar(
// //             "Error: ${response.body?['message'] ?? response.statusText}");
// //       }
// //     } catch (e) {
// //       print(e);
// //       SnackBarHelper.showErrorSnackBar("An error occurred: $e");
// //     } finally {
// //       isLoading = false;
// //       notifyListeners();
// //     }
// //   }

// //   clearFields() {
// //     nameCtrl.clear();
// //     phoneCtrl.clear();
// //     locationCtrl.clear();
// //     selectedImage = null;
// //     imgXFile = null;
// //   }

// //   @override
// //   void dispose() {
// //     nameCtrl.dispose();
// //     phoneCtrl.dispose();
// //     locationCtrl.dispose();
// //     super.dispose();
// //   }
// // }

// // screens/profile/provider/profile_provider.dart
// import 'dart:developer';
// import 'dart:io';
// import 'package:admin/models/api_response.dart';
// import 'package:admin/utility/snack_bar_helper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../services/http_services.dart';
// import '../../../core/data/data_provider.dart';
// import '../../login/provider/user_provider.dart';

// class ProfileProvider extends ChangeNotifier {
//   HttpService service = HttpService();
//   final DataProvider _dataProvider;
//   final editProfileFormKey = GlobalKey<FormState>();

//   TextEditingController nameCtrl = TextEditingController();
//   TextEditingController phoneCtrl = TextEditingController();
//   TextEditingController locationCtrl = TextEditingController();

//   File? selectedImage;
//   XFile? imgXFile;
//   bool isLoading = false;

//   ProfileProvider(this._dataProvider);

//   // Load current user data
//   void loadUserData(UserProvider userProvider) {
//     final user = userProvider.user;
//     if (user != null) {
//       nameCtrl.text = user.name ?? '';
//       phoneCtrl.text = user.phone ?? '';
//       locationCtrl.text = user.location ?? '';
//       notifyListeners(); // 🔥 Important for dropdown
//     }
//   }

//   // Pick profile image
//   void pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 512,
//       maxHeight: 512,
//       imageQuality: 85,
//     );
//     if (image != null) {
//       selectedImage = File(image.path);
//       imgXFile = image;
//       notifyListeners();
//     }
//     debugPrint('Image path: ${image?.path}');
//     debugPrint('Image name: ${image?.name}');
//     debugPrint('Image mimeType: ${image?.mimeType}');
//     debugPrint('Image length: ${await image?.length()}');
//   }

//   // Create form data (same pattern as category)
//   Future<FormData> createFormData({
//     required XFile? imgXFile,
//     required Map<String, dynamic> formData,
//   }) async {
//     if (imgXFile != null) {
//       MultipartFile multipartFile;
//       if (kIsWeb) {
//         String fileName = imgXFile.name;
//         Uint8List byteImg = await imgXFile.readAsBytes();
//         multipartFile = MultipartFile(byteImg, filename: fileName);
//       } else {
//         String fileName = imgXFile.path.split('/').last;
//         multipartFile = MultipartFile(imgXFile.path, filename: fileName);
//       }
//       formData['profileImage'] = multipartFile;
//     }
//     final FormData form = FormData(formData);
//     debugPrint('Creating form data with image: ${imgXFile?.path}');
//     debugPrint('Form data map: $formData');
//     return form;
//   }

//   // Update profile
//   Future<void> updateProfile(UserProvider userProvider) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       final user = userProvider.user;
//       if (user?.sId == null) {
//         SnackBarHelper.showErrorSnackBar("User not found");
//         return;
//       }

//       Map<String, dynamic> formDataMap = {
//         'name': nameCtrl.text.trim(),
//         'phone': phoneCtrl.text.trim(),
//         'location': locationCtrl.text.trim(),
//       };

//       final FormData form = await createFormData(
//         imgXFile: imgXFile,
//         formData: formDataMap,
//       );

//       final response = await service.updateItem(
//         endpointUrl: 'users',
//         itemId: user!.sId!,
//         itemData: form,
//       );

//       if (response.isOk) {
//         ApiResponse apiResponse = ApiResponse<dynamic>.fromJson(
//           response.body,
//           (json) => json,
//         );

//         if (apiResponse.success == true) {
//           // Update local user data
//           final updatedUser = user.copyWith(
//             name: nameCtrl.text.trim(),
//             phone: phoneCtrl.text.trim(),
//             location: locationCtrl.text.trim(),
//             profileImage:
//                 apiResponse.data?['profileImage'] ?? user.profileImage,
//           );

//           await userProvider.saveLoginInfo(updatedUser);
//           clearFields();
//           SnackBarHelper.showSuccessSnackBar(
//               apiResponse.message ?? 'Profile updated successfully');
//           log("Profile updated");
//           Get.back();
//         } else {
//           SnackBarHelper.showErrorSnackBar(
//               "Failed to update profile: ${apiResponse.message}");
//         }
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//             "Error: ${response.body?['message'] ?? response.statusText}");
//       }
//     } catch (e) {
//       print(e);
//       SnackBarHelper.showErrorSnackBar("An error occurred: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   clearFields() {
//     nameCtrl.clear();
//     phoneCtrl.clear();
//     locationCtrl.clear();
//     selectedImage = null;
//     imgXFile = null;
//   }

//   @override
//   void dispose() {
//     nameCtrl.dispose();
//     phoneCtrl.dispose();
//     locationCtrl.dispose();
//     super.dispose();
//   }
// }

// screens/profile/provider/profile_provider.dart
import 'dart:developer';
import 'dart:typed_data';
import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/http_services.dart';
import '../../../core/data/data_provider.dart';
import '../../login/provider/user_provider.dart';

class ProfileProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final editProfileFormKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();

  // ── Image handling ────────────────────────────────────────
  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  // For preview: store bytes for web, path for mobile
  Uint8List? _imageBytes;
  Uint8List? get imageBytes => _imageBytes;

  bool isLoading = false;
  bool isWeb = kIsWeb;

  ProfileProvider(this._dataProvider);

  // Load current user data
  void loadUserData(UserProvider userProvider) {
    final user = userProvider.user;
    if (user != null) {
      nameCtrl.text = user.name ?? '';
      phoneCtrl.text = user.phone ?? '';
      locationCtrl.text = user.location ?? '';
      notifyListeners();
    }
  }

  // Pick profile image - WORKS ON BOTH WEB AND MOBILE
  void pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        _imageFile = image;

        // Read bytes for preview (works on both web and mobile)
        _imageBytes = await image.readAsBytes();

        debugPrint('Image picked successfully');
        debugPrint('Image name: ${image.name}');
        debugPrint('Image mimeType: ${image.mimeType}');
        debugPrint('Image bytes length: ${_imageBytes?.length}');
        debugPrint('Image path: ${image.path}');

        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      SnackBarHelper.showErrorSnackBar('Failed to pick image: $e');
    }
  }

  // Create form data - WORKS ON BOTH WEB AND MOBILE
  Future<FormData> createFormData({
    required XFile? imgXFile,
    required Map<String, dynamic> formData,
  }) async {
    try {
      if (imgXFile != null) {
        MultipartFile multipartFile;

        if (kIsWeb) {
          // 🌐 Web platform
          final bytes = await imgXFile.readAsBytes();
          multipartFile = MultipartFile(
            bytes,
            filename: imgXFile.name,
          );
          debugPrint(
              'Web multipart created: ${imgXFile.name}, ${bytes.length} bytes');
        } else {
          // 📱 Mobile platform
          multipartFile = MultipartFile(
            imgXFile.path,
            filename: imgXFile.name,
          );
          debugPrint('Mobile multipart created: ${imgXFile.path}');
        }

        formData['profileImage'] = multipartFile;
      }

      final FormData form = FormData(formData);
      return form;
    } catch (e) {
      debugPrint('Error creating form data: $e');
      rethrow;
    }
  }

  // Update profile
  Future<void> updateProfile(UserProvider userProvider) async {
    try {
      isLoading = true;
      notifyListeners();

      final user = userProvider.user;
      if (user?.sId == null) {
        SnackBarHelper.showErrorSnackBar("User not found");
        return;
      }

      Map<String, dynamic> formDataMap = {
        'name': nameCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'location': locationCtrl.text.trim(),
      };

      debugPrint('Updating profile for user: ${user!.sId}');
      debugPrint('Form data: $formDataMap');
      debugPrint('Has image: ${_imageFile != null}');

      final FormData form = await createFormData(
        imgXFile: _imageFile,
        formData: formDataMap,
      );

      final response = await service.updateItem(
        endpointUrl: 'users',
        itemId: user.sId!,
        itemData: form,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse<dynamic>.fromJson(
          response.body,
          (json) => json,
        );

        if (apiResponse.success == true) {
          // Get updated profile image URL from response
          String? updatedImageUrl;
          if (apiResponse.data is Map) {
            updatedImageUrl = apiResponse.data?['profileImage'];
          }

          // Update local user data
          final updatedUser = user.copyWith(
            name: nameCtrl.text.trim(),
            phone: phoneCtrl.text.trim(),
            location: locationCtrl.text.trim(),
            profileImage: updatedImageUrl ?? user.profileImage,
          );

          await userProvider.saveLoginInfo(updatedUser);

          clearFields();
          SnackBarHelper.showSuccessSnackBar(
              apiResponse.message ?? 'Profile updated successfully');
          log("Profile updated successfully");
          Get.back();
        } else {
          SnackBarHelper.showErrorSnackBar(
              "Failed to update profile: ${apiResponse.message}");
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            "Error: ${response.body?['message'] ?? response.statusText}");
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      SnackBarHelper.showErrorSnackBar("An error occurred: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearFields() {
    nameCtrl.clear();
    phoneCtrl.clear();
    locationCtrl.clear();
    _imageFile = null;
    _imageBytes = null;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    locationCtrl.dispose();
    super.dispose();
  }
}
