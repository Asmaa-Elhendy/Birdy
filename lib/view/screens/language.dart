import 'package:flutter/material.dart';


class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Language",
          style: TextStyle(
              color: Colors.white,  fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xfff79281),
      ),
      body: Column(

        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                      0.03,
                  right: MediaQuery.of(context).size.width * 0.035,
                  left: MediaQuery.of(context).size.width * 0.035),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.language,
                          color: Colors.black,
                        )
                    ),
                    title: Text("English"),

                  )
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                    0.03,
                right: MediaQuery.of(context).size.width * 0.035,
                left: MediaQuery.of(context).size.width * 0.035),
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.language,
                        color: Colors.black,
                      )
                  ),
                  title: Text("Arabic"),

                )
            ),
          )
        ],
      ),
    );
  }
}