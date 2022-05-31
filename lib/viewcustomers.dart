import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Viewcus extends StatefulWidget {
  @override
  _ViewcusState createState() => _ViewcusState();
}

class _ViewcusState extends State<Viewcus> {
  String name;
  int phone;
  int credit;
  int dcredit;
  int rcredit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.email)
                .collection('customers')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return CircularProgressIndicator();
              }
              return ListView(
                  children:
                      snapshot.data.docs.map((DocumentSnapshot documents) {
                return Card(
                  elevation: 8.0,
                  child: ListTile(
                    leading: Text(documents['name']),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(documents['phone'].toString()),
                        Text(documents['credit'].toString()),
                        IconButton(
                            icon: Icon(Icons.remove, color: Colors.black45),
                            onPressed: () {
                              _removeCredit(
                                  context, documents['credit'], documents.id);
                            }),
                        IconButton(
                            icon: Icon(Icons.add, color: Colors.black45),
                            onPressed: () {
                              _addCredit(
                                  context, documents['credit'], documents.id);
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _editFormDialog(
                                  context, documents.id, documents['name']);
                            }),
                      ],
                    ),
                  ),
                );
              }).toList());
            }),
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
                        .collection('customers')
                        .doc(documentId)
                        .delete();
                    Navigator.pop(context);
                  },
                  child: Text('YES'))
            ],
            title: Text('Do you want to Delete the customer $nmdel ?'),
          );
        });
  }

  _removeCredit(
    BuildContext context,
    int rmcredit,
    String documentId,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    rmcredit = rmcredit - rcredit;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.email)
                        .collection('customers')
                        .doc(documentId)
                        .update({'credit': rmcredit});
                    Navigator.pop(context);
                  },
                  child: Text('Update'))
            ],
            title: Text('Remove Credit'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      rcredit = int.parse(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Remove credit', labelText: 'Credit'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _addCredit(BuildContext context, int addcredit, String documentId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    addcredit = addcredit + dcredit;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.email)
                        .collection('customers')
                        .doc(documentId)
                        .update({'credit': addcredit});
                    Navigator.pop(context);
                  },
                  child: Text('Update'))
            ],
            title: Text('Add Credit'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      dcredit = int.parse(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Add credit', labelText: 'Credit'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context, String documentId, String delnm) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.email)
                        .collection('customers')
                        .doc(documentId)
                        .update({
                      'name': name,
                      'phone': phone,
                      'credit': credit,
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Update')),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleFromDialog(context, documentId, delnm);
                  }),
            ],
            title: Text('Edit Customer'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Edit name', labelText: 'Name'),
                  ),
                  TextField(
                    onChanged: (value) {
                      phone = int.parse(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Edit phonenumber', labelText: 'Phone'),
                  ),
                  TextField(
                    onChanged: (value) {
                      credit = int.parse(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Edit credit', labelText: 'Credit'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
