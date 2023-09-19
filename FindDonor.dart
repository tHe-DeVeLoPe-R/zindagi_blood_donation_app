// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_final_fields, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:zindagi/Home.dart';

List<String> bloodGroups = <String>[
  "A+",
  "A-",
  "B+",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-"
];

class FindDonor extends StatefulWidget {
  const FindDonor({super.key});

  @override
  State<FindDonor> createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  TextEditingController _cityController = TextEditingController();
  String bloodgroupValue = bloodGroups.first;
  bool startSearch = false;
  bool showCircle = false;
  List donors = [];
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> donor_search_request = {
      "city": _cityController.text.toString().toLowerCase(),
      "bloodgroup": bloodgroupValue.toString()
    };
    final donor_search_uri = Uri.parse(
        "https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/search-donors");
    void getDonorsFromDatabase() async {
      final search_donor_response =
          await http.post(donor_search_uri, body: donor_search_request);
      setState(() {
        donors = (json.decode(search_donor_response.body) as List);
        showCircle = false;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                    icon: Icon(Icons.arrow_back),
                    color: Colors.red,
                    iconSize: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Text(
                    "Find Donors",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: 'Mono space'),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Required blood group"),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.bloodtype,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton(
                      //isExpanded: true,
                      value: bloodgroupValue,

                      elevation: 16,
                      style: const TextStyle(color: Colors.red),
                      underline: SizedBox(),
                      onChanged: (newValue) {
                        // This is called when the user selects an item.
                        setState(() {
                          bloodgroupValue = newValue!;
                          // matchedDonors.clear();
                          // for (int i = 0; i < donors.length; i++) {
                          //   if (donors[i]['bloodtype'] == newValue) {
                          //     matchedDonors.add(donors[i]);
                          //   }
                          // }

                          startSearch = false;
                        });
                      },
                      items: bloodGroups.map((valueItem) {
                        return DropdownMenuItem<String>(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 236, 148, 142),
                      ),
                      labelText: 'Enter your city',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_cityController.text.toString().isNotEmpty) {
                          startSearch = true;
                          showCircle = true;
                        } else {
                          var snackBar = SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                'All fields are required',
                                style: TextStyle(color: Colors.red),
                              ));
                          // Step 3

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                      getDonorsFromDatabase();
                    },
                    child: showCircle
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text("Search donors around me"),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              !startSearch
                  ? Text(
                      "Click search button to show donors around you",
                      style: TextStyle(
                        color: Color.fromARGB(255, 186, 185, 185),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            borderOnForeground: true,
                            elevation: 10,
                            shadowColor: Colors.grey,
                            color: const Color.fromARGB(255, 170, 54, 46),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_outlined,
                                    color: Colors.white,
                                    size: 23,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        donors[index]['email'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Age : \t" +
                                            donors[index]['age'].toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "City : \t" + donors[index]['location'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Gender : \t" + donors[index]['gender'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Blood Group : \t" +
                                            donors[index]['bloodgroup'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        onPressed: () async {
                                          final Uri url = Uri(
                                              scheme: 'tel',
                                              path: donors[index]['contact']);
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Make a call",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 185, 59, 50)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.call,
                                              color: const Color.fromARGB(
                                                  255, 185, 59, 50),
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: donors.length,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
