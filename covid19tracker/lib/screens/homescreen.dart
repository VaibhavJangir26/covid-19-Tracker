import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:velocity_x/velocity_x.dart';

import '../model/world_states_model.dart';
import '../services/state_service.dart';
import '../widget/my_app_bar.dart';
import 'coutry_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  // make the object of api fetch method class
  StateService stateService=StateService();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return  Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MyAppBar(title: "DashBoard",),
          ),
        body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder<WorldStatesModel>(
                          future: stateService.worldStateFetchData(),
                          builder: (context,snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return SizedBox(
                                height: height*.4,
                                child:const Center(child: SpinKitWave(color: Colors.blue,),)
                              );
                            }
                            else if(snapshot.hasError){
                              return Center(child: "Unable to load data".text.make());
                            }
                            else if(snapshot.hasData){
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  SizedBox(
                                    width: width,
                                    height: height*.3,
                                    child: PieChart(
                                      dataMap: {
                                        "Recovered": snapshot.data!.recovered!.toDouble(), // this value is in %
                                        "Deaths": snapshot.data!.deaths!.toDouble(),
                                        "Total Cases": snapshot.data!.cases!.toDouble(),
                                      },
                                      animationDuration: const Duration(milliseconds: 320),
                                      chartRadius: width/2,
                                      chartType: ChartType.ring,

                                    )

                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      color: Colors.blue.shade100,
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            ReuseRow(title: "Updated", value: snapshot.data!.updated.toString(),),
                                            ReuseRow(title: "Active Patients", value: snapshot.data!.active.toString(),),
                                            ReuseRow(title: "Affect Countries", value: snapshot.data!.affectedCountries.toString(),),
                                            ReuseRow(title: "Tests", value: snapshot.data!.tests.toString(),),
                                            ReuseRow(title: "Critical Conditions", value: snapshot.data!.critical.toString(),),
                                            ReuseRow(title: "Cases per one million", value: snapshot.data!.casesPerOneMillion.toString(),),
                                            ReuseRow(title: "Deaths per one million", value: snapshot.data!.deathsPerOneMillion.toString(),),
                                            ReuseRow(title: "Recovered per one million", value: snapshot.data!.recoveredPerOneMillion.toString(),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height*0.02,),
                                  SizedBox(
                                    width: width,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade50,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                      onPressed:(){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const CountryStatus()));
                                      },
                                      child: "Track Countries".text.xl2.italic.blue400.make(),
                                    ),
                                  ),
                                ],
                              );

                            }
                            else{
                              return Center(child: "Error Occurred".text.make());
                            }
                          }
                      ),
                    ],
                  ),
                ),
              ),
            )
    );
  }
}

class ReuseRow extends StatelessWidget {
  const ReuseRow({super.key,required this.title,required this.value});
  final String title,value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            Text(value,style: GoogleFonts.poppins(fontSize: 12,color:Colors.deepPurple),)
          ],
        ),
        const Divider(),

      ],
    );
  }
}

