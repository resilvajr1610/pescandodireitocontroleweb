

import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/navigation_screen.dart';

class Routes{
    static Route<dynamic>? generateRoute(RouteSettings settings){
      final args = settings.arguments;

      switch(settings.name){
        case "/login" :
          return MaterialPageRoute(
              builder: (_) => LoginScreen()
          );
        case "/navigation" :
          return MaterialPageRoute(
              builder: (_) => NavigationScreen(index: 0)
          );
        // case "/home" :
        //   return MaterialPageRoute(
        //       builder: (_) => HomeScreen()
        //   );
        // case "/fees" :
        //   return MaterialPageRoute(
        //       builder: (_) => FeesScreen()
        //   );
        // case "/enterprise" :
        //   return MaterialPageRoute(
        //       builder: (_) => EnterpriseScreen()
        //   );
        // case "/finances" :
        //   return MaterialPageRoute(
        //       builder: (_) => FinancesScreen()
        //   );
        // case "/delivery" :
        //   return MaterialPageRoute(
        //       builder: (_) => DeliveryScreen()
        //   );
        // case "/questions" :
        //   return MaterialPageRoute(
        //       builder: (_) => FeesScreen()
        //   );
        default :
          _erroRota();
      }
    }
    static  Route <dynamic> _erroRota(){
      return MaterialPageRoute(
          builder:(_){
            return Scaffold(
              appBar: AppBar(
                title: Text("Tela em desenvolvimento"),
              ),
              body: Center(
                child: Text("Tela em desenvolvimento"),
              ),
            );
          });
    }
  }