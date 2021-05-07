import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Edit extends StatefulWidget {
    @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder<DocumentSnapshot>(
              future: _firestore.collection('expense').doc(FirebaseAuth.instance.currentUser.email).get(),
              builder: (context, snapshot){
                return
                ListView(
                  children: [
                    ListTile(
                      title: Text(snapshot.data['amount']),
                      subtitle: Text(snapshot.data['date']),

                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}