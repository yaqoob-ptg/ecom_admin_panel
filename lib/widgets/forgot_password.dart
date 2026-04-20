// import 'package:admin/screens/login/provider/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleForgotPassword() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final error = await userProvider.forgotPassword(_emailController.text);

//     setState(() => _isLoading = false);

//     if (error == null) {
//       // Show success dialog
//       _showSuccessDialog();
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Icon(Icons.email, size: 50, color: Colors.green),
//         content: const Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Check Your Email',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'We have sent a password reset link to your email address. '
//               'Please check your inbox and follow the instructions to reset your password.',
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
//             child: const Text('Back to Login'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
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
//                 Icons.lock_reset,
//                 size: 80,
//                 color: Colors.blue,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Reset Your Password',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Enter your email address and we\'ll send you a link to reset your password.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email Address',
//                   prefixIcon: const Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email address';
//                   }
//                   if (!value.contains('@') || !value.contains('.')) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleForgotPassword,
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
//                         'Send Reset Link',
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
