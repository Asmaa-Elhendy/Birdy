import 'package:birdy_app/controller/providers/weekdays_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

class CustomWeekdaySelector extends StatefulWidget {
 String task_name;
 CustomWeekdaySelector({required this.task_name});

  @override
  _CustomWeekdaySelectorState createState() => _CustomWeekdaySelectorState();
}

class _CustomWeekdaySelectorState extends State<CustomWeekdaySelector> {
  final values = List.filled(7, true);

  @override
  Widget build(BuildContext context) {
    Weekdays weekdayProvider =Provider.of<Weekdays>(context);
    return WeekdaySelector(
      selectedFillColor: Color(0xfff79281),
      onChanged: (int day) {
        setState(() {

          final index = day % 7;

          values[index] = !values[index];
        });
       if(widget.task_name=='cleaning'){
         weekdayProvider.addcleaning(values);
         print('cleaning ${weekdayProvider.cleaning_list}');
       }else if (widget.task_name=='feeding'){
         weekdayProvider.addfeeding(values);
         print('feeding ${weekdayProvider.feeding_list}');
       }else if (widget.task_name=='watering'){
         weekdayProvider.addwatering(values);
         print('watering ${weekdayProvider.watering_list}');
       }
      },
      values: values,
    );
  }
}
