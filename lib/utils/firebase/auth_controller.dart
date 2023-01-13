import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:toget/ui/toget_app.dart';

String myid = "";
bool isLogined = false;
late UserCredential userCredential;
late String user_name = "";

void authListener(
    void onLogout(String new_user_name), void onLogin(String new_user_name)) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      user_name = "NOT_LOGINED";
      onLogout(user_name);
      isLogined = false;
    } else {
      print('User is signed in!');
      print("user : " + user.toString());
      print(user.displayName);
      user_name = user.displayName!;
      onLogin(user_name);
    }
  });
}

Future<void> googleLogin() async {
  userCredential = await signInWithGoogle();
  if (userCredential == null) {
    print("FAILED TO LOGIN\n");
  } else {
    print("SUCCESSFULLY LOGINED!\n");
  }
}

Future<void> getUserProfile() async {
  String? name = FirebaseAuth.instance.currentUser?.displayName;
  String? uid = userCredential.user?.uid;
  // String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
  print("name: $name\nuid : $uid\n");

  // print(idToken);
}

Future<void> googleLogout() async {
  FirebaseAuth.instance.signOut();
}
