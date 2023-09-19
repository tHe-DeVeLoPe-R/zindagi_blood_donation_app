// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zindagi/Home.dart';
import 'package:http/http.dart' as http;

class BloodBanks extends StatefulWidget {
  const BloodBanks({super.key});

  @override
  State<BloodBanks> createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
  List bloodbanks = [];

  final get_banks_uri = Uri.parse(
      'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/blood-banks');
  @override
  Widget build(BuildContext context) {
    void fetchBloodBanks() async {
      var snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "We are fetching blood banks please wait ... ",
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      final fetch_banks_response = await http.get(get_banks_uri);
      setState(() {
        bloodbanks = (json.decode(fetch_banks_response.body) as List);
      });
    }

    fetchBloodBanks();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Text(
                  "Blood banks",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Mono space',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Card(
                  borderOnForeground: true,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color.fromARGB(255, 177, 58, 49),
                  shadowColor: Colors.grey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/bbank.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            bloodbanks[index]['name'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Distance from city: " +
                                bloodbanks[index]['distance'].toString() +
                                "km",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            bloodbanks[index]['city'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () async {
                              final Uri url = Uri(
                                  scheme: 'tel',
                                  path: bloodbanks[index]['contact']);
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
                                  color: const Color.fromARGB(255, 185, 59, 50),
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: bloodbanks.length,
          )
        ]),
      ),
    );
  }
}
