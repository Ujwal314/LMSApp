import 'package:abhay_s_application1/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class EmpListPage extends StatefulWidget {
  const EmpListPage({Key? key}) : super(key: key);

  @override
  State<EmpListPage> createState() => _EmpListPageState();
}

class _EmpListPageState extends State<EmpListPage> {
  Future<List<Map<String, dynamic>>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  late Future<List<Map<String, dynamic>>> users;

  @override
  void initState() {
    super.initState();
    users = getUsers();
    print(users);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.registerScreen);
          },
          backgroundColor: const Color.fromARGB(255, 43, 43, 43),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
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
        child: SafeArea(
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
                                  child:Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                          Text(
                                            'Name: ${user['name']}',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0)),
                                          ),
                                        ],
                                      ),

                                      Text(
                                        'Sick Leaves: ${(user['sickleave'] != null)?user['sickleave']:"Not Available"}',
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      Text(
                                        'Casual Leaves: ${(user['casualleave'] != null)?user['casualleave']:"Not Available"}',
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                            color:
                                            Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      Text(
                                        'Paid Leaves:${(user['paidleave'] != null)?user['paidleave']:"Not Available"}',
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                            color:
                                            Color.fromARGB(255, 0, 0, 0)),
                                      ),

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
      ),
    );
  }
}
