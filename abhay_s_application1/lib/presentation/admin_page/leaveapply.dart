import 'package:abhay_s_application1/core/app_export.dart';
import 'package:abhay_s_application1/widgets/custom_elevated_button.dart';
import 'package:abhay_s_application1/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({Key? key}) : super(key: key);

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  List<String> list = <String>['Sick Leave', 'Casual Leave', 'Paid Leave'];
  var dropdownval = 'Sick Leave';
  @override
  Widget build(BuildContext context) {
    getdropval(val) {
      switch(val){
        case 'Sick Leave': return 'sickleave';

        case 'Casual Leave': return 'casualleave';

        case 'Paid Leave': return 'paidleave';
      }
    }


    final String uid = ModalRoute.of(context)?.settings.arguments as String;
    TextEditingController title = TextEditingController();
    TextEditingController desc = TextEditingController();
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 12.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                "Leave Application",
                style: theme.textTheme.titleMedium!
                    .copyWith(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: title,
                hintText: "Title",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: desc,
                hintText: "Description",
                minLines: 5,
                maxLines: 6,
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: dropdownval,
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value, // Set a unique value for each DropdownMenuItem
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownval = value!;
                  });
                },
              ),
              CustomElevatedButton(
                onPressed: () async {
                  firestore.collection('leaverequest').add({
                    'uid': uid,
                    'title': title.text,
                    'description': desc.text,
                    'type':getdropval(dropdownval)
                  });
                  Navigator.pop(context);
                },
                text: "Submit Application",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
