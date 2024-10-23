

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../services/state_service.dart';
import 'detail_screen.dart';

class CountryStatus extends StatefulWidget {
  const CountryStatus({super.key});

  @override
  State<CountryStatus> createState() => _CountryStatusState();
}

class _CountryStatusState extends State<CountryStatus> {
  final StateService stateService = StateService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: "Country List".text.make(),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Search Country",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 1.2, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                SizedBox(
                  width: width,
                  height: height,
                  child: FutureBuilder<List<dynamic>>(
                    future: stateService.countryStatusListFetching(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          itemCount: 10, // Temporary count while waiting
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Vx.gray400,
                              highlightColor: Vx.gray100,
                              direction: ShimmerDirection.ltr,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Vx.gray400,
                                    ),
                                    title: Container(width: width, height: height * 0.02, color: Vx.gray400),
                                    subtitle: Container(width: width, height: height * 0.02, color: Vx.gray400),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: "Unable to load data".text.make());
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            final searchValue = data['country'] as String;

                            if (searchController.text.isEmpty ||
                                searchValue.toLowerCase().contains(searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            country: data["country"]?.toString() ?? '',
                                            cases: data["cases"]?? '',
                                            deaths: data["deaths"]?? '',
                                            tests: data["tests"]?.toString() ?? '',
                                            active: data["active"]?.toString() ?? '',
                                            flag: data["countryInfo"]["flag"]?.toString() ?? '',
                                            oneTestPerPeople: data["oneTestPerPeople"]?.toString() ?? '',
                                            population: data["population"]?? '',
                                            recovered: data["recovered"]?.toString() ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(data["countryInfo"]["flag"]?.toString() ?? ''),
                                    ),
                                    title: Text(
                                      data['country'] as String,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    subtitle: Text("Total Cases: ${data['cases']?.toString() ?? ''}"),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        return Center(child: "Error Occurred".text.make());
                      }
                    },
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
