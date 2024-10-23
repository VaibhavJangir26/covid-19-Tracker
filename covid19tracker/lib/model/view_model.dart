
import 'package:covid19tracker/model/world_states_model.dart';
import '../services/state_service.dart';

class ViewModel{

  var repository=StateService();

  Future<WorldStatesModel> worldStateFetchData() async{
    var response= await repository.worldStateFetchData();
    return response;
  }


  Future<List<dynamic>> countryStatusListFetching() async{
    var response = await repository.countryStatusListFetching();
    return response;
  }

}