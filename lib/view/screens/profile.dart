import 'package:birdy_app/view/screens/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // var usrename;
  // bool islogin = false;
  // getPref() async{
  //   SharedPreferences  pref = await SharedPreferences.getInstance();
  //   usrename = pref.getString("email");
  //   if(usrename != null){
  //     setState(() {
  //       usrename = pref.getString("email");
  //       islogin = true;
  //     });
  //   }
  // }
  @override
  // void initState() {
  //  getPref();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  right: MediaQuery.of(context).size.width * 0.035,
                  left: MediaQuery.of(context).size.width * 0.035),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.21,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    //top: MediaQuery.of(context).size.height*0.0001,
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 42.0,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      Container(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 28,
                              ),
                              Text(
                                "Tasneem elattar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "tasneem@gmail.com",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal, fontSize: 15),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3 ,
                                child: ElevatedButton(
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xfff79281),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                color: Color(0xfff79281),
                                              )))),
                                  onPressed: () {},
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.035,
                    left: MediaQuery.of(context).size.width * 0.035),
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.height * 0.034),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Option",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Notification",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                iconSize: 15,
                                onPressed: () {}),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Language",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                iconSize: 15,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Language()),
                                  );
                                }),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          "Account",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Personal Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                iconSize: 15,
                                onPressed: () {}),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        Center(
                            child: ElevatedButton(
                              child: Text(
                                "logout",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    Color(0xfff79281),
                                  ),
                                  shape: MaterialStateProperty
                                      .all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: BorderSide(
                                            color: Color(0xfff79281),
                                          )))),
                              onPressed: () {},
                            ))
                      ],
                    ),

                ))
          ],
        ),
      ),
    );
  }
}