import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Viewcus extends StatefulWidget {
  @override
  _ViewcusState createState() => _ViewcusState();
}
class _ViewcusState extends State<Viewcus> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Customer List',
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
                .collection('customers')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {

              if (snapshot.hasError) {
                return CircularProgressIndicator();
              }
              return ListView(
                  children: snapshot.data.docs.map((
                      DocumentSnapshot documents) {
                    return Card(
                      elevation: 8.0,
                      child: ListTile(
                        leading: Text(documents['name']),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          Text(documents['phone'].toString()),
                            Text(documents['credit'].toString()),
                            IconButton(icon: Icon(Icons.edit, color: Colors.grey,),onPressed: (){}),
                            IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){})
                          ],
                        ),
                      ),
                    );

                    //   Container(
                    //     child: Table(
                    //         border: TableBorder.all(
                    //             color: Colors.black,
                    //             style: BorderStyle.solid,
                    //             width: 2),
                    //         children: [
                    //           TableRow(
                    //               children: [
                    //                 Column(children: [
                    //                   Text(documents['name']),
                    //                 ],),
                    //                 Column(children: [
                    //                   Text(
                    //                       documents['phone'].toString())
                    //                 ],),
                    //                 Column(
                    //                   children: [Text(documents['credit'].toString())],),
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