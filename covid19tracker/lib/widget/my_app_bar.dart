import 'package:flutter/material.dart';
// import 'package:my_app/model/country_status_list_model.dart';
// import 'package:my_app/services/state_service.dart';
// import 'package:velocity_x/velocity_x.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {


  final String title;
  const MyAppBar({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Text(title),
      centerTitle: true,
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 10, bottom: 8),
      //     child: SizedBox(
      //       width: width / 1.65,
      //       height: height * 0.045,
      //       child: SearchBar(
      //         hintText: "Search Country",
      //         shape: WidgetStateProperty.all(
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //         ),
      //         leading: const Icon(Icons.search),
      //         elevation: WidgetStateProperty.all(5),
      //         shadowColor: WidgetStateProperty.all(Colors.blue),
      //         backgroundColor: WidgetStateProperty.all(Colors.blue.shade50),
      //         onTap: () {
      //           showSearch(context: context, delegate: ShowSearchBar());
      //         },
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}

// class ShowSearchBar extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           if (query.isEmpty) {
//             close(context, null);
//           } else {
//             query = "";
//           }
//         },
//         icon: const Icon(Icons.close),
//       ),
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back_ios),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(); // Design the search results page
//   }
//
//   List<String> countryListName = [
//     "India",
//     "USA",
//     "Japan",
//     "Russia",
//     "London",
//   ];
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     StateService stateService=StateService();
//
//     List<String> suggestion = countryListName.where((element) {
//       final result = element.toLowerCase();
//       final input = query.toLowerCase();
//       return result.contains(input);
//     }).toList();
//
//     return FutureBuilder<CountryStatusListModel>(
//       future: stateService.countryStatusListFetching(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const SizedBox(
//             height: 200,
//             child: Skeletonizer(
//               containersColor: Vx.gray400,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: CircleAvatar(),
//                     title: Text(""),
//                     subtitle: Text(""),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return const Center(
//             child: Text("Unable to load data.."),
//           );
//         } else if (snapshot.hasData) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: suggestion.length,
//                 itemBuilder: (context, index) {
//                   final suggestions = suggestion[index];
//                   return Column(
//                     children: [
//                       ListTile(
//                         onTap: () {
//                           query = suggestions;
//                           showResults(context);
//                         },
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             snapshot.data!.countryInfo!.flag![index].toString(),
//                           ),
//                         ),
//                         title: Text(snapshot.data!.country![index].toString()),
//                         subtitle: Text(snapshot.data!.cases!.toString()),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           );
//         } else {
//           return const Center(
//             child: Text("Error"),
//           );
//         }
//       },
//     );
//   }
// }
