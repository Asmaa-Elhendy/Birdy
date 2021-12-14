import 'package:flutter/material.dart';

class Snack {
 static  SNackbarfun(BuildContext context, function) {
    return SnackBar(content: Text('Are you sure to delete ?'),
      action: SnackBarAction(
        label: 'YES',textColor: Color(0xfff79281),
        onPressed:function,
      ),
    );
  }

}