import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageOne(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageOne extends StatefulWidget {
  State<PageOne> createState() => _PageOne();
}

List<dynamic> converted = [];

class _PageOne extends State<PageOne> {
  @override
  void initState() {
    super.initState();
    getRequest();
  }

  getRequest() async {
    var api =
        Uri.parse('https://stranger-things-api.fly.dev/api/v1/characters');
    var jsonn = await http.get(api);

    setState(() {
      converted = json.decode(jsonn.body);
      converted
          .removeWhere((item) => item['_id'] == '5e77d8d2caf0952a9c8499de');
      converted
          .removeWhere((item) => item['_id'] == '5e77d8d2caf0952a9c8499eb');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "STRANGER THINGS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: converted.length,
        itemBuilder: (context, index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageTwo(pageTwoVar: index),
                  ),
                );
              },
              child: Center(
                child: Image.network(
                  converted[index]['photo'],
                  width: 400,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  int pageTwoVar;

  PageTwo({required this.pageTwoVar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(converted[pageTwoVar]['name'])),
      body: SizedBox(
        width: 600,
        height: 600,
        child: Image.network(
          converted[pageTwoVar]['photo'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
