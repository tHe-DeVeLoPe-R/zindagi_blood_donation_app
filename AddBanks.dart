// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, prefer_final_fields, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddBanks extends StatefulWidget {
  const AddBanks({super.key});

  @override
  State<AddBanks> createState() => _AddBanksState();
}

class _AddBanksState extends State<AddBanks> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool showCircle = false;
  @override
  Widget build(BuildContext context) {
    final addBank_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/add-bank');

    void addBank() async {
      Map<String, dynamic> bank_body = {
        "name": _nameController.text.toString(),
        "city": _cityController.text.toString(),
        "distance_from_district": _distanceController.text.toString(),
        "contact": _phoneController.text.toString()
      };

      final addBank_response = await http.post(addBank_uri, body: bank_body);

      var snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          addBank_response.body,
          style: TextStyle(color: Colors.red),
        ),
      );
      // Step 3

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        showCircle = false;
      });
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
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
              height: 50,
            ),
            Text(
              "Add blood bank",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
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
                      labelText: 'Blood bank name',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 236, 148, 142),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      labelText: 'Blood bank city',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _distanceController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 236, 148, 142),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      labelText: 'Distance from district',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 236, 148, 142),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      labelText: 'contact',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Card(
                    elevation: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.11,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          if (_nameController.text.toString().isNotEmpty &&
                              _cityController.text.toString().isNotEmpty &&
                              _distanceController.text.toString().isNotEmpty) {
                            setState(() {
                              showCircle = true;
                            });

                            addBank();
                          } else {
                            //snack bar to show phone error
                            var snackBar = SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'All fields are required',
                                  style: TextStyle(color: Colors.red),
                                ));
                            // Step 3
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: showCircle
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Add blood bank",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
