import 'package:find_track_app/Screens/homeScreen.dart';
import 'package:flutter/material.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.1),
        elevation: 0,
        title: Text(
          'Sign In',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/loading.gif'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstATop),
              fit: BoxFit.cover),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset('assets/images/beat.png'),
              SizedBox(
                height: 120,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                child: Ink(
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(100, 6, 100, 6),
                    child: Wrap(
                      children: [
                        Icon(Icons.android),
                        SizedBox(width: 12),
                        Text('Sign in with Google'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
