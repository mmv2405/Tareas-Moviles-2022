import 'package:flutter/material.dart';

enum ChooseTip { twenty, eighteen, fifteen }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChooseTip? _tipPercentage = ChooseTip.twenty;
  bool isSwitched = true;
  dynamic service = '';
  num tip = 20.0;
  num total = 0;
  num totalTip = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.green,
        ),
        toggleableActiveColor: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tip time'),
        ),
        body: ListView(
          children: [
            SizedBox(height: 14),
            ListTile(
              leading: Icon(Icons.room_service),
              title: Padding(
                padding: EdgeInsets.only(right: 24),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      service = text;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cost of service',
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dinner_dining),
              title: Text("How was the service?"),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Amazing 20%'),
                  leading: Radio<ChooseTip>(
                    value: ChooseTip.twenty,
                    groupValue: _tipPercentage,
                    onChanged: (ChooseTip? value) {
                      setState(() {
                        _tipPercentage = value;
                        tip = 20.0;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Good 18%'),
                  leading: Radio<ChooseTip>(
                    value: ChooseTip.eighteen,
                    groupValue: _tipPercentage,
                    onChanged: (ChooseTip? value) {
                      setState(() {
                        _tipPercentage = value;
                        tip = 18.0;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Okay 15%'),
                  leading: Radio<ChooseTip>(
                    value: ChooseTip.fifteen,
                    groupValue: _tipPercentage,
                    onChanged: (ChooseTip? value) {
                      setState(() {
                        _tipPercentage = value;
                        tip = 15.0;
                      });
                    },
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Round up tip"),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Material(
                //Wrap with Material
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias, // Add This
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 55,
                  color: Colors.green,
                  child: new Text(
                    'CALCULATE',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    if (service == '') {
                      //SHOW SNACK BAR IF SERVICE IS EMPTY
                    }
                    setState(() {
                      if (isSwitched != true) {
                        totalTip = _tipCalculationDouble(service, tip);
                      } else {
                        totalTip = _tipCalculationRounded(service, tip);
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(trailing: Text("Tip amount: \$ $totalTip")),
          ],
        ),
      ),
    );
  }

  dynamic _tipCalculationRounded(service, tip) {
    dynamic total;

    total = ((double.parse(this.service) * tip) ~/ 100);
    print(total);
    return total;
  }

  dynamic _tipCalculationDouble(service, tip) {
    dynamic total;

    total = ((double.parse(this.service) * tip) / 100);
    print(total);
    return total;
  }
}
