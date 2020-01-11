import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_project_osg/DetailMeal.dart';


class ListMeals extends StatefulWidget {
  final String cat;
  ListMeals(this.cat);
  ListMealsState createState() => ListMealsState(cat);
}

class ListMealsState extends State<ListMeals> {
  final String category;
  ListMealsState(this.category);

  final String url =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=';
  List data;

  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url+category), headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['meals'];
    });
    return 'success!';
  }

  Widget build(context) {
    return MaterialApp(
//      title: 'Cafe OSG 8',
      home: Scaffold(
          appBar: AppBar(
              title: Text('List Meal '+category+' Cafe OSG 8'),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => Navigator.pop(context, false),
              )
          ),
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              child: Image.network(
                                    data[index]['strMealThumb'],
                                    )
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
//                              print('cow');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailMeal( data[index]['idMeal']),
                                ),
                              );
                            },
                            title: Text(
                                    data[index]['strMeal'],
                                    style: TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.bold),
                                    ),
                          ),
                        ],
                      ),
                ));
              },
            ),
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }
}
