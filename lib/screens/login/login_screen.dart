import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
    return Stack(
      children: [
        FlutterLogin(
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
            return await context.userProvider.register(data);
          },

          onSubmitAnimationCompleted: () {
            final user = context.userProvider.getLoginUsr();
            if (user?.sId != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            }
          },

          onRecoverPassword: (_) => null,
          hideForgotPasswordButton: true,

          theme: LoginTheme(
            primaryColor: secondaryColor,
            accentColor: primaryColor,
            authButtonPadding: EdgeInsets.all(24),
            buttonTheme: const LoginButtonTheme(
              backgroundColor: primaryColor,
            ),
            cardTheme: const CardTheme(
              color: Colors.black,
              surfaceTintColor: secondaryColor,
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
