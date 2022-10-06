import 'package:flutter/material.dart';

class detailSscreen extends StatefulWidget {
  const detailSscreen({Key? key}) : super(key: key);

  @override
  State<detailSscreen> createState() => _detailSscreenState();
}

class _detailSscreenState extends State<detailSscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.blueGrey),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Libreria free to play'),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
