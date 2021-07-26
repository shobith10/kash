import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kash/plan.dart';

class Money extends StatefulWidget {
  @override
  _MoneyState createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  int tamount;
  int month;
  int bsal;
  String purpose;
  int ts;
  int plan;
  int mplan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Save Money',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                      onChanged: (value) {
                        purpose = value;
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: InputDecoration(
                        labelText: "Purpose",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "buy new phone",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                      onChanged: (value) {
                        tamount = int.parse(value);
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: "Target amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Rs. 000",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                      onChanged: (value) {
                        month = int.parse(value);
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],

                      decoration: InputDecoration(
                        labelText: "Time Period",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Number of months",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                      onChanged: (value) {
                        bsal = int.parse(value);

                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],

                      decoration: InputDecoration(
                        labelText: "Basic Salary",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "0000",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.email).collection('savemoney').add(
                        {
                          'purpose': purpose,
                          'target' : tamount,
                          'monthp' : month,
                          'maxex': ((bsal*month)-tamount)/month,
                          'basic': bsal
                        });
                    _xpeseadded(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Generate Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Plan()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'View Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.blue,
                )
              ],
            ),
          ),
      ),
    );
  }

  _xpeseadded(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param){
          return AlertDialog(
            actions: <Widget>[
              FlatButton(onPressed:() => Navigator.pop(context),
                  child: Text('OK')
              ),
            ],
            title: Text('Plan generated !'),
          );
        }
    );
  }
}
