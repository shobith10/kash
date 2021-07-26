import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Edit> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Edit()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'View/Edit',
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
          ],
        ),
      ),
    );
  }
}

class _EditState extends State<Edit> {
  getCustomFormattedDateTime(Timestamp givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = givenDateTime.toDate();
    return DateFormat(dateFormat).format(docDateTime);
  }

  DateTime dt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Expense Analyzer',
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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users')
                .doc(FirebaseAuth.instance.currentUser.email)
                .collection('expense')
                .orderBy('date', descending: true)
                .snapshots(),

            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              //print(snapshot.data.docs.length);

              if (snapshot.hasError) {
                return CircularProgressIndicator();
              }
              return ListView(
                  children: snapshot.data.docs.map((
                      DocumentSnapshot documents) {
                    return Card(
                      elevation: 8.0,
                      child: ListTile(
                        leading: Text(getCustomFormattedDateTime(documents['date'], 'MM/dd/yy')),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(documents['amount'].toString()),
                            Text(documents['category']),
                            IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){ _deleFromDialog(context, documents.id, documents['amount']); })
                          ],
                        ),
                        subtitle: Text(documents['reference']),
                      ),
                    );
                  }
                  ).toList()
              );
            }
        ),
      ),

    );
  }

  _deleFromDialog(BuildContext context, String documentId, int amt){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param){
          return AlertDialog(
            actions: <Widget>[
              FlatButton(onPressed:() => Navigator.pop(context),
                  child: Text('NO')),
              FlatButton(onPressed: () async{
                await  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.email).collection('expense').doc(documentId).delete();
                Navigator.pop(context);
              },
                  child: Text('YES'))
            ],
            title: Text('Do you want to Delete the expense ${amt} ?'),
          );
        }
    );
  }


}


