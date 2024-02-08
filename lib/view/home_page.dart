import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        appBar: AppBar(
          backgroundColor: Colors.pink[100],
          title: Text(
            "Movie",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: ApiHelper().getApiData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                Movie? data = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 9),
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: TextFormField(
                        onChanged: (value) async {
                          String baseUrl =
                              "https://www.omdbapi.com/?t={$value}apikey={3069b767}";
                          http.Response res =
                              await http.get(Uri.parse(baseUrl));
                          if (res.statusCode == 200) {
                            sp.mov = value;
                            prefs.setString("movie", value);
                          } else {
                            print("NO DATA FOUND");
                          }
                        },
                        onSaved: (value) async {},
                        decoration: InputDecoration(
                          labelText: 'Enter Movie Name',
                          border: OutlineInputBorder(),
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailsPage(
                              title: data!.title,
                              director: "${data.director}",
                              year: data.year,
                              image:data.poster,
                              language: data.language,
                              production: data.production,
                              imdbvotes: data.imdbVotes,

                              // rating: double.parse("${data.ratings![1].source}"),
                            );
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        clipBehavior: Clip.antiAlias,
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.network(
                          "${data?.poster}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        "${data!.title}\n",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
