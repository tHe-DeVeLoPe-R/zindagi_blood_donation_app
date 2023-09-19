// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, prefer_final_fields, non_constant_identifier_names, unused_local_variable, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> bloodgroups = <String>[
  "A+",
  "A-",
  "B+",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-"
];

class PostRequest extends StatefulWidget {
  const PostRequest({super.key});

  @override
  State<PostRequest> createState() => _PostRequest();
}

class _PostRequest extends State<PostRequest> {
  String bloodgroupValue = bloodgroups.first;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  bool showCircle = false;

  @override
  Widget build(BuildContext context) {
    final post_request_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/post-request');

    void postRequest() async {
      Map<String, dynamic> post_request_body = {
        "name": _nameController.text.toString(),
        "adres": _addressController.text.toString(),
        "contact": _phoneController.text.toString(),
        "bloodgroup_required": bloodgroupValue.toString(),
        "amount": _quantityController.text.toString()
      };
      final post_request_response =
          await http.post(post_request_uri, body: post_request_body);
      var snackBar = SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            post_request_response.body,
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
                "Post a Request",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
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
                        labelText: 'Full Name',
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: _addressController,
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
                        labelText: 'Address',
                      ),
                    ),
                    SizedBox(
                      height: 25,
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
                        labelText: 'Contact number',
                      ),
                    ),
                    SizedBox(
                      height: 25,
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
                        items: bloodgroups.map((valueItem) {
                          return DropdownMenuItem<String>(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: _quantityController,
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
                        labelText: 'milli liters',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
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
                      if (_nameController.text.toString().isNotEmpty &&
                          _addressController.text.toString().isNotEmpty &&
                          _phoneController.text.toString().isNotEmpty &&
                          _quantityController.text.toString().isNotEmpty) {
                        if (_phoneController.text.toString().length == 11 &&
                            _phoneController.text.toString().contains("03")) {
                          setState(() {
                            showCircle = true;
                          });

                          postRequest();
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
                              'All fields are required',
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
                            "Post Request",
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
