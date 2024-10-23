import 'dart:convert';
import 'package:covid19tracker/services/utilites/api_url.dart';
import 'package:http/http.dart' as http;

import '../model/world_states_model.dart';



class StateService{
  // methods to fetch the api



  Future<WorldStatesModel> worldStateFetchData() async{
    // here we import the api from api_url class
      var response =await http.get(Uri.parse(ApiUrl.baseUrl));
      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      }
      throw Exception();
  }



  Future<List<dynamic>> countryStatusListFetching() async{
      dynamic data;
      var response= await http.get(Uri.parse(ApiUrl.countryStatusListUrl));
      if(response.statusCode==200){
        data=jsonDecode(response.body);
        return data;
      }
      throw Exception();
  }


}