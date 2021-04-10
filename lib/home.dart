import 'package:flutter/material.dart';

//import 'instant.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//
// import 'sign.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  //final _auth = FirebaseAuth.instance;
  String amount;

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
              // onTap: launchRating,
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
              onTap: () {
                // Update the state of the app.
                // ...
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
              onTap: () {
                // Update the state of the app.
                // // ...
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AboutUs()));
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
              // onTap: SBMsite,
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
              // onTap: SBMsite,
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // onTap: SBMsite,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 130),
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
              fontSize: 30.0,
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
            // onPressed: () => showAlertDialog(context),
          )
        ],
      ),
      body: ModalProgressHUD(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                    onChanged: (value) {
                      amount = value;
                    },
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Rs. 000",
                      hintStyle:
                      TextStyle(color: Colors.black, fontSize: 16.0),
                    )),
              ),
            ]
            ),
          ),
        ),
      ),

    );
  }

}
