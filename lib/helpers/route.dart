import 'package:get/get.dart';
import '../view/auth/Signup_screen.dart';
import '../view/auth/forgot_password_screen.dart';
import '../view/auth/login_screen.dart';
import '../view/auth/new_password_screen.dart';
import '../view/auth/otp_screen.dart';
import '../view/bookings/booking_screen.dart';
import '../view/bottom_nav/bottom_nav.dart';
import '../view/inbox/inbox_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/services/services_screen.dart';
import '../view/splash/onboarding_screen.dart';
import '../view/splash/sitter_onboarding_screen.dart';
import '../view/splash/splash_screen.dart';





class AppRoutes {

   static const String bottomNavScreen = "/bottom_nav";
  static const String splashScreen = "/splash_screen";
  static const String onboardingScreen = "/onboarding_screen";
  static const String loginScreen = "/login_screen";
  static const String signUpScreen = "/Signup_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String oTPScreen = "/otp_screen";
  static const String newPasswordScreen = "/new_password_screen";
  static const String servicesScreen = "/services_screen";
  static const String inboxScreen = "/inbox_screen";
  static const String bookingsScreen = "/booking_screen";
  static const String profileScreen = "/profile_screen";
  static const String sitter = "/sitter_onboarding_screen";



  static List<GetPage> routes = [

    GetPage(name: bottomNavScreen, page: () => BottomNavScreen()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: oTPScreen, page: () => OTPScreen()),
    GetPage(name: newPasswordScreen, page: () => NewPasswordScreen()),
    GetPage(name: servicesScreen, page: () => ServicesScreen()),
    GetPage(name: inboxScreen, page: () => InboxScreen()),
    GetPage(name: bookingsScreen, page: () => BookingsScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
GetPage(name: sitter, page: () => SitterOnboardingScreen())

  ];
}