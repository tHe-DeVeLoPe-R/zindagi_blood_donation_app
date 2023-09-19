// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_local_variable, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  List requests = [];

  final get_requests_uri = Uri.parse(
      'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/requests');

  @override
  Widget build(BuildContext context) {
    void fetchRequests() async {
      final fetch_requests_response = await http.get(get_requests_uri);
      setState(() {
        requests = (json.decode(fetch_requests_response.body) as List);
      });
    }

    var snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        "We are fetching requests please wait ... ",
        style: TextStyle(color: Colors.red),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    fetchRequests();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              // left: MediaQuery.of(context).size.width * 0.05,
              //right: MediaQuery.of(context).size.width * 0.05,
              ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                    //left: 10,
                    //right: 10,
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
                      left: 20,
                      right: 80,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outlined,
                          color: Colors.white,
                          size: 23,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              requests[index]['name'].toString(),
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
                              "City: " + requests[index]['adres'].toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Amount required : \t" +
                                  requests[index]['amount'],
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
                                  requests[index]['bloodgroup'].toString(),
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
                                    path: requests[index]['contact']);
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
                                    color:
                                        const Color.fromARGB(255, 185, 59, 50),
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
            itemCount: requests.length,
          ),
        ),
      ),
    );
  }
}
