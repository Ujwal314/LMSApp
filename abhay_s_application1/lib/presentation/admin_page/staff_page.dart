import 'package:abhay_s_application1/core/app_export.dart';
import 'package:abhay_s_application1/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StaffDashboardScreen extends StatelessWidget {
  final String? uid;

  const StaffDashboardScreen({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String uid = ModalRoute.of(context)?.settings.arguments as String;
    print(uid);
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 12.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon(Icons.shield),
                  // SizedBox(
                  //   width: 6.h,
                  // ),
                  Text(
                    "LMS Staff Module",
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome Staff,",
                style: theme.textTheme.titleMedium!.copyWith(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 20.fSize),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Your Dashboard:",
                style: theme.textTheme.titleMedium!
                    .copyWith(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(
                height: 15.v,
              ),
              CustomElevatedButton(
                space: true,
                text: "Dashboard",
                leftIcon: Icon(Icons.auto_awesome_mosaic),
                rightIcon: Icon(Icons.arrow_forward_ios),
              ),
              SizedBox(
                height: 15.v,
              ),
              CustomElevatedButton(
                space: true,
                text: "Employees",
                leftIcon: Icon(Icons.people),
                rightIcon: Icon(Icons.arrow_forward_ios),
              ),
              SizedBox(
                height: 15.v,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.leaveApply,
                      arguments: uid);
                },
                space: true,
                text: "Apply for Leave",
                leftIcon: Icon(Icons.event_note),
                rightIcon: Icon(Icons.arrow_forward_ios),
              ),
              SizedBox(
                height: 15.v,
              ),
              CustomElevatedButton(
                space: true,
                text: "Holidays",
                leftIcon: Icon(Icons.calendar_month),
                rightIcon: Icon(Icons.arrow_forward_ios),
              ),
              SizedBox(
                height: 15.v,
              ),
              CustomElevatedButton(
                text: "LOGOUT",
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.entryCheck);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
