import 'package:get/get.dart';
import 'package:vapmotorista/views/panding_verification_view.dart';

import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/otp_verification_view.dart';
import '../views/register_view.dart';
import '../views/reset_password_request.dart';
import '../views/splash_view.dart';

class AppPages {
  static const String initialRoute = '/';

  static final routes = [
    GetPage(name: '/', page: () => const SplashView()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/register', page: () => const RegisterView()),
    GetPage(name: '/verify-otp', page: () => OtpVerificationView()),
    GetPage(
        name: '/pending-verification',
        page: () => const PendingVerificationView()),
    GetPage(name: '/reset-password', page: () => ResetPasswordRequestView()),
    GetPage(name: '/home', page: () => HomeView()),
  ];
}
