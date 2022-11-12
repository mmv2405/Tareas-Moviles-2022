import 'dart:convert';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:find_track_app/Screens/favorites.dart';
import 'package:find_track_app/Screens/login_screen.dart';
import 'package:find_track_app/Screens/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../logic/firestore_logic.dart';
import '../utils/secrets.dart';

bool _cancel = false;
bool pressGeoON = false;
bool cmbscritta = false;
bool hear = false;
final recorder = FlutterSoundRecorder();

var mainDataMusic;
String imageUrl = '';
String titleNew = '';
String albumNew = '';
String artistNew = '';
String release_dateNew = '';
String spotifyNew = '';
String linkNew = '';
String appleNew = '';

Future record() async {
  await recorder.startRecorder(toFile: 'audio');
}

Future stop() async {}

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Please grant permision for microphone';
    }

    await recorder.openRecorder();
    recorder.setSubscriptionDuration(
      Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                var duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                if (duration.inSeconds == 4) {
                  getData();
                  recorder.isRecording ? Avatar() : Avatar2();

                  cmbscritta = !cmbscritta;
                }
                return Text('${duration.inSeconds} s');
              },
            ),
            MiddleCircle(),
            SizedBox(height: 60.0),
            FavoriteIcons(),
            VerFavorito(),
          ],
        ),
      ),
    );
  }
}

class VerFavorito extends StatelessWidget {
  const VerFavorito({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        getDataFirestore();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const favorites()),
        );
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Text('Ver Favoritos'),
    );
  }
}

class FavoriteIcons extends StatefulWidget {
  const FavoriteIcons({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteIcons> createState() => _FavoriteIconsState();
}

class _FavoriteIconsState extends State<FavoriteIcons> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        showAlertDialog(context);
      },
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        color: Colors.black,
        Icons.favorite,
        size: 20.0,
      ),
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
    );
  }
}

class MiddleCircle extends StatefulWidget {
  const MiddleCircle({
    Key? key,
  }) : super(key: key);

  @override
  State<MiddleCircle> createState() => _MiddleCircleState();
}

class _MiddleCircleState extends State<MiddleCircle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: cmbscritta ? Avatar() : Avatar2(),
        onTap: () async {
          if (recorder.isRecording) {
            await getData();
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Music(
                            imageUrl: imageUrl,
                            title: titleNew,
                            album: albumNew,
                            artist: artistNew,
                            release_date: release_dateNew,
                            spotify: spotifyNew,
                            link: linkNew,
                            apple: appleNew,
                          )),
                  (route) => false);
            });
          } else {
            await record();
          }
          setState(() {
            cmbscritta = !cmbscritta;
          });
        });
  }
}

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Escuchando...'),
        SizedBox(height: 100.0),
        AvatarGlow(
          duration: Duration(milliseconds: 2000),
          showTwoGlows: true,
          repeat: true,
          repeatPauseDuration: Duration(microseconds: 2),
          endRadius: 90.0,
          glowColor: Colors.red,
          child: Material(
            // Replace this child with your own
            elevation: 8.0,

            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 50.0,
              child: Image.asset(
                'assets/images/beat.png',
                height: 90,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Avatar2 extends StatefulWidget {
  const Avatar2({Key? key}) : super(key: key);

  @override
  State<Avatar2> createState() => _Avatar2State();
}

class _Avatar2State extends State<Avatar2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Toque para escuchar'),
        SizedBox(height: 100.0),
        AvatarGlow(
          duration: Duration(microseconds: 1),
          endRadius: 50.0,
          child: Material(
            // Replace this child with your own
            elevation: 8.0,

            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 50.0,
              child: Image.asset(
                'assets/images/beat.png',
                height: 90,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

dynamic getData() async {
  final path = await recorder.stopRecorder();
  final audioFile = File(path!);
  print('Recorded audio: $audioFile');
  String file = await fileConvert(audioFile);

  String first = 'https://api.audd.io/?';
  String dataLinks = 'apple_music,spotify';

  http.Response response = await http.post(
    Uri.parse('https://api.audd.io/'),
    headers: {'Content-Type': 'multipart/form-data'},
    body: jsonEncode(
      <String, dynamic>{
        'api_token': apiKey,
        'return': 'apple_music,spotify',
        'audio': file,
        'method': 'recognize',
      },
    ),
  );
  if (response.statusCode == 200) {
    String data = (response.body);
    var image =
        jsonDecode(data)['result']['spotify']['album']['images'][0]['url'];

    var title = jsonDecode(data)['result']['title'];
    var album = jsonDecode(data)['result']['album'];
    var artist = jsonDecode(data)['result']['artist'];
    var release_date = jsonDecode(data)['result']['release_date'];

    var spotify =
        jsonDecode(data)['result']['spotify']['external_urls']['spotify'];
    var link = jsonDecode(data)['result']['song_link'];
    var apple = jsonDecode(data)['result']['apple_music']['url'];

    var dataMusic = (jsonDecode(response.body));

    if (dataMusic != null) {
      var mainDataMusic = [
        image,
        title,
        album,
        artist,
        release_date,
        spotify,
        link,
        apple
      ];

      imageUrl = (mainDataMusic[0].toString());
      titleNew = (mainDataMusic[1].toString());
      albumNew = (mainDataMusic[2].toString());
      artistNew = (mainDataMusic[3].toString());
      release_dateNew = (mainDataMusic[4].toString());
      spotifyNew = (mainDataMusic[5].toString());
      linkNew = (mainDataMusic[6].toString());
      appleNew = (mainDataMusic[7].toString());

      print(mainDataMusic[1].toString());
      print(mainDataMusic);
    }
    return mainDataMusic;
  } else {
    throw Exception('Cant find song');
  }
}

//SEND FILE TO API
Future<String> fileConvert(File file) async {
  List<int> fileBytes = await file.readAsBytes();
  String base64String = base64Encode(fileBytes);
  return base64String;
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
    child: Text("Cerrar sesion"),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginUser()),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Cerrar sesion"),
    content: Text(
        "Al cerrar sesion de sus cuenta sera redirigido a la pantalla de Log In , Quiere continuar?"),
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
