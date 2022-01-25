import 'dart:convert';
import 'model_manager.dart';
import 'package:http/http.dart' as http;

class MatchService {
  String url = "https://stats.isporit.com/api/matches";
  Future<List<Manager>> getsMatch() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);

      return jsonList.map((match) => Manager.fromJson(match)).toList();
    }
    else {
      throw Exception("fail");
    }
  }

  Future<Manager> fetchMatch() async {
    final response = await http.get(
        Uri.parse(url + "/61106d75bbe96cc50a350746"));
    if (response.statusCode == 200) {
      return Manager.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("Fail to fetch data ");
    }
  }


}

