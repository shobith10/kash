import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  Widget build(BuildContext context) {
    String _email;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Reset Data',
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
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                    onChanged: (value) {
                      _email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "EMAIL",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                onPressed: () async {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Send Request',
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
      ),
    );
  }
}
