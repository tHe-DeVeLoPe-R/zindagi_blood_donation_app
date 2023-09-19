// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_local_variable, non_constant_identifier_names, prefer_const_declarations, unrelated_type_equality_checks, avoid_print, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zindagi/AdminHome.dart';
import 'package:zindagi/BloodBanks.dart';
import 'package:zindagi/CustomerSupport.dart';
import 'package:zindagi/DonorProfile.dart';
import 'package:zindagi/FindDonor.dart';
import 'package:zindagi/PostRequest.dart';
import 'package:zindagi/RegisterDonor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _donorUsernameController = TextEditingController();
  TextEditingController _donorPasswordController = TextEditingController();
  TextEditingController _donorUsernameController2 = TextEditingController();
  TextEditingController _donorPasswordController2 = TextEditingController();
  TextEditingController _adminUsernameController = TextEditingController();
  TextEditingController _adminPasswordController = TextEditingController();
  bool showCircle = false;

  bool loginSuccess = true;
  bool adminLoginSuccess = true;
  @override
  Widget build(BuildContext context) {
    final donor_login_uri = Uri.parse(
        "https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/login");
    Future<bool> getResponse() async {
      Map<String, dynamic> donor_login_request = {
        "email": _donorUsernameController.text.toString(),
        "password": _donorPasswordController.text.toString()
      };
      bool loginSuccess = true;
      final donor_login_response = await http.post(
        donor_login_uri,
        body: donor_login_request,
      );
      String response = donor_login_response.body;
      
      if (response.contains("logged in")) {
        setState(() {
          loginSuccess = true;
          showCircle = false;
        });
      } else {
        setState(() {
          loginSuccess = false;
          showCircle = false;
        });
      }
      return loginSuccess;
    }

    Future<bool> getResponse2() async {
      Map<String, dynamic> donor_login_request = {
        "email": _donorUsernameController2.text.toString(),
        "password": _donorPasswordController2.text.toString()
      };
      bool loginSuccess = true;
      final donor_login_response = await http.post(
        donor_login_uri,
        body: donor_login_request,
      );
      String response = donor_login_response.body;
      if (response.contains("logged in")) {
        setState(() {
          loginSuccess = true;
          showCircle = false;
        });
      } else {
        setState(() {
          loginSuccess = false;
          showCircle = false;
        });
      }
      return loginSuccess;
    }

    final admin_login_uri = Uri.parse(
        "https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/admin-login");
    Future<bool> adminLogin() async {
      Map<String, dynamic> admin_login_request = {
        "username": _adminUsernameController.text.toString(),
        "password": _adminPasswordController.text.toString()
      };
      bool adminloginSuccess = true;
      final admin_login_response = await http.post(
        admin_login_uri,
        body: admin_login_request,
      );
      String adminresponse = admin_login_response.body;
      print(adminresponse);
      if (adminresponse.contains("logged in")) {
        setState(() {
          adminLoginSuccess = true;
          showCircle = false;
        });
      } else {
        setState(() {
          adminLoginSuccess = false;
          showCircle = false;
        });
      }
      return adminLoginSuccess;
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 235, 235, 235),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07,
                top: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  content: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                margin: EdgeInsets.only(
                                  left: 0,
                                  top: 0,
                                ),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      Home()),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 23,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_moderator_outlined,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.4),
                                                                    spreadRadius:
                                                                        5,
                                                                    blurRadius:
                                                                        5,
                                                                    offset: Offset(
                                                                        3,
                                                                        3), // changes position of shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              // width: MediaQuery.of(context)
                                                              //         .size
                                                              //         .width *
                                                              //     1,
                                                              // height: MediaQuery.of(context)
                                                              //         .size
                                                              //         .height *
                                                              //     0.25,
                                                              child:
                                                                  Image.asset(
                                                                'assets/homeimage.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              "Admin Login",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Form(
                                                              child: Container(
                                                                // margin: EdgeInsets.only(
                                                                //   left: MediaQuery.of(context)
                                                                //           .size
                                                                //           .width *
                                                                //       0.1,
                                                                //   right:
                                                                //       MediaQuery.of(context)
                                                                //               .size
                                                                //               .width *
                                                                //           0.1,
                                                                // ),
                                                                child: Column(
                                                                  children: [
                                                                    TextField(
                                                                      controller:
                                                                          _adminUsernameController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.red,
                                                                              width: 2.0),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                        ),
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              236,
                                                                              148,
                                                                              142),
                                                                        ),
                                                                        labelText:
                                                                            'Enter your username',
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    TextField(
                                                                      controller:
                                                                          _adminPasswordController,
                                                                      obscureText:
                                                                          true,
                                                                      enableSuggestions:
                                                                          false,
                                                                      autocorrect:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.red,
                                                                              width: 2.0),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              236,
                                                                              148,
                                                                              142),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                        ),
                                                                        labelText:
                                                                            'Enter your password',
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          50,
                                                                    ),
                                                                    Card(
                                                                      elevation:
                                                                          10,
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.6,
                                                                        height: MediaQuery.of(context).size.width *
                                                                            0.11,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            if (_adminUsernameController.text.toString().isNotEmpty &&
                                                                                _adminPasswordController.text.toString().isNotEmpty) {
                                                                              setState(() {
                                                                                showCircle = true;
                                                                              });
                                                                              adminLoginSuccess = await adminLogin();
                                                                              print(adminLoginSuccess);
                                                                              if (adminLoginSuccess) {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: ((context) => AdminHome()),
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                var snackBar = SnackBar(
                                                                                    backgroundColor: Colors.white,
                                                                                    content: Text(
                                                                                      'login failed due to wrong creds',
                                                                                      style: TextStyle(color: Colors.red),
                                                                                    ));
                                                                                // Step 3

                                                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                              }
                                                                            } else {
                                                                              //snack bar to show empty fields error
                                                                              var snackBar = SnackBar(
                                                                                  backgroundColor: Colors.white,
                                                                                  content: Text(
                                                                                    'All fields are required',
                                                                                    style: TextStyle(color: Colors.red),
                                                                                  ));
                                                                              // Step 3

                                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                            }

                                                                            //make post call here
                                                                            // Navigator.push(
                                                                            //   context,
                                                                            //   MaterialPageRoute(
                                                                            //     builder: (context) =>
                                                                            //         DonorProfile(),
                                                                            //   ),
                                                                            // );
                                                                          },
                                                                          child: showCircle
                                                                              ? CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                )
                                                                              : Text(
                                                                                  "Login as Admin",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          Text(
                                                                        'Forgot password ?',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                13,
                                                                            decoration:
                                                                                TextDecoration.underline),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text(
                                            "Admin login",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.rate_review_outlined,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Rate application",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                            });
                      },
                    ),
                  ),
                  InkWell(
                    child: IconButton(
                      icon: Icon(
                        Icons.person_rounded,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              content: Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: Offset(3,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width *
                                        //     1,
                                        // height: MediaQuery.of(context)
                                        //         .size
                                        //         .height *
                                        //     0.25,
                                        child: Image.asset(
                                          'assets/homeimage.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Donor Login",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Form(
                                        child: Container(
                                          // margin: EdgeInsets.only(
                                          //   left: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.1,
                                          //   right:
                                          //       MediaQuery.of(context)
                                          //               .size
                                          //               .width *
                                          //           0.1,
                                          // ),
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller:
                                                    _donorUsernameController,
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
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 236, 148, 142),
                                                  ),
                                                  labelText:
                                                      'Enter your username',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              TextField(
                                                controller:
                                                    _donorPasswordController,
                                                obscureText: true,
                                                enableSuggestions: false,
                                                autocorrect: false,
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
                                                  labelText:
                                                      'Enter your password',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Card(
                                                elevation: 10,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.11,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      if (_donorUsernameController
                                                              .text
                                                              .toString()
                                                              .isNotEmpty &&
                                                          _donorUsernameController
                                                              .text
                                                              .toString()
                                                              .contains("@") &&
                                                          _donorUsernameController
                                                              .text
                                                              .toString()
                                                              .contains(
                                                                  ".com") &&
                                                          _donorPasswordController
                                                              .text
                                                              .toString()
                                                              .isNotEmpty) {
                                                        setState(() {
                                                          showCircle = true;
                                                        });
                                                      } else {
                                                        //snack bar to show empty fields error
                                                        var snackBar = SnackBar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: Text(
                                                              'All fields are required',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ));
                                                        // Step 3

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      }

                                                      loginSuccess =
                                                          await getResponse();

                                                      if (loginSuccess) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DonorProfile(_donorUsernameController.text.toString()),
                                                          ),
                                                        );
                                                      } else {
                                                        var snackBar = SnackBar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: Text(
                                                              'Login failed',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ));
                                                        // Step 3

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      }
                                                    },
                                                    child: showCircle
                                                        ? CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation(
                                                                    Colors
                                                                        .white),
                                                          )
                                                        : Text(
                                                            "Login as donor",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                'assets/homeimage.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Card(
              color: Color.fromARGB(255, 235, 235, 235),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 3,
                  bottom: 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
                child: Text(
                  'Join us and contribute to save lives !',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterDonor(),
                              ),
                            );
                          },
                          child: ImageIcon(
                            AssetImage(
                              'assets/bloodsample.png',
                            ),
                            color: Color.fromARGB(255, 207, 55, 44),
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Be a Donor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 118, 111),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => FindDonor()),
                              ),
                            );
                          },
                          child: ImageIcon(
                            AssetImage(
                              'assets/search.png',
                            ),
                            color: Color.fromARGB(255, 207, 55, 44),
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Find Donor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 118, 111),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostRequest(),
                              ),
                            );
                          },
                          child: ImageIcon(
                            AssetImage(
                              'assets/postrequest.png',
                            ),
                            color: Color.fromARGB(255, 207, 55, 44),
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Post Request',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 118, 111),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          onPressed: () {
                            // ------------ Generating login form in pop up --------------
                            showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  content: Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  spreadRadius: 5,
                                                  blurRadius: 5,
                                                  offset: Offset(3,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            // width: MediaQuery.of(context)
                                            //         .size
                                            //         .width *
                                            //     1,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.25,
                                            child: Image.asset(
                                              'assets/homeimage.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "Donor Login",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Form(
                                            child: Container(
                                              // margin: EdgeInsets.only(
                                              //   left: MediaQuery.of(context)
                                              //           .size
                                              //           .width *
                                              //       0.1,
                                              //   right:
                                              //       MediaQuery.of(context)
                                              //               .size
                                              //               .width *
                                              //           0.1,
                                              // ),
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    controller:
                                                        _donorUsernameController2,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      labelStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 236, 148, 142),
                                                      ),
                                                      labelText:
                                                          'Enter your username',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _donorPasswordController2,
                                                    obscureText: true,
                                                    enableSuggestions: false,
                                                    autocorrect: false,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      labelStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 236, 148, 142),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      labelText:
                                                          'Enter your password',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  ),
                                                  Card(
                                                    elevation: 10,
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.11,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                        onPressed: () async {
                                                          if (_donorUsernameController2
                                                                  .text
                                                                  .toString()
                                                                  .isNotEmpty &&
                                                              _donorUsernameController2
                                                                  .text
                                                                  .toString()
                                                                  .contains(
                                                                      "@") &&
                                                              _donorUsernameController2
                                                                  .text
                                                                  .toString()
                                                                  .contains(
                                                                      ".com") &&
                                                              _donorPasswordController2
                                                                  .text
                                                                  .toString()
                                                                  .isNotEmpty) {
                                                            setState(() {
                                                              showCircle = true;
                                                            });
                                                          } else {
                                                            //snack bar to show empty fields error
                                                            var snackBar =
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    content:
                                                                        Text(
                                                                      'All fields are required',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ));
                                                            // Step 3

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          }

                                                          loginSuccess =
                                                              await getResponse2();

                                                          if (loginSuccess) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DonorProfile(_donorUsernameController2.text.toString()),
                                                              ),
                                                            );
                                                          } else {
                                                            var snackBar =
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    content:
                                                                        Text(
                                                                      'Login failed',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ));
                                                            // Step 3

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          }
                                                        },
                                                        child: showCircle
                                                            ? CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation(
                                                                        Colors
                                                                            .white),
                                                              )
                                                            : Text(
                                                                "Login as donor",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Forgot password ?',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //),
                                );
                              }),
                            );
                          }, // ---------------------- pop up form generation end ---------------
                          child: ImageIcon(
                            AssetImage(
                              'assets/dashboard.png',
                            ),
                            color: Color.fromARGB(255, 207, 55, 44),
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Donor Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 118, 111),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BloodBanks(),
                              ),
                            );
                          },
                          child: ImageIcon(
                            AssetImage(
                              'assets/bbank.png',
                            ),
                            color: Color.fromARGB(255, 207, 55, 44),
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Blood Banks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 118, 111),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerSupport(),
                              ),
                            );
                          },
                          child: ImageIcon(
                            AssetImage(
                              'assets/support.png',
                            ),
                            color: Color.fromARGB(255, 207, 55, 44),
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Customer Care',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 118, 111),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
