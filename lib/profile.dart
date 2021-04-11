import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;

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
                    name = value;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle:
                  TextStyle(color: Colors.black, fontSize: 16.0),
                  )
                ),
              ),


            ]
          ),
        ),
       ),
    );
  }
}