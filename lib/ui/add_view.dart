import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/flutterfire.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AddView extends StatefulWidget {
  AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final player = AudioCache();
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
    "cardano",
    "uniswap",
    
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropdownValue,
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue.toString();
              });
            },
            items: coins.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Coin Amount",
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              border: Border.all(
                color: Colors.blue, 
                ),
            ),
            child: MaterialButton(
              enableFeedback: false,
              onPressed: () async {
                player.play('SilverQuarter.mp3');
                HapticFeedback.vibrate();
                await addCoin(dropdownValue, _amountController.text);
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.blue, 
                ),
              color: Colors.white,
            ),
            child: MaterialButton(
              enableFeedback: false,
              onPressed: () async {
                player.play('SilverQuarter.mp3');
                HapticFeedback.vibrate();
                await reduceCoin(dropdownValue, _amountController.text);
                Navigator.of(context).pop();
              },
              child: Text("Reduce"),
            ),
          ),
                    SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.blue, 
                ),
              color: Colors.white,
            ),
            child: MaterialButton(
              enableFeedback: false,
              onPressed: () async {
                player.play('SilverQuarter.mp3');
                HapticFeedback.vibrate();
                await editCoin(dropdownValue, _amountController.text);
                Navigator.of(context).pop();
              },
              child: Text("Edit"),
            ),
          ),
        ],
      ),
    );
  }
}
