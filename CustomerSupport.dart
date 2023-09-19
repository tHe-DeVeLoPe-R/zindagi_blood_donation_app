// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, unnecessary_new, prefer_final_fields, unused_local_variable, non_constant_identifier_names, unused_element, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupport();
}

class _CustomerSupport extends State<CustomerSupport> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  bool showCircle = false;
  @override
  Widget build(BuildContext context) {
    final post_complaint_uri = Uri.parse(
        'https://us-central1-zindagi-4e87d.cloudfunctions.net/zindagi/add-complaint');

    void postComplaint() async {
      Map<String, dynamic> post_complaint_body = {
        "email": _emailController.text.toString(),
        "complaint": _messageController.text.toString(),
      };
      
      final post_complaint_response =
          await http.post(post_complaint_uri, body: post_complaint_body);
      
      setState(() {
        showCircle = false;
      });
      var snackBar = SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            post_complaint_response.body,
            style: TextStyle(color: Colors.red),
          ));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/customercare.png'),
                ],
              ),
              Text(
                "Contact us!",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 60,
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
                        controller: _emailController,
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
                          labelText: 'Email id',
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 500,
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
                          labelText: 'Message',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
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
                      if (_emailController.text.toString().isNotEmpty &&
                          _emailController.text.toString().contains("@") &&
                          _emailController.text.toString().contains(".com") &&
                          _messageController.text.toString().isNotEmpty) {
                        setState(() {
                          showCircle = true;
                        });
                        postComplaint();
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
                            "Send to customer care",
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
