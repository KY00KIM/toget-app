import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:toget/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:toget/ui/home/home.dart';
import 'package:toget/ui/login/login.dart';

import '../utils/firebase/auth_controller.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/home',
            page: () => HomeScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            transition: Transition.cupertino),
      ],
      home: const DebugPage(title: 'Flutter Demo Home Page'),
      // home: const HomeScreen(),
    );
  }
}

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key, required this.title}) : super(key: key);
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  int _counter = 0;
  bool _isLoading = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _loadStatus() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void setUserName(String new_user_name) {
    setState(() {
      user_name = new_user_name;
    });
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    authListener(setUserName, setUserName);
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () async {
                    _loadStatus();
                    await googleLogin();
                    _loadStatus();
                  },
                  child: Text('로그인'),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () => getUserProfile(),
                  child: Text('프로필!!!'),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('$user_name'),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () => googleLogout(),
                  style: TextButton.styleFrom(
                    primary: Colors.white, // foreground
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("로그아웃"),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/home'),
                  style: TextButton.styleFrom(
                    primary: Colors.white, // foreground
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("HomePage"),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/login'),
                  style: TextButton.styleFrom(
                    primary: Colors.white, // foreground
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("LoginPage"),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Container(
              child: _isLoading
                  ? Text(
                      "Loading...",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : Container(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
