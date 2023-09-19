// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_local_variable, non_constant_identifier_names, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

List<String> genders = <String>["male", "female", "others"];

class RegisterDonor extends StatefulWidget {
  const RegisterDonor({super.key});

  @override
  State<RegisterDonor> createState() => _RegisterDonorState();
}

class _RegisterDonorState extends State<RegisterDonor> {
  String bloodgroupValue = bloodGroups.first;
  String genderValue = genders.first;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  bool showCircle = false;
  @override
  Widget build(BuildContext context) {
    final signup_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/signup');

    void signupDonor() async {
      Map<String, dynamic> signup_post_body = {
        "email": _usernameController.text.toString(),
        "password": _passwordController.text.toString(),
        "contact": _phoneController.text.toString(),
        "bloodgroup": bloodgroupValue.toString(),
        "gender": genderValue.toString(),
        "age": _ageController.text.toString(),
        "location": _locationController.text.toString().toLowerCase(),
        "balance": "0"
      };
      final signup_response =
          await http.post(signup_uri, body: signup_post_body);
      var snackBar = SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            signup_response.body,
            style: TextStyle(color: Colors.red),
          ));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        showCircle = false;
      });
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                height: 30,
              ),
              Text(
                "Register as a donor",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                child: Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
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
                          labelText: 'Enter your email',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _passwordController,
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
                          labelText: 'Enter your password',
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                          labelText: 'Enter your phone',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _ageController,
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
                          labelText: 'Enter your age',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _locationController,
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
                          labelText: 'city address',
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                        height: 15,
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
                          value: genderValue,

                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: SizedBox(),
                          onChanged: (newValue) {
                            // This is called when the user selects an item.
                            setState(() {
                              genderValue = newValue!;
                            });
                          },
                          items: genders.map((valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                      if (_usernameController.text.toString().isNotEmpty &&
                          _usernameController.text
                              .toString()
                              .contains('@gmail.com') &&
                          _passwordController.text.toString().isNotEmpty &&
                          _ageController.text.toString().isNotEmpty &&
                          _locationController.text.toString().isNotEmpty) {
                        if (_phoneController.text.toString().length == 11 &&
                            _phoneController.text.toString().contains("03")) {
                          setState(() {
                            showCircle = true;
                          });
                          signupDonor();

                          showCircle = false;
                        } else {
                          //snack bar to show phone error
                          var snackBar = SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                'Phone should start with 03 and it should be 11 digits',
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
                              'All fields are required and email should have correct format',
                              style: TextStyle(color: Colors.red),
                            ));
                        // Step 3
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: showCircle
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            "Register",
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
        ),
      ),
    );
  }
}
