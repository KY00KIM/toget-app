import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
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
              "HomeScreen",
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
