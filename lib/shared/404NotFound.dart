// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ihse/home_page.dart';
import 'package:ihse/login_page.dart';

import 'loading.dart';

class Error extends StatefulWidget {
  String Cookies;
  Error(this.Cookies);

  @override
  State<Error> createState() => _ErrorState(Cookies);
}

class _ErrorState extends State<Error> {
  String Cookies;
  _ErrorState(this.Cookies);
  int _selectedNavbar = 0;
  bool loading = false;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;

      if (_selectedNavbar == 4) {
        logout();
      }
      if (_selectedNavbar == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(Cookies),
          ),
        );
      }
    });
  }

  void logout() async {
    loading = true;
    try {
      Response response = await post(
          Uri.parse('https://ihse.azurewebsites.net/api/Account/Logout'),
          headers: {'Content-Type': 'application/json', 'Cookie': Cookies});
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/images/Logo-Peteka-Karya-Tirta.png',
                fit: BoxFit.cover,
                height: 50,
                width: 200,
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 21, 20, 20),
            ),
            body: Center(
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
                    "Awesome Things Are \n Under Development",
                    style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 40,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.assignment,
                    size: 40,
                  ),
                  label: 'Report',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.qr_code_2_rounded,
                    size: 40,
                  ),
                  label: 'Inspection',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    size: 40,
                  ),
                  label: 'Inspection',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 40,
                  ),
                  label: 'Log Out',
                ),
              ],
              currentIndex: _selectedNavbar,
              selectedItemColor: Colors.lightBlueAccent.shade700,
              unselectedItemColor: Colors.black54,
              showUnselectedLabels: true,
              onTap: _changeSelectedNavBar,
            ),
          );
  }
}
