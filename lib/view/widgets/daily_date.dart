import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DailyDate extends StatefulWidget {
  const DailyDate({Key? key}) : super(key: key);

  @override
  _DailyDateState createState() => _DailyDateState();
}

class _DailyDateState extends State<DailyDate> {
  var _selectedValue;
  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double hight=MediaQuery.of(context).size.height;

    return Padding(
        padding:  EdgeInsets.all(hight*.02),
        child:
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,// Color(0xfff79281),
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;

                });

              },
            ),


    );
  }
}
