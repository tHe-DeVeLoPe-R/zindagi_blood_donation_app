// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously, non_constant_identifier_names, unused_field, unused_local_variable, unused_import, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zindagi/AddBanks.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  TextEditingController _donorByIdController = TextEditingController();
  TextEditingController _profileIdController = TextEditingController();

  List donors = [];
  List complaints = [];
  List requests = [];
  @override
  Widget build(BuildContext context) {
    final donors_uri = Uri.parse(
        "https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/donors");

    void getDonors() async {
      final donors_response = await http.get(
        donors_uri,
      );

      donors = (json.decode(donors_response.body) as List);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    donors.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            );
          });
    }

    final complaints_uri = Uri.parse(
        "https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/complaints");
    void getComplaints() async {
      final complaint_response = await http.get(
        complaints_uri,
      );

      complaints = (json.decode(complaint_response.body) as List);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    complaints.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            );
          });
    }

    final donorById_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/donor-email');
    void getDonorByEmail() async {
      Map<String, dynamic> donorByEmail_body = {
        "email": _donorByIdController.text.toString()
      };
      final donorByEmail_response =
          await http.post(donorById_uri, body: donorByEmail_body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    donorByEmail_response.body,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            );
          });
    }

    final profileDecline_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/delete-profile');

    void declineProfile() async {
      Map<String, dynamic> profileDecline_body = {
        "id": _profileIdController.text.toString()
      };

      final profileDecline_response =
          await http.post(profileDecline_uri, body: profileDecline_body);
      var snackBar = SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            profileDecline_response.body,
            style: TextStyle(color: Colors.red),
          ));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final checkRequests_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/requests');
    void checkRequests() async {
      final requests_response = await http.get(
        checkRequests_uri,
      );

      requests = (json.decode(requests_response.body) as List);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    requests.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            );
          });
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
                  'You are logged in as Admin user',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Admin Pannel",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
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
                            var snackBar = SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  "Fetching donors",
                                  style: TextStyle(color: Colors.red),
                                ));
                            // Step 3
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            getDonors();
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
                        'Get Donors',
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
                                            "Donor By email",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
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
                                                      _donorByIdController,
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
                                                    labelText: 'Enter email',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
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
                                                      onPressed: () {
                                                        if (_donorByIdController
                                                            .text.isNotEmpty) {
                                                          var snackBar =
                                                              SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  content: Text(
                                                                    "Fetching this donor",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ));
                                                          // Step 3
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          getDonorByEmail();
                                                        }
                                                      },
                                                      child: Text(
                                                        "Donor By email",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  //),
                                );
                              }),
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
                        'Donor by id',
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
                            checkRequests();
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
                        'Check Requests',
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
                                            "Decline profile",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
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
                                                      _profileIdController,
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
                                                    labelText: 'Enter id',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
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
                                                      onPressed: () {
                                                        if (_profileIdController
                                                            .text.isNotEmpty) {
                                                          var snackBar =
                                                              SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  content: Text(
                                                                    "Declinning profile",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ));
                                                          // Step 3
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          declineProfile();
                                                        }
                                                      },
                                                      child: Text(
                                                        "Decline profile",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                        'Delete donor',
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
                                builder: (context) => AddBanks(),
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
                        'Add blood bank',
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
                            getComplaints();
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
                        'View complaints',
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
