import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/alert_model.dart';
import '../utils/colors.dart';
import '../widgets/buttom_custom.dart';
import '../widgets/input.dart';
import '../widgets/text_custom.dart';

class GovernamentScreen extends StatefulWidget {
  const GovernamentScreen({Key? key}) : super(key: key);

  @override
  State<GovernamentScreen> createState() => _GovernamentScreenState();
}

class _GovernamentScreenState extends State<GovernamentScreen> {

  var _controllerInstitution = TextEditingController();
  var _controllerPhone = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerName = TextEditingController();
  var _controllerOffice = TextEditingController();
  var _controllerAddress = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<DropdownMenuItem<String>>_listItemsManagement = [];
  String _itemSelectManagement='';

  static List<DropdownMenuItem<String>> getTypeManagement(){
    List<DropdownMenuItem<String>> itensDrop = [];

    itensDrop.add(
        DropdownMenuItem(child: Text(
          "Selecione uma gestão",style: TextStyle(fontSize: 15,color: Colors.black54),
        ),value: '',)
    );
    itensDrop.add(
        DropdownMenuItem(child: Text("Estadual",style: TextStyle(fontSize: 15,color: Colors.black54),),value: "Estadual",)
    );
    itensDrop.add(
        DropdownMenuItem(child: Text("Federal",style: TextStyle(fontSize: 15,color: Colors.black54)),value: "Federal",)
    );
    return itensDrop;
  }

  _loadItensDropdown(){
    _listItemsManagement = getTypeManagement();
  }

  _saveQuestion()async{

    DocumentReference ref  = db.collection('governament').doc();

    String id = ref.id;

    db.collection('governament').doc(id).set({
      'id':id,
      'institution' : _controllerInstitution.text,
      'management' : _itemSelectManagement,
      'phone' : _controllerPhone.text,
      'email' : _controllerEmail.text,
      'name' : _controllerName.text,
      'office' : _controllerOffice.text,
      'address' : _controllerAddress.text,
      'time' : DateTime.now()
    }).then((value){
      setState(() {
        AlertModel().alert('Sucesso!', 'Órgão do Governo foi salvo!',PaletteColor.green,PaletteColor.grey,context,
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
        _controllerEmail.clear();
        _controllerName.clear();
        _controllerOffice.clear();
        _controllerAddress.clear();
        _itemSelectManagement='';
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItensDropdown();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextCustom(
                                  text: 'Gestão',
                                  size: 14.0,
                                  color:  PaletteColor.grey,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: width*0.2,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                    color: PaletteColor.greyLight,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: PaletteColor.greyLight,)
                                ),
                                child: DropdownButtonFormField(
                                  value: _itemSelectManagement,
                                  hint: Text("Selecione uma gestão",style: TextStyle(fontSize: 15)),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  ),
                                  items: _listItemsManagement,
                                  onChanged: (valor){
                                    setState(() {
                                      _itemSelectManagement = valor.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextCustom(
                                  text: 'E-mail',
                                  size: 14.0,
                                  color:  PaletteColor.grey,
                                ),
                              ),
                              Input(
                                controller: _controllerEmail,
                                hint: 'E-mail',
                                fontSize: 14.0,
                                keyboardType: TextInputType.text,
                                width: width*0.2,
                                colorBorder: PaletteColor.greyLight,
                                background: PaletteColor.greyLight,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextCustom(
                                  text: 'Representante',
                                  size: 14.0,
                                  color:  PaletteColor.grey,
                                ),
                              ),
                              Input(
                                controller: _controllerName,
                                hint: 'Nome',
                                fontSize: 14.0,
                                keyboardType: TextInputType.text,
                                width: width*0.42,
                                colorBorder: PaletteColor.greyLight,
                                background: PaletteColor.greyLight,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextCustom(
                                  text: 'Cargo',
                                  size: 14.0,
                                  color:  PaletteColor.grey,
                                ),
                              ),
                              Input(
                                controller: _controllerOffice,
                                hint: 'Cargo',
                                fontSize: 14.0,
                                keyboardType: TextInputType.text,
                                width: width*0.2,
                                colorBorder: PaletteColor.greyLight,
                                background: PaletteColor.greyLight,
                              ),
                            ],
                          ),
                        ],
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
                            if(_controllerInstitution.text.isNotEmpty && _itemSelectManagement.isNotEmpty && _controllerPhone.text.isNotEmpty
                              && _controllerEmail.text.isNotEmpty && _controllerName.text.isNotEmpty && _controllerOffice.text.isNotEmpty
                              && _controllerAddress.text.isNotEmpty){
                              _saveQuestion();
                            }else{
                              AlertModel().alert('Erro !','Preencha todos campos para salvar a Instituição.',PaletteColor.red,PaletteColor.red,context,
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
                          heightCustom: 0.05
                      ),
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
