import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas2/model/resep.dart';

class ResepApi{
  static Future<List<Resep>>getResep() async{
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',{
      "from": "0",
      "size": "50",
      "tags": "under_30_minutes"
    });

    final response = await http.get(uri,headers:{
      "X-RapidAPI-Host": "tasty.p.rapidapi.com",
      "X-RapidAPI-Key": "7f21121e03msh6194714619cb92ap19281djsn537373543f31",
      "useQueryString": "true"});

    Map data = jsonDecode(response.body);
    List _temp = [];

    for(var i in data['results']){
      _temp.add(i);
    }

    return Resep.resepFromSnapshot(_temp);
  }
}