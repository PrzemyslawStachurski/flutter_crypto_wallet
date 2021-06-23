import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/api_methods.dart';
import 'package:flutter_app/net/flutterfire.dart';
import 'package:flutter_app/ui/auth.dart';
// import 'package:flutter_app/ui/chart.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double tether = 0.0;
  double ethereum = 0.0;
  double cardano = 0.0;
  double uniswap = 0.0;

  @override
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    tether = await getPrice("tether");
    ethereum = await getPrice("ethereum");
    cardano = await getPrice("cardano");
    uniswap = await getPrice("uniswap");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "tether") {
        return tether * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else if (id == "cardano") {
        return cardano * amount;
      } else {
        return uniswap * amount;
      }
    }

    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Text("Cyber Store"),
        actions: <Widget>[
          // IconButton(onPressed: (){
          //   Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Chart()));
          // }, icon: Icon(
          //   Icons.pie_chart,
          //   color: Colors.white,
          // )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Auth()),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 2.5),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(1),
                              child: Image.asset('assets/${document.id}.png'),
                            ),
                            Text(
                              " ${document.id}",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${getValue(document.id, document['Amount']).toStringAsFixed(2)} PLN",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.red[400],
                              ),
                              onPressed: () async {
                                await removeCoin(document.id);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddView()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
