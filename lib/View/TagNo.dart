import 'dart:convert';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ihse/Model/TagNo.dart';
import 'package:ihse/View/TagNoDetail.dart';

class TagNoScreen extends StatefulWidget {
  String tagNo;
  TagNoScreen(this.tagNo);

  @override
  State<TagNoScreen> createState() => _TagNoScreenState(tagNo);
}

class _TagNoScreenState extends State<TagNoScreen> {
  String tagNo;
  _TagNoScreenState(this.tagNo);

  Future<List<TagNoModel>> getTagNo() async {
    Response response = await get(
      Uri.parse(
          'https://i-hse.azurewebsites.net/api/FireEquipment/GetEquipmentListByNameForDropdown/' +
              this.tagNo),
    );

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map((e) => TagNoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data !');
    }
  }

  void initState() {
    getTagNo();
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
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
                                  leading: Icon(
                                    Icons.local_fire_department_rounded,
                                    color: Colors.red,
                                    size: 55,
                                  ),
                                  title: Center(
                                    child: Text(
                                      this.tagNo,
                                      style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Score Guindance
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ExpansionTileCard(
                          borderRadius: BorderRadius.circular(15),
                          leading: Icon(
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
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.greenAccent[400],
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
                  ),
                ],
              ),
              //Tag No List
              Center(
                child: Wrap(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.style_rounded,
                                          color: Colors.grey,
                                          size: 55,
                                        ),
                                        title: Center(
                                          child: Text(
                                            '${this.tagNo} Tag Number List Here',
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FutureBuilder<List<TagNoModel>>(
                                    future: getTagNo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: Column(
                                                children: <Widget>[
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.adjust_rounded,
                                                      color: Colors.blue,
                                                    ),
                                                    title: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TagNoDetail(
                                                              snapshot
                                                                  .data![index]
                                                                  .Id
                                                                  .toString(),
                                                              snapshot
                                                                  .data![index]
                                                                  .EquipmentName
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .EquipmentName
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 10,
                                              width: 10,
                                            );
                                          },
                                          itemCount: snapshot.data!.length,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return CircularProgressIndicator();
                                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: snapshot.data!.length,
//                                       itemBuilder: (context, index) {
//                                         return Container(
//                                           color: Colors.white,
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0,
//                                               vertical: 8.0,
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.adjust,
//                                                   color: Colors.blueAccent,
//                                                   size: 40,
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 15),
//                                                   child: TextButton(
//                                                     onPressed: () {
//                                                       print('masok');
//                                                     },
//                                                     child: Text(
//                                                       snapshot.data![index]
//                                                           .EquipmentName
//                                                           .toString(),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     );