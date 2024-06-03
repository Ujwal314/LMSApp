import 'package:abhay_s_application1/core/app_export.dart';
import 'package:abhay_s_application1/widgets/custom_elevated_button.dart';
import 'package:abhay_s_application1/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController sickLeavesController = TextEditingController();

  TextEditingController casualLeavesController = TextEditingController();

  TextEditingController paidLeavesController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: null,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Row(
                children: [
                  Icon(
                    Icons.supervisor_account,
                    color: Colors.black,
                    size: 42.fSize,
                  ),
                  SizedBox(
                    width: 6.h,
                  ),
                  Text("LEAVE MANAGER",
                      style: theme.textTheme.headlineLarge!
                          .copyWith(fontSize: 36.fSize)),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 22.h, vertical: 25.v),
                      child: Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: 272.h,
                                margin: EdgeInsets.only(right: 58.h),
                                child: Text("Register Staff",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.headlineLarge!
                                        .copyWith(height: 1.30)))),
                        SizedBox(height: 51.v),
                        _buildUserName(context),
                        SizedBox(height: 15.v),
                        _buildEmail(context),
                        SizedBox(height: 15.v),
                        _buildPassword(context),
                        SizedBox(height: 15.v),
                        _buildConfirmPassword(context),
                        SizedBox(height: 15.v),
                        _buildLeaves(context),
                        SizedBox(height: 20.v),
                        _buildAgreeAndRegister(context),
                      ]))),
            )));
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return CustomTextFormField(
        controller: userNameController, hintText: "Full Name");
  }

  Widget _buildLeaves(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            controller: sickLeavesController, hintText: "Sick Leaves"),
        CustomTextFormField(
            controller: casualLeavesController, hintText: "Casual Leaves"),
        CustomTextFormField(
            controller: paidLeavesController, hintText: "Paid Leaves"),
      ],
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress);
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        obscureText: true);
  }

  /// Section Widget
  Widget _buildConfirmPassword(BuildContext context) {
    return CustomTextFormField(
        controller: confirmPasswordController,
        hintText: "Confirm password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: true);
  }

  /// Section Widget
  Widget _buildAgreeAndRegister(BuildContext context) {
    return CustomElevatedButton(
        text: "Register Staff",
        onPressed: () {
          onTapAgreeAndRegister(context);
        });
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapAgreeAndRegister(BuildContext context) {
    registerUser(
        userNameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        sickLeavesController.text,
        casualLeavesController.text,
        paidLeavesController.text);
    Navigator.pop(context);
  }

  registerUser(String username, String email, String pass, String confPass,
      String sickleaves, String casualleaves, String paidleaves) async {
    try {
      if (pass != confPass) {
        return;
      }
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (credential.user != null) credential.user?.updateDisplayName(username);
      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user?.uid)
          .set({'name': username, 'type': 1, 'sickleave': int.parse(sickleaves),'casualleave': int.parse(casualleaves),'paidleave': int.parse(paidleaves)});
    } catch (e) {
      print(e);
    }
  }
}
