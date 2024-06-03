import 'package:abhay_s_application1/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class LeaveRequestsPage extends StatefulWidget {
  const LeaveRequestsPage({Key? key}) : super(key: key);

  @override
  State<LeaveRequestsPage> createState() => _LeaveRequestsPageState();
}

class _LeaveRequestsPageState extends State<LeaveRequestsPage> {
  Future<List<Map<String, dynamic>>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('leaverequest').get();

    List<Map<String, dynamic>> userList = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      // Get the data from the leaverequest document
      Map<String, dynamic> userData = doc.data();

      // Get the UID from the leaverequest document
      String uid = userData['uid'];

      // Fetch additional data from the "users" collection
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Check if the user exists in the "users" collection
      if (userSnapshot.exists) {
        // Get the user data from the "users" collection
        Map<String, dynamic> userDataFromUsers = userSnapshot.data() ?? {};

        // Add the user data from "users" to the userData
        userData['userName'] = userDataFromUsers['name'];
      }

      // Add the document name to the userData
      userData['documentName'] = doc.id;

      // Add the updated userData to the userList
      userList.add(userData);
    }

    return userList;
  }

  late Future<List<Map<String, dynamic>>> users;

  @override
  void initState() {
    super.initState();
    users = getUsers();
  }

  response(int val, String lid, String uid, String type) async {
    if (val == 1) {
      DocumentSnapshot<Map<String, dynamic>> user =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      print("${type}: ${user[type]}");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({type: user[type] - 1});
    }
    await FirebaseFirestore.instance
        .collection('leaverequest')
        .doc(lid)
        .delete();
    setState(() {
      users = getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                height: 10.v,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> userList = snapshot.data ?? [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: userList.map((user) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.white,
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 25,
                                    offset: Offset(0, 4),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ${user['userName']}',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      'Title: ${user['title']}',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      'Type: ${user['type']}',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                          color:
                                          Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      'Description: ${user['description']}',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    SizedBox(
                                      height: 10.v,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(
                                            color: Color.fromARGB(
                                                255, 28, 128, 81),
                                            onPressed: () {
                                              response(1, user['documentName'],
                                                  user['uid'], user['type']);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35.0,
                                                      vertical: 10),
                                              child: Text(
                                                "Accept",
                                                style: theme
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                              ),
                                            )),
                                        MaterialButton(
                                            color: Color.fromARGB(
                                                255, 179, 61, 61),
                                            onPressed: () {
                                              response(0, user['documentName'],
                                                  user['uid'], user['type']);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35.0,
                                                      vertical: 10),
                                              child: Text(
                                                "Reject",
                                                style: theme
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                              ),
                                            ))
                                      ],
                                    )
                                    // Add a divider between users
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.v,
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
