import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.email)
              .collection('savemoney')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return CircularProgressIndicator();
            }
            return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot documents) {
              return Card(
                elevation: 8.0,
                child: ListTile(
                  leading: Text(
                      'Max monthly expense: Rs.${documents['maxex'].toString()}'),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(documents['purpose']),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deleFromDialog(
                                context, documents.id, documents['purpose']);
                          }),
                    ],
                  ),
                  subtitle: Text('in coming ${documents['monthp']} months'),
                ),
              );
            }).toList());
          },
        ),
      ),
    );
  }

  _deleFromDialog(BuildContext context, String documentId, String nmdel) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('NO')),
              FlatButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.email)
                        .collection('savemoney')
                        .doc(documentId)
                        .delete();
                    Navigator.pop(context);
                  },
                  child: Text('YES'))
            ],
            title: Text('Do you want to Delete the plan ${nmdel} ?'),
          );
        });
  }
}
