import 'package:flutter/material.dart';
import 'package:kash/addcustomers.dart';
import 'package:kash/viewcustomers.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  int val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Business',
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
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Center(
                      heightFactor: 3.5,
                      widthFactor: 3.2,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Total Credit\n 5125',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black87,
                          width: 4.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //     child: Container(
                //         child: Center(
                //           heightFactor: 4.5,
                //           widthFactor: 1.57,
                //           child: Padding(
                //             padding: const EdgeInsets.all(5.0),
                //             child: Text(
                //               'Total Credit\n 000',
                //               style: TextStyle(
                //                 color: Colors.blue,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20,
                //               ),
                //             ),
                //           ),
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Colors.black87,
                //               width: 4.0,
                //               style: BorderStyle.solid),
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(10.0),
                //             topRight: Radius.circular(10.0),
                //             bottomLeft: Radius.circular(10.0),
                //             bottomRight: Radius.circular(10.0),
                //           ),
                //         )
                //     ),
                //   ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Addcustomer()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Add Customers',
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
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Viewcus()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'View Customers',
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
    );
  }
}
