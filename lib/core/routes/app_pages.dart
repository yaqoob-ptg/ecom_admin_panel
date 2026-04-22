import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/superAdmin/login/login_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/main/main_screen.dart';

class AppPages {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SUPERADMINLOGIN = '/superAdminLogin';

  static final routes = [
    GetPage(name: HOME, fullscreenDialog: true, page: () => MainScreen()),
    GetPage(name: LOGIN, fullscreenDialog: true, page: () => LoginScreen()),
    GetPage(
        name: SUPERADMINLOGIN,
        fullscreenDialog: true,
        page: () => LoginScreenSuperAdmin()),
  ];
}
