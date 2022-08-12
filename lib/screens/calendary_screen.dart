import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../models/alert_model.dart';
import '../utils/colors.dart';
import '../widgets/buttom_custom.dart';
import '../widgets/input.dart';
import '../widgets/text_custom.dart';

class CalendaryScreen extends StatefulWidget {
  const CalendaryScreen({Key? key}) : super(key: key);

  @override
  State<CalendaryScreen> createState() => _CalendaryScreenState();
}

class _CalendaryScreenState extends State<CalendaryScreen> {

  DateTime _currentDate = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  var _controllerDay=TextEditingController(text: DateFormat.d().format(DateTime.now()));
  var _controllerMonth=TextEditingController(text: DateFormat.M().format(DateTime.now()));
  var _controllerYear=TextEditingController(text: DateFormat.y().format(DateTime.now()));
  var _controllerTitle=TextEditingController();
  var _controllerDescription=TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  _saveQuestion()async{

    DocumentReference ref  = db.collection('calendary').doc();

    String id = ref.id;

    db.collection('calendary').doc(id).set({
      'id':id,
      'day' : _controllerDay.text,
      'month' : _controllerMonth.text,
      'year' : _controllerYear.text,
      'title' : _controllerTitle.text,
      'description' : _controllerDescription.text,
      'target' : _targetDateTime,
      'time' : DateTime.now()
    }).then((value){
      setState(() {
        AlertModel().alert('Sucesso!', 'Nova data foi salva!',PaletteColor.green,PaletteColor.grey,context,
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
        _controllerTitle.clear();
        _controllerDescription.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting();

    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;

    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      weekdayTextStyle: TextStyle(color: PaletteColor.blueTitle,fontSize: 0),
      daysTextStyle: TextStyle(color: PaletteColor.blueTitle),
      selectedDayButtonColor: PaletteColor.blueTitle,
      weekendTextStyle: TextStyle(
        color: Colors.green,fontSize: 15
      ),
      markedDatesMap: _markedDateMap,
      targetDateTime: _targetDateTime,
      markedDateCustomTextStyle: TextStyle(
        fontSize: 15,
        color: Colors.blue,
      ),
      selectedDateTime: _targetDateTime,
      markedDateMoreShowTotal: null,
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      //markedDateShowIcon: true,
      todayButtonColor: PaletteColor.green,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      onDayPressed: (date,event){
        setState(() {
          _targetDateTime = date;
          _controllerDay.text = DateFormat.d().format(_targetDateTime);
          _controllerMonth.text = DateFormat.M().format(_targetDateTime);
          _controllerYear.text = DateFormat.y().format(_targetDateTime);
        });
      },
      markedDateIconBuilder: (event){
        return event.icon;
      },
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: PaletteColor.greyLight,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: height*0.2),
            height: height*0.05,
            width: width*0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: PaletteColor.greyLight,
                      elevation: 0
                  ),
                  icon: Icon(Icons.arrow_back_ios,color: PaletteColor.green,),
                  label: Text(''),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                ),
                Text(
                  DateFormat(DateFormat.MONTH, 'pt_BR').format(_targetDateTime.toUtc()).toUpperCase()
                      +" "+ DateFormat(DateFormat.YEAR, ).format(_targetDateTime.toUtc()).toUpperCase(),
                  style: TextStyle(color: PaletteColor.green),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: PaletteColor.greyLight,
                      elevation: 0
                  ),
                  icon: Icon(Icons.arrow_forward_ios,color: PaletteColor.green),
                  label: Text(''),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: width*0.2,
            height: height*0.3,
            child: _calendarCarouselNoHeader,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 95, bottom: 16),
            child: Container(
              width: width,
              child: TextCustom(
                text: 'Cadastrar nova data',
                size: 24.0,
                fontWeight: FontWeight.bold,
                color: PaletteColor.grey,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextCustom(
                      text: 'Data',
                      size: 14.0,
                      color:  PaletteColor.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Input(
                        controller: _controllerDay,
                        hint: '00',
                        enable: false,
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width*0.05,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      TextCustom(
                        text: '/',
                        size: 14.0,
                        color:  PaletteColor.grey,
                      ),
                      Input(
                        controller: _controllerMonth,
                        hint: '00',
                        enable: false,
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width*0.05,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                      TextCustom(
                        text: '/',
                        size: 14.0,
                        color:  PaletteColor.grey,
                      ),
                      Input(
                        controller: _controllerYear,
                        hint: '00',
                        enable: false,
                        fontSize: 14.0,
                        keyboardType: TextInputType.text,
                        width: width*0.05,
                        colorBorder: PaletteColor.greyLight,
                        background: PaletteColor.greyLight,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextCustom(
                      text: 'Título',
                      size: 14.0,
                      color:  PaletteColor.grey,
                    ),
                  ),
                  Input(
                    controller: _controllerTitle,
                    hint: 'Título',
                    fontSize: 14.0,
                    keyboardType: TextInputType.text,
                    width: width,
                    colorBorder: PaletteColor.greyLight,
                    background: PaletteColor.greyLight,
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextCustom(
                      text: 'Descrição',
                      size: 14.0,
                      color:  PaletteColor.grey,
                    ),
                  ),
                  Input(
                    controller: _controllerDescription,
                    hint: 'Descrição',
                    fontSize: 14.0,
                    keyboardType: TextInputType.text,
                    width: width,
                    colorBorder: PaletteColor.greyLight,
                    background: PaletteColor.greyLight,
                  ),
                  ButtonCustom(
                      onPressed: () {
                        if(_controllerDay.text.isNotEmpty && _controllerMonth.text.isNotEmpty
                            && _controllerYear.text.isNotEmpty && _controllerTitle.text.isNotEmpty && _controllerDescription.text.isNotEmpty){
                          _saveQuestion();
                        }else{
                          AlertModel().alert('Erro !','Preencha todos campos para salvar a nova data.',PaletteColor.red,PaletteColor.red,context,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
