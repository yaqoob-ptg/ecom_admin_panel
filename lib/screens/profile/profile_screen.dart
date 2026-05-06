// import 'dart:io';
// import 'package:admin/screens/profile/provider/profile_provider.dart';
// import 'package:admin/screens/login/provider/user_provider.dart';
// import 'package:admin/utility/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Initialize profile data when page loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final profileProvider = context.read<ProfileProvider>();
//       final userProvider = context.read<UserProvider>();
//       profileProvider.loadUserData(userProvider);
//     });

//     return Scaffold(
//       backgroundColor: secondaryColor,
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         backgroundColor: bgColor,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Consumer<ProfileProvider>(
//         builder: (context, profileProvider, child) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(defaultPadding),
//             child: Form(
//               key: profileProvider.editProfileFormKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Profile Image Section
//                   Center(
//                     child: ProfileImageCard(
//                       imageFile: profileProvider.selectedImage,
//                       imageUrl: context.read<UserProvider>().user?.profileImage,
//                       onTap: () => profileProvider.pickImage(),
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Name Field
//                   CustomTextField(
//                     controller: profileProvider.nameCtrl,
//                     labelText: 'Full Name',
//                     prefixIcon: Icons.person_outline,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 16),

//                   // Email Field (disabled)
//                   CustomTextField(
//                     controller: TextEditingController(
//                       text: context.read<UserProvider>().user?.email ?? '',
//                     ),
//                     labelText: 'Email',
//                     prefixIcon: Icons.email_outlined,
//                     enabled: false,
//                   ),

//                   const SizedBox(height: 16),

//                   // Phone Field
//                   CustomTextField(
//                     controller: profileProvider.phoneCtrl,
//                     labelText: 'Phone Number',
//                     prefixIcon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 16),

//                   // Location Field
//                   CustomTextField(
//                     controller: profileProvider.locationCtrl,
//                     labelText: 'Location',
//                     prefixIcon: Icons.location_on_outlined,
//                   ),

//                   const SizedBox(height: 32),

//                   // Action Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.grey[700],
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 32,
//                             vertical: 12,
//                           ),
//                         ),
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: const Text('Cancel'),
//                       ),
//                       const SizedBox(width: 16),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: primaryColor,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 32,
//                             vertical: 12,
//                           ),
//                         ),
//                         onPressed: profileProvider.isLoading
//                             ? null
//                             : () {
//                                 if (profileProvider
//                                     .editProfileFormKey.currentState!
//                                     .validate()) {
//                                   profileProvider
//                                       .editProfileFormKey.currentState!
//                                       .save();
//                                   profileProvider.updateProfile(
//                                     context.read<UserProvider>(),
//                                   );
//                                 }
//                               },
//                         child: profileProvider.isLoading
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : const Text('Save Changes'),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Reusable Profile Image Card Widget
// class ProfileImageCard extends StatelessWidget {
//   final File? imageFile;
//   final String? imageUrl;
//   final VoidCallback onTap;

//   const ProfileImageCard({
//     Key? key,
//     required this.imageFile,
//     this.imageUrl,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         children: [
//           Container(
//             height: 120,
//             width: 120,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.grey[800],
//               border: Border.all(color: Colors.white24, width: 2),
//               image: imageFile != null
//                   ? DecorationImage(
//                       image: FileImage(imageFile!),
//                       fit: BoxFit.cover,
//                     )
//                   : (imageUrl != null && imageUrl!.isNotEmpty
//                       ? DecorationImage(
//                           image: NetworkImage(imageUrl!),
//                           fit: BoxFit.cover,
//                           onError: (exception, stackTrace) {
//                             print('Error loading profile image: $exception');
//                           },
//                         )
//                       : null),
//             ),
//             child:
//                 (imageFile == null && (imageUrl == null || imageUrl!.isEmpty))
//                     ? const Icon(
//                         Icons.person,
//                         size: 60,
//                         color: Colors.white54,
//                       )
//                     : null,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: secondaryColor,
//                   width: 3,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Reusable Custom TextField
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final IconData? prefixIcon;
//   final FormFieldValidator<String>? validator;
//   final TextInputType? keyboardType;
//   final bool enabled;

//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.labelText,
//     this.prefixIcon,
//     this.validator,
//     this.keyboardType,
//     this.enabled = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       enabled: enabled,
//       keyboardType: keyboardType,
//       style: TextStyle(
//         color: enabled ? Colors.white : Colors.white54,
//       ),
//       decoration: InputDecoration(
//         labelText: labelText,
//         labelStyle: TextStyle(
//           color: enabled ? Colors.white54 : Colors.white38,
//         ),
//         prefixIcon: Icon(
//           prefixIcon,
//           color: enabled ? Colors.white54 : Colors.white38,
//           size: 20,
//         ),
//         filled: true,
//         fillColor: enabled ? bgColor : bgColor.withOpacity(0.5),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.white10),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: primaryColor),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.white10),
//         ),
//       ),
//       validator: validator,
//     );
//   }
// }

// screens/profile/profile_screen.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:admin/screens/profile/provider/profile_provider.dart';
import 'package:admin/screens/login/provider/user_provider.dart';
import 'package:admin/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider = context.read<ProfileProvider>();
      final userProvider = context.read<UserProvider>();
      profileProvider.loadUserData(userProvider);
    });

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding * 1.5,
            ),
            child: Form(
              key: profileProvider.editProfileFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Profile Image Card ──────────────────────────
                    // In ProfileScreen build method, update the ProfileImageCard usage:
                    Center(
                      child: ProfileImageCard(
                        imageBytes: profileProvider
                            .imageBytes, // Changed from imageFile
                        imageUrl:
                            context.read<UserProvider>().user?.profileImage,
                        onTap: () => profileProvider.pickImage(),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Info Cards ──────────────────────────────────
                    _buildInfoCard(
                      context,
                      title: 'Personal Information',
                      icon: Icons.person_outline,
                      children: [
                        _buildTextField(
                          controller: profileProvider.nameCtrl,
                          label: 'Full Name',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: TextEditingController(
                            text:
                                context.read<UserProvider>().user?.email ?? '',
                          ),
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          enabled: false,
                          helperText: 'Email cannot be changed',
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildInfoCard(
                      context,
                      title: 'Contact Information',
                      icon: Icons.contact_phone_outlined,
                      children: [
                        _buildTextField(
                          controller: profileProvider.phoneCtrl,
                          label: 'Phone Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildLocationDropdown(
                          context,
                          profileProvider: profileProvider,
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    // ── Action Buttons ──────────────────────────────
                    _buildActionButtons(context, profileProvider),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Info Card Builder ────────────────────────────────────────
  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  // ── Text Field Builder ───────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    bool enabled = true,
    String? helperText,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      style: TextStyle(
        color: enabled ? Colors.white : Colors.white54,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? Colors.white54 : Colors.white38,
          fontSize: 14,
        ),
        helperText: helperText,
        helperStyle: TextStyle(
          color: Colors.white38,
          fontSize: 12,
        ),
        prefixIcon: Icon(
          icon,
          color: enabled ? Colors.white54 : Colors.white38,
          size: 20,
        ),
        filled: true,
        fillColor: enabled ? bgColor : bgColor.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
      ),
      validator: validator,
    );
  }

  // ── Location Dropdown Builder ────────────────────────────────
  Widget _buildLocationDropdown(
    BuildContext context, {
    required ProfileProvider profileProvider,
  }) {
    final locations = [
      'Saddar',
      'Tariq Road',
      'Hyderi',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: DropdownButtonFormField<String>(
            value: locations.contains(profileProvider.locationCtrl.text)
                ? profileProvider.locationCtrl.text
                : null,
            dropdownColor: secondaryColor,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white54,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            hint: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white54,
                  size: 20,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Select Your Location',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            isExpanded: true,
            items: locations.map((location) {
              return DropdownMenuItem<String>(
                value: location,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: profileProvider.locationCtrl.text == location
                          ? primaryColor
                          : Colors.white54,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      location,
                      style: TextStyle(
                        color: profileProvider.locationCtrl.text == location
                            ? primaryColor
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                profileProvider.locationCtrl.text = value;
                // Force rebuild
                profileProvider.notifyListeners();
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your location';
              }
              return null;
            },
          ),
        ),
        if (profileProvider.locationCtrl.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  profileProvider.locationCtrl.text,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ── Action Buttons Builder ──────────────────────────────────
  Widget _buildActionButtons(
    BuildContext context,
    ProfileProvider profileProvider,
  ) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white70,
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: profileProvider.isLoading
                  ? null
                  : () {
                      if (profileProvider.editProfileFormKey.currentState!
                          .validate()) {
                        profileProvider.editProfileFormKey.currentState!.save();
                        profileProvider.updateProfile(
                          context.read<UserProvider>(),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                disabledBackgroundColor: primaryColor.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: profileProvider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save_outlined, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Profile Image Card Widget ──────────────────────────────────
// Update in profile_screen.dart - This works on both web and mobile
class ProfileImageCard extends StatelessWidget {
  final Uint8List? imageBytes; // Changed from File to Uint8List
  final String? imageUrl;
  final VoidCallback onTap;

  const ProfileImageCard({
    Key? key,
    required this.imageBytes,
    this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              // Main Avatar Circle
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.3),
                      secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: secondaryColor,
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: _buildImage(),
                    ),
                  ),
                ),
              ),
              // Camera Button
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(
                      color: secondaryColor,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: onTap,
          icon: Icon(
            imageBytes != null || (imageUrl != null && imageUrl!.isNotEmpty)
                ? Icons.swap_horiz
                : Icons.cloud_upload_outlined,
            color: primaryColor,
            size: 18,
          ),
          label: Text(
            imageBytes != null
                ? 'Change Photo'
                : (imageUrl != null && imageUrl!.isNotEmpty
                    ? 'Change Photo'
                    : 'Upload Photo'),
            style: TextStyle(
              color: primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build the correct image widget
  Widget _buildImage() {
    // Check for newly picked image (bytes)
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      return Image.memory(
        imageBytes!,
        fit: BoxFit.cover,
        width: 130,
        height: 130,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Memory image error: $error');
          return const Icon(
            Icons.person,
            size: 65,
            color: Colors.white38,
          );
        },
      );
    }

    // Check for existing network image
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: 130,
        height: 130,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Network image error: $error');
          return const Icon(
            Icons.person,
            size: 65,
            color: Colors.white38,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: primaryColor,
              strokeWidth: 2,
            ),
          );
        },
      );
    }

    // Default placeholder
    return const Icon(
      Icons.person,
      size: 65,
      color: Colors.white38,
    );
  }
}
