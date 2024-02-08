import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:movie_details/controller/api_helper.dart';
import 'package:provider/provider.dart';

import '../controller/search_provider.dart';
import '../main.dart';
import '../model/api_model.dart';
import 'detail_page.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    ApiHelper().getApiData();
    // var gp = Provider.of<GeetaProvider>(context, listen: false);
    // gp.loadJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var gp = Provider.of<GeetaProvider>(context, listen: false);
    var sp = Provider.of<SearchProvider>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[400],
        appBar: AppBar(

          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Color(0xFFCCAB8C)
              : Color(0xFF946D4A),
          title: Text(
            "Movie",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,

        ),
        body: Column(
          children: [
            FutureBuilder(
              future: ApiHelper().getApiData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  Movie? data = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        margin:EdgeInsets.only(top: 95),
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: TextFormField(
                          onChanged: (value) async {
                            String baseUrl =
                                "https://api.weatherapi.com/v1/forecast.json?key=e09f03988e1048d2966132426232205&q=";
                            // String endUrl = "$value&aqi=no";
                            // String api = baseUrl + endUrl;
                            http.Response res = await http.get(Uri.parse(baseUrl));
                            if (res.statusCode == 200) {
                              sp.loc = value;
                              prefs.setString("City", value);
                            } else {
                              print("NO DATA FOUND");
                            }
                          },
                          onSaved: (value) async {},
                          decoration: InputDecoration(
                            labelText: 'Enter City',
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.location_city),
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Text("${data!.title}\n"),
                      Text("${data!.country}\n"),
                      Text("${data!.actors}\n"),
                      Text("${data!.awards}\n"),
                      Text("${data!. boxOffice}\n"),
                      Text("${data!.dvd}\n"),
                      Text("${data!.poster}\n"),
                      Text("${data!.ratings}\n"),
                      Text("${data!.website}\n"),
                      Text("${data!.year}\n"),
                      Text("${data!.writer}\n"),
                      Text("${data!.ratings![2].value}\n"),
                      Text("${data!.ratings![0].source}\n"),

                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ));
  }
}
