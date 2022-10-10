import 'package:flutter/material.dart';

import 'homeScreen.dart';

class DetailSscreen extends StatefulWidget {
  final Todo todo;

  const DetailSscreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<DetailSscreen> createState() => _DetailSscreenState();
}

class _DetailSscreenState extends State<DetailSscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.blueGrey),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Libreria free to play'),
        ),
        body: Column(
          children: [Text(widget.todo.book)],
        ),
      ),
    );
  }
}
