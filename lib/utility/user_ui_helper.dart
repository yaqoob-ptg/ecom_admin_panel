// lib/utils/user_ui_helper.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserUIHelper {
  static Color getRoleColor(String? role) {
    switch (role) {
      case 'superAdmin':
        return Colors.deepPurple;
      case 'admin':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  static String formatDate(DateTime? date) {
    if (date == null) return 'Never';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String formatDateString(String? dateStr) {
    if (dateStr == null) return 'Unknown';
    final date = DateTime.tryParse(dateStr);
    return formatDate(date);
  }

  static Widget buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }
}
