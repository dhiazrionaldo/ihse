// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ihse/login_page.dart';
import 'shared/loading.dart';
import 'View/equipment.dart';
import 'View/TagNo.dart';

class HomePage extends StatefulWidget {
  String Cookie;
  HomePage(this.Cookie);

  @override
  State<HomePage> createState() => _HomePageState(Cookie);
}

class _HomePageState extends State<HomePage> {
  String Cookie;
  _HomePageState(this.Cookie);
  bool loading = false;
  int currentIndex = 2;

  void logout() async {
    loading = true;
    try {
      Response response = await post(
          Uri.parse('https://ihse.pertamina-pet.com/api/Account/Logout'),
          headers: {'Content-Type': 'application/json', 'Cookie': Cookie});
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Center(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Awesome Things Are  \nStill Under Development",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Awesome Things Are  \nStill Under Development",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Inspection(Cookie),
          ),
        ),
      ),
      Center(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Awesome Things Are  \nStill Under Development",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Log Out",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ];
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/images/ihse.png',
                fit: BoxFit.cover,
                height: 50,
                width: 250,
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: widgets[currentIndex],
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Icons.home_rounded, title: 'Home'),
                TabItem(icon: Icons.description_rounded, title: 'Report'),
                TabItem(
                    icon: Icons.qr_code_scanner_rounded, title: 'Inspection'),
                TabItem(icon: Icons.calendar_month_rounded, title: 'Schedule'),
                TabItem(icon: Icons.logout_outlined, title: 'Log Out'),
              ],
              initialActiveIndex: 2,
              onTap: (int i) {
                setState(() {
                  currentIndex = i;

                  if (currentIndex == 4) {
                    logout();
                  }
                });
              },
            ),
          );
  }
}
