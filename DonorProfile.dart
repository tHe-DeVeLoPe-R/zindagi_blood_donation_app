// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, non_constant_identifier_names, empty_constructor_bodies, must_be_immutable, prefer_final_fields, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zindagi/Home.dart';
import 'package:zindagi/Requests.dart';

class DonorProfile extends StatefulWidget {
  static String donor_email = '';
  DonorProfile(String email) {
    donor_email = email;
  }

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final updateEmail_uri = Uri.parse(
      'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/updateEmail');
  final updatePassword_uri = Uri.parse(
      'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/updatePassword');
  final updatePhone_uri = Uri.parse(
      'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/updatePhone');

  void updateEmail() async {
    Map<String, dynamic> updateEmail_body = {
      "email": DonorProfile.donor_email.toString(),
      "new_email": _emailController.text.toString()
    };

    final updateEmail_response =
        await http.post(updateEmail_uri, body: updateEmail_body);
    var snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          updateEmail_response.body,
          style: TextStyle(color: Colors.red),
        ));
    // Step 3
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updatePassword() async {
    Map<String, dynamic> updatePassword_body = {
      "email": DonorProfile.donor_email.toString(),
      "new_password": _passwordController.text.toString()
    };

    final updatePassword_response =
        await http.post(updatePassword_uri, body: updatePassword_body);
    var snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          updatePassword_response.body,
          style: TextStyle(color: Colors.red),
        ));
    // Step 3
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updatePhone() async {
    Map<String, dynamic> updatePhone_body = {
      "email": DonorProfile.donor_email.toString(),
      "phone": _phoneController.text.toString()
    };

    final updatePhone_response =
        await http.post(updatePhone_uri, body: updatePhone_body);
    var snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          updatePhone_response.body,
          style: TextStyle(color: Colors.red),
        ));
    // Step 3
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 36, 36),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'You are welcome as',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DonorProfile.donor_email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You are logged in as donor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Donor Activities",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.contact_mail,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Update phone number',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                child: Column(children: [
                                                  Form(
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              _phoneController,
                                                          decoration:
                                                              InputDecoration(
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          2.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            labelStyle:
                                                                TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      236,
                                                                      148,
                                                                      142),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                            labelText: 'Phone',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            updatePhone();
                                                          },
                                                          child: Text(
                                                            "Update",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.next_plan,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // --------------- card 2 -------------
                          SizedBox(
                            height: 50,
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'update user email',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            _emailController,
                                                        decoration:
                                                            InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 2.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          labelStyle: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    236,
                                                                    148,
                                                                    142),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          labelText: 'email',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          updateEmail();
                                                        },
                                                        child: Text(
                                                          "Update",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.next_plan,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ------------------- card 3 ------------
                          SizedBox(
                            height: 50,
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Logout your account',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.next_plan,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // --------------- card 4 -----------------
                          SizedBox(
                            height: 50,
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.request_page,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'View donation requests',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => Requests()),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.next_plan,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // -------------- card 5 ------
                          SizedBox(
                            height: 50,
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.password,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Change your passsword',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              child: Column(children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  controller:
                                                      _passwordController,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors.red,
                                                              width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 236, 148, 142),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    labelText: 'password',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    updatePassword();
                                                  },
                                                  child: Text(
                                                    "Update password",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ]),
                                            ));
                                          });
                                    },
                                    icon: Icon(
                                      Icons.next_plan,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // --------- cards ended  -----------
                          SizedBox(
                            height: 30,
                          ),
                          // back screen iconbutton
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => Home()),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
