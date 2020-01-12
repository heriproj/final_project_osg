import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class DetailMeal extends StatefulWidget {
  final String id;
  DetailMeal(this.id);
  DetailMealState createState() => DetailMealState(id);
}

class DetailMealState extends State<DetailMeal> {
  ProgressDialog pr;
  final String idmeal;
  DetailMealState(this.idmeal);
  final String url = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=';
  List data;

  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(url + idmeal),
        headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['meals'];
    });
    return 'success!';
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    if (data == null) {
      return Scaffold(
        appBar: AppBar(
            title: Text(''),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Load Data......'),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
            title: Text(data[0]['strMeal']),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(height: 200.0),
                child: Image.network(
                  data[0]['strMealThumb'],
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Text(
                data[0]['strMeal'],
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              new Expanded(
                flex: 1,
                child: new SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
                  child: new Text(
                    data[0]['strInstructions'],
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
  }
}
