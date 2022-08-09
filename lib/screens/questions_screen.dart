
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/alert_model.dart';
import '../models/question_model.dart';
import '../utils/colors.dart';
import '../widgets/buttom_custom.dart';
import '../widgets/container_question.dart';
import '../widgets/input.dart';
import '../widgets/text_custom.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var _controllerQuestion = TextEditingController();
  var _controllerAnswer = TextEditingController();
  List<QuestionModel> list=[];
  List _allResults = [];
  var select = 1;
  String selectText='fala';

  data(String type)async{
    var data = await db.collection(type).get();

    setState(() {
      _allResults = data.docs;
    });
  }

  _saveQuestion()async{

    DocumentReference ref  = db.collection(selectText).doc();

    String id = ref.id;

     db.collection(selectText).doc(id).set({
       'id':id,
       'pergunta' : _controllerQuestion.text,
       'resposta' : _controllerAnswer.text,
       'time' : DateTime.now()
     }).then((value){
       setState(() {
         AlertModel().alert('Sucesso!', 'Sua pergunta foi salva!',PaletteColor.green,PaletteColor.green,context,
         [
           ButtonCustom(
             onPressed: (){
               Navigator.pop(context);
               list=[];
               _allResults.clear();
               data(selectText);
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
         _controllerQuestion.clear();
         _controllerAnswer.clear();
       });
     });
  }
  _deleteQuestion(String id){

    db.collection(selectText).doc(id).delete().then((value){
      AlertModel().alert('Sucesso', 'Pergunta excluída com sucesso!', PaletteColor.green, PaletteColor.green,context,
      [
        ButtonCustom(
          onPressed: (){
            Navigator.pop(context);
            list=[];
            _allResults.clear();
            data(selectText);
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
      setState(() {
        list=[];
        _allResults=[];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    data(selectText);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: PaletteColor.greyLight,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 64.0, left: 64, bottom: 16),
              child: Container(
                width: width,
                child: TextCustom(
                  text: 'Cadastrar nova pergunta',
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
                  padding: EdgeInsets.symmetric( vertical: 12),
                  width: width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Fala Pescador'),
                              value: 1,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'fala';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Onde trabalho'),
                              value: 2,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'trabalho';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Eu, pescador(a)'),
                              value: 3,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'pescador';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Meus direitos'),
                              value: 4,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'direitos';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.2,
                            child: RadioListTile(
                              title: Text('Meus deveres'),
                              value: 5,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'deveres';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextCustom(
                        text: 'Pergunta',
                        size: 14.0,
                      ),
                      Input(
                        controller: _controllerQuestion,
                        hint: 'Pergunta',
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width * 0.65,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      SizedBox(height: 20),
                      TextCustom(
                        text: 'Resposta',
                        size: 14.0,
                      ),
                      Input(
                        controller: _controllerAnswer,
                        hint: 'Resposta',
                        fontSize: 14.0,
                        keyboardType: TextInputType.number,
                        width: width * 0.65,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      SizedBox(height: 50),
                      ButtonCustom(
                          onPressed: () {
                              if(_controllerQuestion.text.isNotEmpty && _controllerAnswer.text.isNotEmpty){
                                _saveQuestion();
                              }else{
                                AlertModel().alert('Erro !','Preencha os campos Pergunta e Resposta para salvar.',PaletteColor.red,PaletteColor.red,context,
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
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 64, bottom: 16),
              child: Container(
                width: width,
                child: TextCustom(
                  text: 'Perguntas cadastradas',
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
                  padding: EdgeInsets.symmetric( vertical: 12),
                  width: width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Fala Pescador'),
                              value: 1,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'fala';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Onde trabalho'),
                              value: 2,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'trabalho';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Eu, pescador(a)'),
                              value: 3,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'pescador';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: RadioListTile(
                              title: Text('Meus direitos'),
                              value: 4,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'direitos';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.2,
                            child: RadioListTile(
                              title: Text('Meus deveres'),
                              value: 5,
                              groupValue: select,
                              activeColor: PaletteColor.primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  select = val as int;
                                  list=[];
                                  _allResults.clear();
                                  selectText = 'deveres';
                                  data(selectText);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: height*0.25,
                        child: ListView.builder(
                          itemCount: _allResults.length,
                          itemBuilder:(context,index){

                            DocumentSnapshot item = _allResults[index];

                            if(_allResults.length == 0){
                              return Center(
                                  child: Text('Nenhuma pergunta encontrada dessa categoria',
                                    style: TextStyle(fontSize: 16,color: PaletteColor.primaryColor),)
                              );
                            }else{
                              list.add(
                                  QuestionModel(
                                      answer: item['resposta'],
                                      question: item['pergunta'],
                                      showQuestion: false
                                  )
                              );

                              return ContainerQuestion(
                                  question: list[index].question,
                                  answer: list[index].answer,
                                  onPressedShow: (){
                                    setState(() {
                                      list[index].showQuestion?list[index].showQuestion=false:list[index].showQuestion=true;
                                    });
                                  },
                                  onPressedDelete: (){
                                    _deleteQuestion(item['id']);
                                  },
                                  showQuestion: list[index].showQuestion
                              );
                            }
                          }
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ));
  }
}
