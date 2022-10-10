import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/detailsScreen.dart';

//Definir la clase para mandar los parametros
class Todo {
  final dynamic book;
  Todo(this.book);
}

//Recibir los datos del textfield
final myController = TextEditingController();

//url de para API
Future<Book> fetchApi(search) async {
  final url = "https://www.googleapis.com/books/v1/volumes?q=";
  final response = await http.get(Uri.parse(url + search));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Book.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Book {
  final int title;

  const Book({
    required this.title,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['userId'],
    );
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  dynamic book = "harry potter";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        focusColor: Colors.blueGrey,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Libreria free to play'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: myController,
                    decoration: InputDecoration(
                      labelText: 'Ingresar titulo',
                      focusColor: Colors.blueGrey,
                      //errorText: 'Error message',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          var apiFetch = fetchApi(myController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailSscreen(
                                    todo: Todo(apiFetch.toString()))),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text('ingresa palabra para buscar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
