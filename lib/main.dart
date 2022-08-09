import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pescandodireitocontroleweb/utils/routes.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyChqwsUC98XwFVb3KXB9exgJjQdS2aEDOk",
      appId: "1:465838337939:web:2007e37660c2b989398266",
      messagingSenderId: "465838337939",
      projectId: "pescador-48e07",
    ),
  );
  var route='/login';

  if(FirebaseAuth.instance.currentUser!=null){
    route ='/navigation';
  }else{
    route ='/login';
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: LoginScreen(),
    initialRoute:route,
    onGenerateRoute: Routes.generateRoute,
  ));
}