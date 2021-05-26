import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
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
                .doc(
                FirebaseAuth.instance.currentUser.email)
                .collection(
                'expense')
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
                            IconButton(icon: Icon(Icons.edit, color: Colors.grey,),onPressed: (){}),
                            IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){})
                          ],
                        ),
                        subtitle: Text(documents['reference']),
                      ),
                    );
                    // Container(
                      //   margin: EdgeInsets.all(10),
                    //     child: Table(
                    //         border: TableBorder(horizontalInside: BorderSide(width: 2, color: Colors.blue, style: BorderStyle.solid)),
                    //         children: [
                    //           TableRow(
                    //               children: [
                    //                 Column(children: [
                    //                   Text(documents['amount'].toString()),
                    //                 ],),
                    //
                    //                 Column(children: [
                    //                   Text(getCustomFormattedDateTime(
                    //                       documents['date'], 'MM/dd/yy'))
                    //                 ],),
                    //                 Column(
                    //                   children: [Text(documents['category'])],),
                    //                 Column(
                    //                   children: [
                    //                     Text(documents['reference'])
                    //                   ],),
                    //               ]
                    //           )
                    //         ]
                    //     )
                    // );
                  }
                  ).toList()
              );
            }
        ),
      ),

    );
  }
}


