import 'package:abhay_s_application1/presentation/admin_page/admin_page.dart';
import 'package:abhay_s_application1/presentation/admin_page/staff_page.dart';
import 'package:abhay_s_application1/presentation/login_screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EntryCheck extends StatelessWidget {
  const EntryCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Map<String, dynamic>>> getUserType() async {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      return FirebaseFirestore.instance.collection('users').doc(uid).get();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserType(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator if the document is still being fetched
                  return CircularProgressIndicator();
                } else if (userSnapshot.hasError) {
                  // Handle any errors that might occur during document retrieval
                  return Text('Error: ${userSnapshot.error}');
                } else {
                  // Get the user type from the document data
                  int userType = userSnapshot.data?.data()?['type'] ?? 0;

                  // Determine which screen to show based on the user type
                  if (userType == 1) {
                    return StaffDashboardScreen(
                      uid: FirebaseAuth.instance.currentUser?.uid,
                    );
                  } else {
                    return AdminDashboardScreen();
                  }
                }
              },
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
