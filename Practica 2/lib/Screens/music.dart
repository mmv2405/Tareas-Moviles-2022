import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

bool toggle = true;
bool cancel = false;

class Music extends StatefulWidget {
  // Music({this.dataMusic});
  //
  // dynamic dataMusic;

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  //
  //  //late String url;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Warriors'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
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
          Container(
              child: Image.network(
                  'https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e')),
          Container(
            child: Column(
              children: [
                Text(
                  'Warriors',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Warriors',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text('Imagine Dragons'),
                Text('2014-09-18'),
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
                          final Uri _url = Uri.parse(
                              'https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q');

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
                          final Uri _url = Uri.parse('https://lis.tn/Warriors');

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
                          final Uri _url = Uri.parse(
                              'https://music.apple.com/us/album/warriors/1440831203?i=1440831624');

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
