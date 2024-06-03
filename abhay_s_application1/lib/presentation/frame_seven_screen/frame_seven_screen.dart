import 'package:abhay_s_application1/core/app_export.dart';
import 'package:abhay_s_application1/widgets/custom_elevated_button.dart';
import 'package:abhay_s_application1/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class FrameSevenScreen extends StatelessWidget {
  const FrameSevenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.h,
              vertical: 28.v,
            ),
            decoration: AppDecoration.fillWhiteA,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(
                  flex: 76,
                ),
                CustomElevatedButton(
                  text: "Login",
                ),
                SizedBox(height: 15.v),
                CustomOutlinedButton(
                  text: "Register",
                ),
                Spacer(
                  flex: 23,
                ),
                Text(
                  "Continue as a guest",
                  style: CustomTextStyles.titleSmallCyan400Bold.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
