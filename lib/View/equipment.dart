import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ihse/Model/equipmentChart.dart';
import 'package:ihse/View/TagNo.dart';
import 'package:ihse/shared/loading.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Inspection extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  Future<List<equipmentChartModel>> getChart() async {
    Response response = await get(
      Uri.parse(
          'https://i-hse.azurewebsites.net/api/FireEquipment/GetFireEquipmentChart'),
    );

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map((e) => equipmentChartModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data !');
    }
  }

  void initState() {
    getChart();
  }

  @override
  dispose() {
    cardA;
    getChart();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<equipmentChartModel>>(
      future: getChart(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final total = snapshot.data![index].TotalPart! /
                  snapshot.data![index].TotalEquipment!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ExpansionTileCard(
                  baseColor: Colors.white,
                  expandedColor: Colors.white,
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.red,
                      size: 40,
                    ),
                    backgroundColor: Colors.white10.withOpacity(0),
                  ),
                  title: Center(
                    child: Text(
                      snapshot.data![index].EquipmentName.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                snapshot.data![index].TotalPart.toString() +
                                    "%",
                                style: GoogleFonts.roboto(
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: LinearPercentIndicator(
                                  // width: MediaQuery.of(context).size.width - 50,
                                  animation: true,
                                  lineHeight: 20.0,
                                  animationDuration: 2000,
                                  percent: total,
                                  barRadius: Radius.circular(16),
                                  progressColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Unable to use the equipment",
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TagNoScreen(snapshot
                                    .data![index].EquipmentName
                                    .toString()),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.search,
                            size: 34.0,
                            color: Colors.black,
                          ),
                          label: Text(
                            'More Detail',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
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