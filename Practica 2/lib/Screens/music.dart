import 'package:find_track_app/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

bool toggle = true;
bool cancel = false;

class Music extends StatefulWidget {
  final String imageUrl;

  final String title;
  final String album;
  final String artist;
  final String release_date;
  final String spotify;
  final String link;
  final String apple;

  Music(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.album,
      required this.artist,
      required this.release_date,
      required this.spotify,
      required this.link,
      required this.apple})
      : super(key: key);
  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homeScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
              icon: toggle ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
              onPressed: () {
                if (toggle == false) {
                  showAlertDialog(context);
                  if (cancel == true) {
                    setState(() {
                      toggle = !toggle;
                    });
                  }
                }
                setState(() {
                  toggle = !toggle;
                });
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(child: Image.network(widget.imageUrl)),
          Container(
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.album,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(widget.artist),
                Text(widget.release_date),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text('Abrir con:'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.spotify,
                          size: 40,
                        ),
                        onPressed: () async {
                          final Uri _url = Uri.parse(widget.spotify);

                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.podcast,
                          size: 40,
                        ),
                        onPressed: () async {
                          final Uri _url = Uri.parse(widget.link);

                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.apple,
                          size: 40,
                        ),
                        onPressed: () async {
                          final Uri _url = Uri.parse(widget.apple);

                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Eliminar"),
    onPressed: () {
      cancel = !cancel;
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eliminar de favoritos"),
    content:
        Text("El elemento sera eliminado de tus favoritos. Deseas continuar?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
