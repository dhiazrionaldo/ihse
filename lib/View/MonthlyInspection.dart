import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ihse/Model/InspectionPart.dart';
import 'package:ihse/home_page.dart';

import '../shared/loading.dart';

class MonthlyInspection extends StatefulWidget {
  String tagNo;
  String inspectionType;
  int TotalScore;
  String Cookie;
  MonthlyInspection(
      this.tagNo, this.inspectionType, this.TotalScore, this.Cookie);

  @override
  State<MonthlyInspection> createState() =>
      _MonthlyInspectionState(tagNo, inspectionType, TotalScore, Cookie);
}

late Future<InspectionPartModel> _equipmentData;
bool loading = false;

class _MonthlyInspectionState extends State<MonthlyInspection> {
  String tagNo;
  String inspectionType;
  int TotalScore;
  String Cookie;
  late InspectionPartModel equipmentData;

  _MonthlyInspectionState(
      this.tagNo, this.inspectionType, this.TotalScore, this.Cookie);

  Future<InspectionPartModel> getPartInspection() async {
    Response response = await get(
      Uri.parse(
          'https://ihse.azurewebsites.net/api/FireEquipment/GetFireEquipmentParts/' +
              this.tagNo +
              '/' +
              this.inspectionType),
    );

    if (response.statusCode == 200) {
      equipmentData = InspectionPartModel.fromJson(jsonDecode(response.body));

      return equipmentData;
    } else {
      throw Exception('Failed to load data !');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _equipmentData = getPartInspection();
  }

  void setSaveInspection(equipment) async {
    setState(() {
      loading = true;
    });

    final inspectionData =
        equipmentData.mItem1!.inspectionParts = equipmentData.mItem2!;
    final result = jsonEncode(equipmentData.mItem1);

    try {
      Response response = await post(
        Uri.parse(
            'https://ihse.azurewebsites.net/api/FireEquipment/SaveInspectionParts/'),
        headers: {'Content-Type': 'application/json', 'Cookie': Cookie},
        body: result,
      );

      if (response.statusCode == 200) {
        AlertDialog alert = AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Success Submit Data',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 155, 42, 42),
              ),
            ),
          ),
          icon: Icon(
            Icons.verified,
            color: Colors.green,
            size: 60,
          ),
        );

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        ).then((val) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(Cookie),
            ),
          );
        });
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      throw Exception('Failed to save data !');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InspectionPartModel>(
        future: _equipmentData,
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
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      //Top Card
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ListTile(
                                                      title: Text(
                                                        'EQUIPMENT NAME',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        '${equipmentData.mItem1!.equipmentName.toString()}',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListTile(
                                                      title: Text(
                                                        'TAG NUMBER',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        '${equipmentData.mItem1!.tagNumber.toString()}',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      trailing: Image.asset(
                                                          'assets/images/I-HSE_144.png'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ListTile(
                                                      title: Text(
                                                        'INSPECTION TYPE',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        this
                                                            .inspectionType
                                                            .toString()
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListTile(
                                                      title: Text(
                                                        'READINESS STATUS',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      subtitle: Column(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          if (this.TotalScore >=
                                                              80)
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    33,
                                                                    186,
                                                                    69,
                                                                    1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'OK',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          else if (this
                                                                      .TotalScore >=
                                                                  60 &&
                                                              this.TotalScore <
                                                                  80)
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'WARNING',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          else if (this
                                                                  .TotalScore <
                                                              60)
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'BAD',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //bottom card from daily inspection
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
                                                  Icons
                                                      .local_fire_department_rounded,
                                                  size: 55,
                                                  color: Colors.red,
                                                ),
                                                title: Center(
                                                  child: Text(
                                                    '$tagNo Inspection Part Here',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                          child: FutureBuilder<
                                              InspectionPartModel>(
                                            future: _equipmentData,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.separated(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      child: Column(
                                                        children: <Widget>[
                                                          ListTile(
                                                            leading: const Icon(
                                                              Icons
                                                                  .adjust_rounded,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            title: TextButton(
                                                              onPressed: () {
                                                                showModalBottomSheet(
                                                                    shape:
                                                                        const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .vertical(
                                                                        top: Radius.circular(
                                                                            50),
                                                                      ),
                                                                    ),
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return SizedBox(
                                                                        height: MediaQuery.of(context)
                                                                            .size
                                                                            .shortestSide,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: <
                                                                              Widget>[
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Center(
                                                                              child: Container(
                                                                                width: 250,
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.blueGrey,
                                                                                  borderRadius: BorderRadius.circular(30),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(10),
                                                                              child: ListTile(
                                                                                title: Center(
                                                                                  child: Text(
                                                                                    '${equipmentData.mItem2![index].partName.toString()} Inspection Score',
                                                                                    style: GoogleFonts.roboto(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: 20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                trailing: const Icon(
                                                                                  Icons.local_fire_department_rounded,
                                                                                  size: 35,
                                                                                  color: Colors.red,
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
                                                                                  child: TextButton.icon(
                                                                                    onPressed: (() {
                                                                                      setState(() => equipmentData.mItem2![index].score = 100);

                                                                                      Navigator.pop(context);
                                                                                    }),
                                                                                    icon: const Icon(
                                                                                      Icons.circle,
                                                                                      size: 20,
                                                                                      color: Colors.green,
                                                                                    ),
                                                                                    label: Text(
                                                                                      'GOOD',
                                                                                      style: GoogleFonts.roboto(
                                                                                        fontWeight: FontWeight.w300,
                                                                                        fontSize: 20,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: TextButton.icon(
                                                                                    onPressed: (() {
                                                                                      setState(() => equipmentData.mItem2![index].score = 50);

                                                                                      Navigator.pop(context);
                                                                                    }),
                                                                                    icon: const Icon(
                                                                                      Icons.circle,
                                                                                      size: 20,
                                                                                      color: Colors.yellow,
                                                                                    ),
                                                                                    label: Text(
                                                                                      'WARNING',
                                                                                      style: GoogleFonts.roboto(
                                                                                        fontWeight: FontWeight.w300,
                                                                                        fontSize: 20,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: TextButton.icon(
                                                                                    onPressed: (() {
                                                                                      setState(() => equipmentData.mItem2![index].score = 0);
                                                                                      Navigator.pop(context);
                                                                                    }),
                                                                                    icon: const Icon(
                                                                                      Icons.circle,
                                                                                      size: 20,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                    label: Text(
                                                                                      'BAD',
                                                                                      style: GoogleFonts.roboto(
                                                                                        fontWeight: FontWeight.w300,
                                                                                        fontSize: 20,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    });
                                                              },
                                                              child: Text(
                                                                equipmentData
                                                                    .mItem2![
                                                                        index]
                                                                    .partName
                                                                    .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            trailing: SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: Column(
                                                                children: [
                                                                  if (equipmentData
                                                                          .mItem2![
                                                                              index]
                                                                          .score ==
                                                                      100)
                                                                    const Expanded(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .circle,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    )
                                                                  else if (equipmentData
                                                                          .mItem2![
                                                                              index]
                                                                          .score ==
                                                                      50)
                                                                    const Expanded(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .circle,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .yellow,
                                                                      ),
                                                                    )
                                                                  else if (equipmentData
                                                                          .mItem2![
                                                                              index]
                                                                          .score ==
                                                                      0)
                                                                    const Expanded(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .circle,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox(
                                                      height: 10,
                                                      width: 10,
                                                    );
                                                  },
                                                  itemCount: equipmentData
                                                      .mItem2!.length,
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              }
                                              return const CircularProgressIndicator();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                color: const Color.fromARGB(255, 93, 48, 228),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(
                                        Icons.save_rounded,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      title: TextButton(
                                        onPressed: () {
                                          setSaveInspection(equipmentData);
                                        },
                                        child: loading
                                            ? CircularProgressIndicator()
                                            : Text(
                                                'SUBMIT INSPECTION',
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
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
          } else if (snapshot.hasError) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                snapshot.error.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
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
        });
  }
}
