import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/api_model.dart';


class ApiHelper {
  static ApiHelper obj = ApiHelper._();

  ApiHelper._();

  factory ApiHelper() {
    return obj;
  }

  Future<Movie?> getApiData() async {
    String baseUrl =
        "https://www.omdbapi.com/?i=tt3896198&apikey=3069b767";


    http.Response res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);
      var response = movieFromJson(res.body);

      return response;
    }
    return null;
  }
}



