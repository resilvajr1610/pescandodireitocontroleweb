import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/alert_model.dart';
import '../utils/colors.dart';
import '../widgets/buttom_custom.dart';
import '../widgets/input.dart';
import '../widgets/text_custom.dart';

class CologneScreen extends StatefulWidget {
  const CologneScreen({Key? key}) : super(key: key);

  @override
  State<CologneScreen> createState() => _CologneScreenState();
}

class _CologneScreenState extends State<CologneScreen> {

  var _controllerInstitution = TextEditingController();
  var _controllerPhone = TextEditingController();
  var _controllerAddress = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  _saveQuestion()async{

    DocumentReference ref  = db.collection('cologne').doc();

    String id = ref.id;

    db.collection('cologne').doc(id).set({
      'id':id,
      'institution' : _controllerInstitution.text,
      'phone' : _controllerPhone.text,
      'address' : _controllerAddress.text,
      'time' : DateTime.now()
    }).then((value){
      setState(() {
        AlertModel().alert('Sucesso!', 'Colônio de pescadores foi salva!',PaletteColor.green,PaletteColor.grey,context,
            [
              ButtonCustom(
                onPressed: (){
                  Navigator.pop(context);
                },
                text: 'OK',
                widthCustom: 0.1,
                heightCustom: 0.05,
                colorBorder: PaletteColor.primaryColor,
                colorButton: PaletteColor.primaryColor,
                colorText: PaletteColor.white,
                sizeText: 14.0,
              ),
            ]);
        _controllerInstitution.clear();
        _controllerPhone.clear();
        _controllerAddress.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: PaletteColor.greyLight,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 64.0, left: 95, bottom: 16),
              child: Container(
                width: width,
                child: TextCustom(
                  text: 'Cadastrar novos dados',
                  size: 24.0,
                  fontWeight: FontWeight.bold,
                  color: PaletteColor.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:width*0.05),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal:  width*0.05,),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextCustom(
                          text: 'Instituição',
                          size: 14.0,
                          color:  PaletteColor.grey,
                        ),
                      ),
                      Input(
                        controller: _controllerInstitution,
                        hint: 'Instituição',
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextCustom(
                          text: 'Telefone',
                          size: 14.0,
                          color:  PaletteColor.grey,
                        ),
                      ),
                      Input(
                        controller: _controllerPhone,
                        hint: '(XX) XXXX - XXXX',
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width*0.2,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextCustom(
                          text: 'Endereço',
                          size: 14.0,
                          color:  PaletteColor.grey,
                        ),
                      ),
                      Input(
                        controller: _controllerAddress,
                        hint: 'Endereço',
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      SizedBox(height: 50),
                      ButtonCustom(
                          onPressed: () {
                            if(_controllerInstitution.text.isNotEmpty && _controllerPhone.text.isNotEmpty && _controllerAddress.text.isNotEmpty){
                              _saveQuestion();
                            }else{
                              AlertModel().alert('Erro !','Preencha todos campos para salvar a Colônia.',PaletteColor.red,PaletteColor.red,context,
                                  [
                                    ButtonCustom(
                                      onPressed: ()=>Navigator.pop(context),
                                      text: 'OK',
                                      widthCustom: 0.1,
                                      heightCustom: 0.05,
                                      colorBorder: PaletteColor.primaryColor,
                                      colorButton: PaletteColor.primaryColor,
                                      colorText: PaletteColor.white,
                                      sizeText: 14.0,
                                    ),
                                  ]);
                            }
                          },
                          text: 'Salvar',
                          sizeText: 14.0,
                          colorButton: PaletteColor.primaryColor,
                          colorText: PaletteColor.white,
                          colorBorder: PaletteColor.primaryColor,
                          widthCustom: 0.15,
                          heightCustom: 0.05),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
