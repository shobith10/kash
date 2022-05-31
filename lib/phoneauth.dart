import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FROM_STATE,
  SHOW_OTP_FROM_STATE,
}

class PhAuth extends StatefulWidget {
  @override
  _PhAuthState createState() => _PhAuthState();
}

class _PhAuthState extends State<PhAuth> {
  final formKey = new GlobalKey<FormState>();
  String phoneNo, verificationId, otp;

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FROM_STATE;
  final otpController = TextEditingController();
  final phoneController = TextEditingController();

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
    }
  }

  getMobileFromWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 25.0, left: 25.0),
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            onChanged: (val) {
              setState(() {
                this.phoneNo = val;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: RaisedButton(
            child: Center(
              child: Text('VERIFY'),
            ),
            onPressed: () async {
              setState(() {
                showLoading = true;
              });
              await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phoneNo,
                  timeout: const Duration(seconds: 60),
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoading = false;
                    });
                  },
                  verificationFailed: (verificationFailed) async {
                    setState(() {
                      showLoading = false;
                    });
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text(verificationFailed.message)));
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      showLoading = false;
                      currentState =
                          MobileVerificationState.SHOW_OTP_FROM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
            },
          ),
        )
      ],
    );
  }

  getOtpFromWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 25.0, left: 25.0),
          child: TextFormField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            onChanged: (val) {
              setState(() {
                this.otp = val;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: RaisedButton(
            child: Center(
              child: Text('LOGIN'),
            ),
            onPressed: () async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
          ),
        )
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FROM_STATE
                  ? getMobileFromWidget(context)
                  : getOtpFromWidget(context),
        )

        // body: Form(
        //   key: formKey,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Padding(
        //         child: TextFormField(
        //           //padding: EdgeInsets.only(right: 25.0, left: 25.0),
        //           keyboardType: TextInputType.phone,
        //           onChanged: (val) {
        //             setState(() {
        //               this.phoneNo=val;
        //             });
        //           },
        //         ),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(right: 25, left: 25),
        //         child: RaisedButton(
        //           child: Center(child: Text('LOGIN'),),
        //           onPressed: (){
        //             verifyPhone(phoneNo);
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }

  // Future<void> verifyPhone(phoneNo) async {
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult){
  //
  //   };
  //
  //   final PhoneVerificationFailed verificationfailed = (FirebaseAuthException authException){
  //     print('${authException.message}');
  //   };
  //
  //   final PhoneCodeSent smsSent = (String verId, [int forceResend]){
  //     this.verificationId = verId;
  //   };
  //
  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
  //     this.verificationId = verId;
  //   };
  //
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNo,
  //       timeout: const Duration(seconds: 5),
  //       verificationCompleted: verified,
  //       verificationFailed: verificationfailed,
  //       codeSent: smsSent,
  //       codeAutoRetrievalTimeout: null);
  //   }
}
