import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.country,
    required this.flag,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.population,
    required this.tests,
    required this.oneTestPerPeople,
  });

  final String country;
  final String flag;
  final int cases;
  final int deaths;
  final String recovered;
  final String active;
  final int population;
  final String tests;
  final String oneTestPerPeople;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 2,right: 2),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xfffdcbf1),
                      Color(0xffe6dee9),
                    ]),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: widget.deaths.toDouble(),color: Colors.red,width: 15)],),
                        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: widget.cases.toDouble(),color: Colors.cyan)],),
                        BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: widget.population.toDouble(),color: Colors.teal)],),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*.003,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width*.3,
                      height: height*.04,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Text(widget.deaths.toString()),
                    ),
                    const Text("Deaths"),
                  ],
                ),
                SizedBox(height: height*.003,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width*.3,
                      height: height*.04,
                      alignment: Alignment.center,
                      color: Colors.cyan,
                      child: Text(widget.cases.toString()),
                    ),
                    const Text("Cases"),
                  ],
                ),
                SizedBox(height: height*.003,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: width*.3,
                      height: height*.04,
                      color: Colors.teal,
                      child: Text(widget.population.toString()),
                    ),
                    const Text("Population"),
                  ],
                ),
                SizedBox(height: height*.02,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width,
                    child: Card(
                      elevation: 8,
                      color: Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReuseRow(title: "Population", value: widget.population.toString().toString()),
                            ReuseRow(title: "Cases", value: widget.cases.toString()),
                            ReuseRow(title: "Active", value: widget.active.toString()),
                            ReuseRow(title: "Recovered", value: widget.recovered.toString()),
                            ReuseRow(title: "Deaths", value: widget.deaths.toString()),
                            ReuseRow(title: "Tests", value: widget.tests.toString()),
                            ReuseRow(title: "OneTestPerPerson", value: widget.oneTestPerPeople.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
