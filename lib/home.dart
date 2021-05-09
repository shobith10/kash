import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kash/Business.dart';
import 'package:flutter/cupertino.dart';
import 'package:kash/Savemoney.dart';
import 'package:kash/aboutus.dart';
import 'package:kash/edit.dart';
import 'package:kash/profile.dart';
import 'package:kash/settings.dart';
import 'package:kash/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user =
          _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }

  // void expenseStream() async{
  //   await for(var snapshot in _firestore.collection('expense').snapshots()){
  //     for (var expense in snapshot.docs){
  //       print(expense.data);
  //     }
  //   }
  // }

  int amount;
  DateTime date;
  String category;
  String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                      size: 30,
                    ),
                    backgroundColor: Colors.blue,
                  )),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
               onTap: () async {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Profile()));
            },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Business',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Business()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Save Money',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Money()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),

            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Divider(
                thickness: 1,
                color: Colors.blue,
                indent: 10,
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Version: v1.0',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile()));
            },
          )
        ],
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
              child: TextFormField(
                  onChanged: ( value) {
                    amount = int.parse(value);
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly],

                  decoration: InputDecoration(
                      labelText: "Enter your expense",
                    border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    hintText: "Rs. 000",
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
                child:  Container(
                  height: 80,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      date = newDateTime;
                    },
                  ),
                ),
              ),
            SizedBox(
              height: 30,
            ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButton<String>(
                  focusColor:Colors.white,
                  value: category,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor:Colors.black,
                  items: <String>[
                    'Food',
                    'Electricity',
                    'Travel',
                    'Rent',
                    'Cosmetics',
                    'Grocery',
                    'Others',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black),),
                    );
                  }).toList(),
                  hint:Text(
                    "Category",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      category = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                    onChanged: (value) {
                      tag = value;
                    },
                    style: TextStyle(color: Colors.black, fontSize: 16.0),

                    decoration: InputDecoration(
                      labelText: "TAG",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Item",
                      hintStyle:
                      TextStyle(color: Colors.black, fontSize: 16.0),
                    )

                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () async {
                   await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser.email).collection('expense').add(
                        {
                      'amount': amount,
                      'category' : category,
                      'date' : date,
                          'reference' : tag,
                    });
                },
                child: Padding(

                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Add Expense',
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
              SizedBox(height: 20.0),
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
          ]
          ),
        ),
      ),

    );
  }

}

