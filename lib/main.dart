import 'package:flutter/material.dart';
import 'package:new_proj/models/user.dart';
import 'package:new_proj/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_proj/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<myUser?>.value(
      initialData: null,
      catchError: (_,__) {},
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}