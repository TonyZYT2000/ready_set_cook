import 'package:auth_screen/screens/auth_screen.dart';
import 'package:auth_screen/screens/signout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/starting.dart';

void main() async{
    print("done");
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   print("yup");
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFF26DBE5),
        accentColor: Color(0xFF9ACA41),
        // accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Color(0xFF26DBE5),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
        )
      ),
      home: 
      StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot){
        if(userSnapshot.hasData){
          return Signout();
        }
        return AuthScreen();
      })
    );
  }
}


// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
  
// }

// class App extends StatelessWidget {
//   // Create the initialization Future outside of `build`:
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Text("something is wrong");
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Start();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Text("still waiting");
//       },
//     );
//   }
// }