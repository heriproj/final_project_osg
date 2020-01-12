import 'package:final_project_osg/ListMeals.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//void main() {
//  runApp(MainMenu());
//}

class MainMenu extends StatefulWidget {
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  final String url = 'https://www.themealdb.com/api/json/v1/1/categories.php';
  List data;
  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['categories'];
    });
    return 'success!';
  }

  Widget build(context) {
    return MaterialApp(
        title: 'Cafe OSG 8',
        home:Scaffold(
          appBar: AppBar(
            title: Text("Category Menu Recipes OSG 8"),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    print(data[index]['strCategory']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListMeals( data[index]['strCategory']),
                      ),
                    );
                  },
                  child: Card(
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        data[index]['strCategoryThumb'],
                        fit: BoxFit.cover,
                      ),
                      Text(
                        data[index]['strCategory'],
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ]
                  )
                  )
              );
            },
          ),
        )
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }
}
