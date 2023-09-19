// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zindagi/AddBanks.dart';
import 'package:zindagi/AdminHome.dart';
import 'package:zindagi/BloodBanks.dart';
import 'package:zindagi/CustomerSupport.dart';
import 'package:zindagi/DonorProfile.dart';
import 'package:zindagi/FindDonor.dart';
import 'package:zindagi/PostRequest.dart';
import 'package:zindagi/RegisterDonor.dart';
import 'package:zindagi/Requests.dart';

import 'Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //locking orientation to potrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'Home',
          routes: {
            'Home': (context) => Home(),
            'AdminHome': (context) => AdminHome(),
            'RegisterDonor': (context) => RegisterDonor(),
            'PostRequest': (context) => PostRequest(),
            'CustomerSupport': (context) => CustomerSupport(),
            'DonorProfile': (context) => DonorProfile(''),
            'BloodBanks': (context) => BloodBanks(),
            'FindDonor': (context) => FindDonor(),
            'Requests': (context) => Requests(),
            'AddBanks': (context) => AddBanks(),
          },
        ),
      ));
}
