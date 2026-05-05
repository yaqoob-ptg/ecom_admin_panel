import 'dart:developer';

import 'package:admin/core/data/data_provider.dart';
import 'package:admin/core/routes/app_pages.dart';
import 'package:admin/models/api_response.dart';
import 'package:admin/models/user.dart';
import 'package:admin/services/http_services.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/extensions.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final box = GetStorage();
  User? _user;
  User? get user => _user;

  UserProvider(this._dataProvider) {
    _initUser(); // 🔥 load on startup
  }

  void _initUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _user = getLoginUsr();
      print(" UserProvider initialized with user: $_user");
      notifyListeners();
    });
  }

  // ─── Login ────────────────────────────────────────────────────────────────
  Future<String?> login(LoginData data, {String? endpoint}) async {
    try {
      Map<String, dynamic> loginData = {
        "email": data.name.toLowerCase().trim(), // data.name holds email field
        "password": data.password,
      };
      // Add requiredRole only if endpoint is NOT provided
      if (endpoint == null) {
        loginData['requiredRole'] = 'admin';
      }
      print(loginData);

      final response = await service.addItem(
        endpointUrl: endpoint ?? 'users/login',
        itemData: loginData,
      );

      if (response.isOk) {
        final ApiResponse<User> apiResponse = ApiResponse<User>.fromJson(
          response.body,
          (json) => User.fromJson(json as Map<String, dynamic>),
        );

        if (apiResponse.success == true) {
          // ── Block unverified users on app side too ───────────────────────
          if (apiResponse.data?.isVerified == false) {
            SnackBarHelper.showErrorSnackBar(
              'Please verify your email before logging in.',
            );
            return 'Email not verified';
          }
          // Save tokens and user info
          await box.write('accessToken', response.body['accessToken']);
          await box.write('refreshToken', response.body['refreshToken']);
          await saveLoginInfo(apiResponse.data);
          SnackBarHelper.showSuccessSnackBar(
              apiResponse.message ?? 'Login successful');
          log('Login success');
          return null;
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Login: ${apiResponse.message}');
          return apiResponse.message ?? 'Failed to Login';
        }
      } else {
        final msg = response.body?['message'] ?? response.statusText;
        SnackBarHelper.showErrorSnackBar('Error: $msg');
        return 'Error: $msg';
      }
    } catch (e) {
      log('Login error: $e');
      SnackBarHelper.showErrorSnackBar('An error occurred. Please try again.');
      return 'An error occurred: $e';
    }
  }

  // ─── Forgot Password - Request Reset ─────────────────────────────────────
  Future<String?> forgotPassword(String email) async {
    try {
      final response = await service.addItem(
        endpointUrl: 'users/forgot-password',
        itemData: {'email': email.trim().toLowerCase()},
      );

      if (response.statusCode == 429) {
        final message = response.body?['message'] ??
            'Too many requests. Please try again later.';
        SnackBarHelper.showErrorSnackBar(message);
        return message;
      }

      if (response.isOk) {
        final ApiResponse apiResponse =
            ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          final remainingAttempts = response.body?['remainingAttempts'];
          String successMessage =
              apiResponse.message ?? 'Password reset link has been sent.';
          if (remainingAttempts != null) {
            successMessage +=
                ' You have $remainingAttempts attempts remaining today.';
          }
          SnackBarHelper.showSuccessSnackBar(successMessage);
          return null;
        } else {
          SnackBarHelper.showErrorSnackBar(
            apiResponse.message ?? 'Failed to send reset link',
          );
          return apiResponse.message ?? 'Failed to send reset link';
        }
      } else {
        final msg = response.body?['message'] ?? response.statusText;
        SnackBarHelper.showErrorSnackBar('Error: $msg');
        return 'Error: $msg';
      }
    } catch (e) {
      log('Forgot password error: $e');
      SnackBarHelper.showErrorSnackBar('An error occurred. Please try again.');
      return 'An error occurred: $e';
    }
  }

  // ─── Reset Password ─────────────────────────────────────────────────────
  // Future<String?> resetPassword(
  //     String token, String newPassword, String confirmPassword) async {
  //   try {
  //     final response = await service.addItem(
  //       endpointUrl: 'users/reset-password/$token',
  //       itemData: {
  //         'password': newPassword,
  //         'confirmPassword': confirmPassword,
  //       },
  //     );

  //     if (response.isOk) {
  //       final ApiResponse apiResponse =
  //           ApiResponse.fromJson(response.body, null);

  //       if (apiResponse.success == true) {
  //         SnackBarHelper.showSuccessSnackBar(
  //           apiResponse.message ?? 'Password reset successfully! Please login.',
  //         );
  //         log('Password reset successful');
  //         return null;
  //       } else {
  //         SnackBarHelper.showErrorSnackBar(
  //           apiResponse.message ?? 'Failed to reset password',
  //         );
  //         return apiResponse.message ?? 'Failed to reset password';
  //       }
  //     } else {
  //       final msg = response.body?['message'] ?? response.statusText;
  //       SnackBarHelper.showErrorSnackBar('Error: $msg');
  //       return 'Error: $msg';
  //     }
  //   } catch (e) {
  //     log('Reset password error: $e');
  //     SnackBarHelper.showErrorSnackBar('An error occurred. Please try again.');
  //     return 'An error occurred: $e';
  //   }
  // }

  // ─── Verify Reset Token ─────────────────────────────────────────────────
  Future<bool> verifyResetToken(String token) async {
    try {
      final response = await service.getItems(
        endpointUrl: 'users/verify-reset-token/$token',
      );

      if (response.isOk && response.body['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      log('Verify token error: $e');
      return false;
    }
  }

  // ─── Register ─────────────────────────────────────────────────────────────
  Future<String?> register(SignupData data) async {
    try {
      // Pull extra fields added in additionalSignupFields
      final phone = data.additionalSignupData?['phone'] ?? '';
      final fullName = data.additionalSignupData?['fullName'] ?? '';
      final location =
          (data.additionalSignupData?['location'] ?? '').toString().trim();

      Map<String, dynamic> registerData = {
        "name": fullName.trim(),
        "email": data.name?.toLowerCase().trim() ??
            '', // flutter_login uses name for email field
        "phone": phone.trim(),
        'location': location.trim(),
        "password": data.password ?? '',
        'role': 'admin',
      };

      final response = await service.addItem(
        endpointUrl: 'users/register',
        itemData: registerData,
      );

      if (response.isOk) {
        final ApiResponse apiResponse =
            ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          // ── Show email verification message instead of auto-login ────────
          SnackBarHelper.showSuccessSnackBar(
            apiResponse.message ??
                'Registration successful! Please check your email to verify your account.',
          );
          log('Register Success');
          return null;
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Register: ${apiResponse.message}');
          return apiResponse.message ?? 'Failed to Register';
        }
      } else {
        final msg = response.body?['message'] ?? response.statusText;
        SnackBarHelper.showErrorSnackBar('Error: $msg');
        return 'Error: $msg';
      }
    } catch (e) {
      log('Register error: $e');
      SnackBarHelper.showErrorSnackBar('An error occurred. Please try again.');
      return 'An error occurred: $e';
    }
  }

  // ─── Save Login Info ──────────────────────────────────────────────────────
  // Future<void> saveLoginInfo(User? loginUser) async {
  //   await box.write(USER_INFO_BOX, loginUser?.toJson());
  // }
  Future<void> saveLoginInfo(User? loginUser) async {
    _user = loginUser;
    await box.write(USER_INFO_BOX, loginUser?.toJson());
    notifyListeners(); // 🔥 important
  }

  // ─── Get Logged In User ───────────────────────────────────────────────────
  User? getLoginUsr() {
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
    if (userJson == null) return null;
    return User.fromJson(userJson);
  }

// ─── Logout ───────────────────────────────────────────────────────────────
  void logOutUser() {
    _user = null;
    box.remove(USER_INFO_BOX);
    box.remove('accessToken');
    box.remove('refreshToken');
    // Reset DataProvider state
    try {
      final context = Get.context;
      if (context != null) {
        context.dataProvider.clearData();
      }
    } catch (e) {
      print("Error clearing data: $e");
    }
    notifyListeners();
    Get.offAllNamed(AppPages.LOGIN);
  }
}
