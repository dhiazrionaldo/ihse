import 'dart:convert';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ihse/Model/TagNoDetail.dart';
import 'package:ihse/View/DailyInspection.dart';
import 'package:ihse/View/MonthlyInspection.dart';
import 'package:ihse/shared/loading.dart';

class TagNoDetail extends StatefulWidget {
  String tagNoId;
  String tagNumber;
  TagNoDetail(this.tagNoId, this.tagNumber);

  @override
  State<TagNoDetail> createState() => _TagNoDetailState(tagNoId, tagNumber);
}

class _TagNoDetailState extends State<TagNoDetail> {
  String tagNoId;
  String tagNumber;
  _TagNoDetailState(this.tagNoId, this.tagNumber);

  Future<List<TagNoDetailModel>> getEquipmentListById() async {
    Response response = await get(
      Uri.parse(
          'https://i-hse.azurewebsites.net/api/FireEquipment/GetFireEquipmentByEquipmentListId/' +
              this.tagNoId),
    );

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map((e) => TagNoDetailModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data !');
    }
  }

  @override
  void initState() {
    getEquipmentListById();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TagNoDetailModel>>(
      future: getEquipmentListById(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/images/ihse.png',
                fit: BoxFit.cover,
                height: 50,
                width: 250,
              ),
              automaticallyImplyLeading: true,
              centerTitle: true,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.red,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    //Top Card Equipment name and Tag Number
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.red,
                                        size: 55,
                                      ),
                                      title: Center(
                                        child: Text(
                                          snapshot.data![0].EquipmentName
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            snapshot.data![0].TagNumber
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.qr_code_scanner_rounded,
                                        size: 50,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Scan Button
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 93, 48, 228),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Center(
                                              child: Container(
                                                width: 250,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons
                                                      .local_fire_department_rounded,
                                                  color: Colors.red,
                                                  size: 50,
                                                ),
                                                title: Center(
                                                  child: Text(
                                                    'Choose Inspection Type',
                                                    style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 27,
                                                    ),
                                                  ),
                                                ),
                                                trailing: const Icon(
                                                  Icons.qr_code_scanner_rounded,
                                                  color: Colors.blue,
                                                  size: 50,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: Colors.grey[400],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    leading: const Icon(
                                                      Icons.adjust,
                                                      size: 36,
                                                      color: Colors.deepPurple,
                                                    ),
                                                    title: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         MonthlyInspection(
                                                        //       snapshot.data![0]
                                                        //           .TagNumber
                                                        //           .toString(),
                                                        //       'Daily',
                                                        //       snapshot.data![0]
                                                        //           .TotalScore!,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DailyInspection(
                                                              'Daily',
                                                              snapshot.data![0]
                                                                  .TotalScore!,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Daily Inspection',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 0,
                                              ),
                                              child: Divider(),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    leading: const Icon(
                                                      Icons.adjust,
                                                      size: 36,
                                                      color: Colors.deepPurple,
                                                    ),
                                                    title: TextButton(
                                                      onPressed: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         MonthlyInspection(
                                                        //       snapshot.data![0]
                                                        //           .TagNumber
                                                        //           .toString(),
                                                        //       'Weekly',
                                                        //       snapshot.data![0]
                                                        //           .TotalScore!,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DailyInspection(
                                                              'Weekly',
                                                              snapshot.data![0]
                                                                  .TotalScore!,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Weekly Inspection',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 0,
                                              ),
                                              child: Divider(),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    leading: const Icon(
                                                      Icons.adjust,
                                                      size: 36,
                                                      color: Colors.deepPurple,
                                                    ),
                                                    title: TextButton(
                                                      onPressed: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         MonthlyInspection(
                                                        //       snapshot.data![0]
                                                        //           .TagNumber
                                                        //           .toString(),
                                                        //       'Monthly',
                                                        //       snapshot.data![0]
                                                        //           .TotalScore!,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DailyInspection(
                                                              'Monthly',
                                                              snapshot.data![0]
                                                                  .TotalScore!,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Monthly Inspection',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 0,
                                              ),
                                              child: Divider(),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    leading: const Icon(
                                                      Icons.adjust,
                                                      size: 36,
                                                      color: Colors.deepPurple,
                                                    ),
                                                    title: TextButton(
                                                      onPressed: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         MonthlyInspection(
                                                        //       snapshot.data![0]
                                                        //           .TagNumber
                                                        //           .toString(),
                                                        //       'Yearly',
                                                        //       snapshot.data![0]
                                                        //           .TotalScore!,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DailyInspection(
                                                              'Yearly',
                                                              snapshot.data![0]
                                                                  .TotalScore!,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Yearly Inspection',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: Colors.grey[400],
                                            ),
                                          ],
                                        ),
                                      );
                                      // return
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'SCAN QR CODE HERE',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Score Guidance
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ExpansionTileCard(
                              borderRadius: BorderRadius.circular(15),
                              leading: const Icon(
                                Icons.menu_book_rounded,
                                color: Colors.blueAccent,
                                size: 55,
                              ),
                              title: Text(
                                'Score Guidance',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              children: <Widget>[
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'N/A',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey.shade300,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'N/A',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey.shade300,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color:
                                                      Colors.greenAccent[400],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'N/A',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Tag Number Detail Information
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        'PLANT',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'TERMINAL TANJUNG SEKONG',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailing: Image.asset(
                                        'assets/images/I-HSE_144.png',
                                      ),
                                      // trailing: const Icon(
                                      //   Icons.adjust_rounded,
                                      //   size: 30,
                                      //   color: Colors.black,
                                      // ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListTile(
                                      title: Text(
                                        'LOCATION',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![0].LocationName
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListTile(
                                      title: Text(
                                        'TAG NUMBER',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![0].TagNumber.toString(),
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListTile(
                                      title: Text(
                                        'FIRE EQUIPMENT READINESS STATUS',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    if (snapshot.data![0].TotalScore! >= 80)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 0,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                33, 186, 69, 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (snapshot.data![0].TotalScore! >=
                                            60 &&
                                        snapshot.data![0].TotalScore! < 80)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 0,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'WARNING',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (snapshot.data![0].TotalScore! < 60)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 0,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'BAD',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
          child: const Loading(),
        );
      },
    );
  }
}
