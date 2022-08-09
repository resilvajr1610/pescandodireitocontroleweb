import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/buttom_custom.dart';
import '../widgets/input.dart';
import '../widgets/inputPassword.dart';
import '../widgets/snackBars.dart';
import '../widgets/text_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  bool visibiblePassword = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error="";

  _signFirebase()async{

    if (_controllerEmail.text.isNotEmpty) {
      setState(() {
        _error = "";
      });

      try{
        await _auth.signInWithEmailAndPassword(
            email: _controllerEmail.text.trim(),
            password: _controllerPassword.text.trim()
        ).then((auth)async{
          Navigator.pushReplacementNamed(context, "/navigation");
        });
      }on FirebaseAuthException catch (e) {
        if(e.code =="unknown"){
          setState(() {
            _error = "A senha está vazia!";
            showSnackBar(context, _error,_scaffoldKey);
          });
        }else if(e.code =="invalid-email"){
          setState(() {
            _error = "Digite um e-mail válido!";
            showSnackBar(context, _error,_scaffoldKey);
          });
        }else{
          setState(() {
            _error = e.code;
            showSnackBar(context, _error,_scaffoldKey);
          });
        }
      }
    } else {
      setState(() {
        _error = "Preencha seu email";
        showSnackBar(context, _error,_scaffoldKey);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: PaletteColor.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height*0.03),
                SizedBox(
                  height: 230,
                  width: width*0.15,
                  child:Image.asset("images/favicon.jpeg"),
                ),
                SizedBox(height: height*0.02),
                SizedBox(height: height*0.06),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 280,
                  child: TextCustom(text: 'E - mail',color: PaletteColor.primaryColor,size: 14.0,fontWeight: FontWeight.normal,textAlign: TextAlign.center,),
                ),
                Input(
                  icons: Icons.height,
                  sizeIcon: 0.01,
                  width: width*0.15,
                  controller: _controllerEmail,
                  hint:'E - mail',
                  fontSize: 14.0,
                  keyboardType: TextInputType.text,
                  colorBorder: PaletteColor.greyLight,
                  background: PaletteColor.greyLight,
                ),
                SizedBox(height: height*0.02),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 280,
                  child: TextCustom(text: 'Senha',color: PaletteColor.primaryColor,size: 14.0,fontWeight: FontWeight.normal,textAlign: TextAlign.center,),
                ),
                InputPassword(
                  showPassword: visibiblePassword,
                  icons: Icons.height,
                  colorIcon: Colors.white,
                  width: width*0.15,
                  obscure: visibiblePassword,
                  controller: _controllerPassword,
                  hint: 'Senha',
                  fonts: 14,
                  keyboardType: TextInputType.visiblePassword,
                  onPressed: (){
                    setState(() {
                      if(visibiblePassword==false){
                        visibiblePassword=true;
                      }else{
                        visibiblePassword=false;
                      }
                    });
                  },
                ),
                SizedBox(height: height*0.03),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonCustom(
                    widthCustom: 0.15,
                    heightCustom: 0.07,
                    onPressed:()=>_signFirebase(),
                    text: "Entrar",
                    sizeText: 14,
                    colorButton: PaletteColor.primaryColor,
                    colorText: PaletteColor.white,
                    colorBorder:PaletteColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
