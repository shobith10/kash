import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  int phone;
  String occu;
  String acc;
  bool update;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
            'Profile',
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
            child: Column(
              children: [
                SizedBox(
                height: 40,
                ),
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  hintText: 'name',
                  hintStyle:
                  TextStyle(color: Colors.black, fontSize: 16.0),
                  )
                  ),
              ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                      onChanged: (value) {
                        phone = int.parse(value);
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Phone number",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      )
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30),
                   child: TextFormField(
                      onChanged: (value) {
                        occu = value;
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Occupation",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      )
                  ),

                ),
                SizedBox(
                  height: 30,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                            onChanged: (value) {
                              acc = value;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "Account details",
                              hintStyle:
                              TextStyle(color: Colors.black, fontSize: 16.0),

                            )
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.email).collection('profile').add(
                        {
                          'name': name,
                          'phone' : phone,
                          'occupation' : occu,
                          'account' : acc,
                          'isupdate': update=false,
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Update',
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
              ]
          ),

       ),
    );
  }
}