import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Editnew extends StatefulWidget {
  @override
  _EditnewState createState() => _EditnewState();
}

class _EditnewState extends State<Editnew> {
  getCustomFormattedDateTime(Timestamp givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = givenDateTime.toDate() ;
    return DateFormat(dateFormat).format(docDateTime);
  }
  DateTime dt;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
          stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.email).collection('expense').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //print(snapshot.data.docs.length);

            if(snapshot.hasError) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot documents) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: DataTable(
                    rows: [
                      DataRow(
                          cells: [
                            DataCell(Text(documents['amount'].toString()),showEditIcon: true,
                            onTap: (){ }
                            ),
                            DataCell(
                              Text( getCustomFormattedDateTime(documents['date'], 'MM/dd/yy'))
                            ),
                            DataCell( Text(documents['category']),),
                            DataCell(Text(documents['reference']),),
                          ]
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );

  }
}


