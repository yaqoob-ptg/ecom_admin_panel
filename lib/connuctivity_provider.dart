import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isOverlayOpen = false;

  ConnectivityProvider() {
    _checkInitialConnection(); // check on startup
    _connectivity.onConnectivityChanged.listen(_handleConnectionChange);
  }

  // NEW: checks state at startup, not just on change
  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _handleConnectionChange(results);
  }

  void _handleConnectionChange(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      _showNoInternetOverlay();
    } else {
      _hideNoInternetOverlay();
    }
  }

  void _showNoInternetOverlay() {
    if (_isOverlayOpen) return;

    // ✅ Wait for context to be ready before showing dialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isOverlayOpen) return;
      _isOverlayOpen = true;

      Get.dialog(
        PopScope(
          canPop: false,
          child: Material(
            color: Colors.black54,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi_off_rounded, size: 70, color: Colors.red),
                    SizedBox(height: 20),
                    Text(
                      "No Internet",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please check your connection.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    });
  }

  void _hideNoInternetOverlay() {
    if (_isOverlayOpen) {
      if (Get.isDialogOpen ?? false) Get.back();
      _isOverlayOpen = false;
    }
  }
}
