import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  String hint;
  //String?value;
  List<String> list;
  // double size;
  // TextEditingController controllerValue;

  DropDown(
      {Key? key,
        required this.hint,
        required this.list,
        //required this.value
      })
      : super(key: key);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
//var items =widget.List;
String?genderValue;
String?TypeValue;
String?breedValue;
String? roomValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.11
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).primaryColor),
        //color: Theme.of(context).primaryColor
        color: Color(0xfff79281).withOpacity(0.3),
      ),
      child: DropdownButton<String>(
        isExpanded: true,

        value: widget.hint=="gender"?genderValue:widget.hint=="Type"?TypeValue:widget.hint=="Breed"?breedValue:roomValue,
        //TypeValue:widget.hint=="Breed"?breedValue:TypeValue,
        hint: Text(widget.hint,
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
        icon: Icon(Icons.keyboard_arrow_down_rounded,


        //color: Theme.of(context).primaryColor,
        ),
          focusColor: Colors.purple,
        items: widget.list.map(buildMenuItem).toList(),
        onChanged: (value) {
          setState(() {

            if(widget.hint=="gender"){
              this.genderValue = value;
            }else if(widget.hint=="Type"){
              this.TypeValue = value;
            }else if(widget.hint=="Breed"){
              this.breedValue = value;
            }else{
              this.roomValue = value;
              print(roomValue);
            }
          });

        }

        // icon: Icon(Icons.keyboard_arrow_down_rounded,
        //   color: Theme.of(context).primaryColor,
        //
        //
        // ),
        // isExpanded: true,
        // //dropdownColor: Colors.white,
        // style: TextStyle(
        //   color:Theme.of(context).primaryColor,
        //   fontSize: 15,
        //
        //   //backgroundColor: Colors.white,
        // ),
        // value: '0',
        // items: [
        //   DropdownMenuItem(child: Text(
        //       'women',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: Theme.of(context).primaryColor,
        //       fontSize: 18
        //     ),
        //
        //   ), value: '0'),
        //   DropdownMenuItem(child: Text('man'), value: '1'),
        // ],
      ),
    );
    /*
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor),
         //color: Theme.of(context).primaryColor
           color: Color(0xfff79281).withOpacity(0.3),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon:  Icon(Icons.keyboard_arrow_down_rounded,


        ),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Theme.of(context).primaryColor,

        ),
        // underline: Container(
        //   height: 2,
        //   color: Colors.deepPurpleAccent,
        // ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['women','men']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
                value,
              textAlign: TextAlign.center,
            ),
          );
        })
            .toList(),
      ),
    );

     */
  }
DropdownMenuItem<String> buildMenuItem(String item){
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),
      ),

    );
}

}
