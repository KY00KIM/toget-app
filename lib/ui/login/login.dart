import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 1,
              color: Colors.black,
            ),
            Text(
              "LoginScreen",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                primary: Colors.white, // foreground
                backgroundColor: Colors.blue,
              ),
              child: Text("GoBack"),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
          ]),
    );
  }
}
