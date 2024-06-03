import 'package:abhay_s_application1/presentation/admin_page/admin_page.dart';
import 'package:abhay_s_application1/presentation/admin_page/leaveapply.dart';
import 'package:abhay_s_application1/presentation/admin_page/staff_page.dart';
import 'package:abhay_s_application1/routes/entrycheck.dart';
import 'package:flutter/material.dart';
import 'package:abhay_s_application1/presentation/login_screen/login_screen.dart';
import 'package:abhay_s_application1/presentation/frame_seven_screen/frame_seven_screen.dart';
import 'package:abhay_s_application1/presentation/register_screen/register_screen.dart';
import 'package:abhay_s_application1/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:abhay_s_application1/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'Admin_Dashboard_leave_requests.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String frameSevenScreen = '/frame_seven_screen';

  static const String registerScreen = '/register_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String otpVerificationScreen = '/otp_verification_screen';

  static const String resetPasswordScreen = '/reset_password_screen';

  static const String passwordChangedScreen = '/password_changed_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String adminDashboardScreen = '/admin_dashboard_screen';

  static const String entryCheck = '/entry_check';

  static const String staffPage = '/staff_page';

  static const String adminMainDash = '/admin_main_dash';

  static const String leaveApply = '/leave_apply';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    frameSevenScreen: (context) => FrameSevenScreen(),
    registerScreen: (context) => RegisterScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    adminDashboardScreen: (context) => AdminDashboardScreen(),
    entryCheck: (context) => EntryCheck(),
    staffPage: (context) => StaffDashboardScreen(),
    adminMainDash: (context) => AdminDashboard(),
    leaveApply: (context) => LeaveApplication()
  };
}
