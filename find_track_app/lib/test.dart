import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:find_track_app/homeScreen.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}


void getData()async{

  Response response = await get(Uri.parse("https://reqres.in/api/users?page=2"));

  print(response.body);
}