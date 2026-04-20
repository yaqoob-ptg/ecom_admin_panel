// import 'package:admin/screens/login/provider/user_provider.dart';
// import 'package:admin/widgets/forgot_password.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   final String token;

//   const ResetPasswordScreen({
//     Key? key,
//     required this.token,
//   }) : super(key: key);

//   @override
//   State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   bool _isTokenValid = true;
//   bool _isCheckingToken = true;

//   @override
//   void initState() {
//     super.initState();
//     _checkToken();
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _checkToken() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final isValid = await userProvider.verifyResetToken(widget.token);

//     setState(() {
//       _isTokenValid = isValid;
//       _isCheckingToken = false;
//     });
//   }

//   Future<void> _handleResetPassword() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final error = await userProvider.resetPassword(
//       widget.token,
//       _passwordController.text,
//       _confirmPasswordController.text,
//     );

//     setState(() => _isLoading = false);

//     if (error == null) {
//       _showSuccessDialog();
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Icon(Icons.check_circle, size: 50, color: Colors.green),
//         content: const Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Password Reset Successful!',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Your password has been reset successfully. '
//               'You can now login with your new password.',
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//               Navigator.of(context).pop(); // Go back to login
//             },
//             child: const Text('Go to Login'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isCheckingToken) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (!_isTokenValid) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Reset Password')),
//         body: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.error_outline,
//                 size: 80,
//                 color: Colors.red,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Invalid or Expired Link',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'This password reset link is invalid or has expired. '
//                 'Please request a new password reset link.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Go back to login
//                 },
//                 child: const Text('Back to Login'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Go back to forgot password
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const ForgotPasswordScreen(),
//                     ),
//                   );
//                 },
//                 child: const Text('Request New Link'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reset Password'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Icon(
//                 Icons.lock_outline,
//                 size: 80,
//                 color: Colors.blue,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Create New Password',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Please enter your new password below.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'New Password',
//                   prefixIcon: const Icon(Icons.lock),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   prefixIcon: const Icon(Icons.lock_outline),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value != _passwordController.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleResetPassword,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: _isLoading
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.white),
//                         ),
//                       )
//                     : const Text(
//                         'Reset Password',
//                         style: TextStyle(fontSize: 16),
//                       ),
//               ),
//               const SizedBox(height: 10),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Back to Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
