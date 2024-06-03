import 'package:abhay_s_application1/core/app_export.dart';
import 'package:abhay_s_application1/widgets/custom_elevated_button.dart';
import 'package:abhay_s_application1/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            // appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 25.v),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  width: 272.h,
                                  margin: EdgeInsets.only(right: 60.h),
                                  child: Text("Leave Management System!!",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.headlineLarge!
                                          .copyWith(height: 1.30)))),
                          SizedBox(height: 51.v),
                          CustomTextFormField(
                              controller: emailController,
                              hintText: "Enter your email",
                              textInputType: TextInputType.emailAddress),
                          SizedBox(height: 15.v),
                          CustomTextFormField(
                              controller: passwordController,
                              hintText: "Enter your password",
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              suffix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      12.h, 17.v, 9.h, 17.v),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.h)),
                                  child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgFluenteye20filled,
                                      height: 22.v,
                                      width: 21.h)),
                              suffixConstraints:
                                  BoxConstraints(maxHeight: 56.v),
                              obscureText: true,
                              contentPadding: EdgeInsets.only(
                                  left: 20.h, top: 19.v, bottom: 19.v)),
                          SizedBox(height: 6.v),
                          Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () {
                                    onTapTxtForgotPassword(context);
                                  },
                                  child: Text("Forgot Password?",
                                      style:
                                          CustomTextStyles.titleSmallGray600))),
                          SizedBox(height: 67.v),
                          CustomElevatedButton(
                            text: "Login",
                            onPressed: () {
                              userLogin(emailController.text,
                                  passwordController.text, context);
                            },
                          ),
                          SizedBox(height: 31.v),
                          _buildLoginWith(context),
                          SizedBox(height: 21.v),
                          _buildEleven(context),
                          SizedBox(height: 83.v),
                        ])))));
  }

  /// Section Widget
  Widget _buildLoginWith(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 8.v),
          child: SizedBox(width: 111.h, child: Divider())),
      Text("Or Login with", style: CustomTextStyles.titleSmallGray600),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 8.v),
          child: SizedBox(width: 110.h, child: Divider()))
    ]);
  }

  /// Section Widget
  Widget _buildEleven(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          height: 56.v,
          width: 105.h,
          padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 14.v),
          decoration: AppDecoration.outlineOnPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: CustomImageView(
              imagePath: ImageConstant.imgFacebookIc,
              height: 26.adaptSize,
              width: 26.adaptSize,
              alignment: Alignment.center)),
      Container(
          height: 56.v,
          width: 105.h,
          padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 14.v),
          decoration: AppDecoration.outlineOnPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: CustomImageView(
              imagePath: ImageConstant.imgGoogleIc,
              height: 26.adaptSize,
              width: 26.adaptSize,
              alignment: Alignment.center)),
      Container(
          height: 56.v,
          width: 105.h,
          padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 14.v),
          decoration: AppDecoration.outlineOnPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: CustomImageView(
              imagePath: ImageConstant.imgCibApple,
              height: 26.adaptSize,
              width: 26.adaptSize,
              alignment: Alignment.center))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  /// Navigates to the registerScreen when the action is triggered.

  userLogin(String email, String pass, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      DocumentSnapshot<Map<String, dynamic>>? doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(credential.user?.uid)
          .get();
      if (doc['type'] == 0)
        Navigator.pushReplacementNamed(context, AppRoutes.adminDashboardScreen,
            arguments: {'uid': credential.user?.uid});
      else
        Navigator.pushReplacementNamed(context, AppRoutes.staffPage,
            arguments: {'uid': credential.user?.uid});
    } catch (e) {
      print(e);
    }
  }
}
