import 'package:admin/core/routes/app_pages.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedLocation;
  bool isSignup = false;
  final List<String> locations = [
    'Saddar',
    'Tariq Road',
    'Hyderi',
  ];
  @override
  Widget build(BuildContext context) {
    final List<UserFormField>? fields = [
      UserFormField(
        keyName: 'fullName',
        displayName: 'Company/Shop Name',
        icon: const Icon(Icons.person),
        fieldValidator: (value) {
          if (value == null || value.isEmpty) return 'Name is required';
          return null;
        },
      ),
      UserFormField(
        keyName: 'phone',
        displayName: 'Phone Number',
        icon: const Icon(Icons.phone),
        fieldValidator: (value) {
          if (value == null || value.isEmpty) return 'Phone is required';
          return null;
        },
      ),
    ];
    Widget headerWidget() {
      return isSignup
          ? Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLocation,
                      hint: Text(
                        "Select Location",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w100),
                      ),
                      isExpanded: true,
                      items: locations.map((loc) {
                        return DropdownMenuItem(
                          value: loc,
                          child: Text(loc),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),
              ],
            )
          : const SizedBox.shrink();
    }

    return Stack(
      children: [
        FlutterLogin(
          headerWidget: headerWidget(),
          loginAfterSignUp: false,
          logo: const AssetImage('assets/images/logo.png'),

          // ─── Field config: use Email label ──────────────────────────────────
          userType: LoginUserType.email,

          // ─── Additional signup fields: phone & name ──────────────────────────
          additionalSignupFields: fields,

          onLogin: (loginData) async {
            return await context.userProvider.login(loginData);
          },

          onSignup: (SignupData data) async {
            // return await context.userProvider.register(data);
            if (selectedLocation == null) {
              return "Please select location";
            }

            // attach custom field into signup data
            // data.additionalSignupData ??= {};
            data.additionalSignupData!['location'] = selectedLocation!;

            return await context.userProvider.register(data);
          },

          onSubmitAnimationCompleted: () async {
            final user = await context.userProvider.getLoginUsr();
            if (user?.sId != null) {
              Get.offAllNamed(AppPages.HOME);
            } else {
              Get.offAllNamed(AppPages.LOGIN);
            }
          },

          onSwitchAuthMode: (mode) {
            setState(() {
              isSignup = mode == AuthMode.signup;
            });
          },

          // ✅ UPDATED: Implement forgot password functionality
          onRecoverPassword: (email) async {
            // Show loading indicator
            // Get.dialog(
            //   const Center(child: CircularProgressIndicator()),
            //   barrierDismissible: false,
            // );

            // Call the forgot password function
            final result =
                await context.userProvider.forgotPassword(email ?? '');

            // Close loading dialog
            Get.back();

            if (result == null) {
              // Success - show dialog with instructions
              Get.dialog(
                AlertDialog(
                  title: const Icon(Icons.email, size: 50, color: Colors.green),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Check Your Email',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'We have sent a password reset link to your email address. '
                        'Please check your inbox and follow the instructions to reset your password.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
              return null; // Return null to indicate success
            } else {
              // Error - show error message
              Get.snackbar(
                'Error',
                result,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              return result; // Return error message to flutter_login
            }
          },
          theme: LoginTheme(
            primaryColor: secondaryColor,
            accentColor: primaryColor,
            authButtonPadding: EdgeInsets.all(24),
            buttonTheme: const LoginButtonTheme(
              backgroundColor: primaryColor,
            ),
            cardTheme: const CardTheme(
              color: Colors.black,
              // surfaceTintColor: secondaryColor,
            ),
            titleStyle: const TextStyle(color: Colors.black),
          ),

          // ─── Guest login button ──────────────────────────────────────────────
          // footer: 'Continue as Guest',
        ),
        // Positioned(
        //   bottom: 150, // Adjust this value to align with the bottom of the card
        //   left: 0,
        //   right: 0,
        //   child: Center(
        //     child: TextButton(
        //       onPressed: () async {
        //         // Call the guest login logic from your UserProvider
        //         await context.userProvider.loginAsGuest();
        //       },
        //       child: const Text(
        //         'Continue as Guest',
        //         style: TextStyle(
        //           color: AppColor.darkOrange,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16,
        //           decoration: TextDecoration.underline,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
