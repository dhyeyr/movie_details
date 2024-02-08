// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsPage extends StatefulWidget {
  String? title;
  String? image;

  // String? rating;
  String? director;
  String? year;
  String? language;
  String? production;
  String? imdbvotes;

  DetailsPage({
    Key? key,
    required this.title,
    // required this.rating,
    required this.image,
    required this.director,
    required this.year,
    required this.language,
    required this.production,
    required this.imdbvotes,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Image.network(
              "${widget.image}",
              width: 307,
              height: 390,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.sizeOf(context).height * 0.37,
            width: MediaQuery.sizeOf(context).width * 0.95,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.title}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "${widget.production}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "${widget.director}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "Description:-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 7),
                Text(
                  widget.language ?? "",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.year ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
