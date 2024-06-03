import 'package:abhay_s_application1/core/app_export.dart';
import 'package:abhay_s_application1/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:abhay_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:abhay_s_application1/widgets/custom_elevated_button.dart';
import 'package:abhay_s_application1/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 27.v),
                    child: Column(children: [
                      SizedBox(height: 2.v),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Forgot Password?",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 10.v),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: 310.h,
                              margin: EdgeInsets.only(right: 24.h),
                              child: Text(
                                  "Don't worry! It occurs. Please enter the email address linked with your account.",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium!
                                      .copyWith(height: 1.50)))),
                      SizedBox(height: 55.v),
                      CustomTextFormField(
                          controller: emailController,
                          hintText: "Enter your email",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress),
                      SizedBox(height: 30.v),
                      CustomElevatedButton(
                          text: "Send Reset Link",
                          onPressed: () {
                            onTapSendCode(context, emailController.text);
                          }),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            onTapTxtRememberpassword(context);
                          },
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Remember Password? ",
                                    style: CustomTextStyles.titleSmallPrimary),
                                TextSpan(
                                    text: "Login",
                                    style: CustomTextStyles.titleSmallCyan400)
                              ]),
                              textAlign: TextAlign.left))
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.fromLTRB(36.h, 7.v, 298.h, 7.v),
            onTap: () {
              onTapArrowLeft(context);
            }));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the otpVerificationScreen when the action is triggered.
  onTapSendCode(BuildContext context, String email) {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtRememberpassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
