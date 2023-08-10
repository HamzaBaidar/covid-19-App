import 'dart:convert';

import 'package:covid/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import '../Model/World_States_Model.dart';

class StateServices{
  Future<WorldStatesModel> fetchWorldStatesRecords () async{
    var Response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data=jsonDecode(Response.body.toString());
    if(Response.statusCode==200){
      return  WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> CountriesListApi () async{
    var Response = await http.get(Uri.parse(AppUrl.countriesList));
    var data=jsonDecode(Response.body.toString());
    if(Response.statusCode==200){
      return  data;
    }
    else{
      throw Exception('Error');
    }
  }

}