import 'package:flutter/material.dart';import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailMeal extends StatefulWidget {
  final String id;
  DetailMeal(this.id);
  DetailMealState createState() => DetailMealState(id);
}

class DetailMealState extends State<DetailMeal>{
  final String idmeal;
  DetailMealState(this.idmeal);
  final String url =
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=';
  List data;

  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url+idmeal), headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['meals'];
    });
    return 'success!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(idmeal),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          )
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(
              img,
              fit: BoxFit.cover,
            ),
            Padding( padding: EdgeInsets.only(bottom: 20),),
//            padding:EdgeInsets.all(2)
            Text(name,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ), ),
            Padding( padding: EdgeInsets.only(bottom: 20),),
//            padding:EdgeInsets.all(2)

            Padding( padding: EdgeInsets.only(bottom: 20),),
          ],
        ),
      ),
    );
  }
}