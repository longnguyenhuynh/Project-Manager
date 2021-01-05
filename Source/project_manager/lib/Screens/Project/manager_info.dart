import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/Screens/Admin/admin.dart';
import 'package:http/http.dart' as http;

class ManagerPage extends StatefulWidget {
  final int id;
  final int manager;
  ManagerPage({Key key, this.id, this.manager}) : super(key: key);

  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  var info;
  int selectedIndex = 1;

  getProfileMethod() async {
    String url = "https://phuidatabase.000webhostapp.com/getUserData.php";
    print("hello");
    int queryID = widget.manager;
    var requestUrl = url + '?id=' + queryID.toString();
    var res = await http.get(Uri.encodeFull(requestUrl), headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    var info = body[0];
    print(info);
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: 0),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: getProfileMethod(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (info != null) return buildProfile(info);
                          info = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return buildProfile(info);
                        }))),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(.20),
                  offset: Offset(0, 15))
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: GNav(
                  gap: 8,
                  color: Colors.grey[800],
                  activeColor: kPrimaryColor,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                    ),
                    GButton(
                      icon: Icons.lightbulb,
                    ),
                    GButton(
                      icon: Icons.calendar_today,
                    ),
                    GButton(
                      icon: Icons.person,
                    ),
                    GButton(
                      icon: Icons.star,
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(id: widget.id)),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarPage(id: widget.id)),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage(id: widget.id)),
                      );
                    } else if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminPage(id: widget.id)),
                      );
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  Container profilePicture(dynamic info) {
    if (info['ProfilePhotoLink'] == "" || info['ProfilePhotoLink'] == null)
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image:
                DecorationImage(image: AssetImage('assets/images/avatar.png'), fit: BoxFit.cover)),
        margin: EdgeInsets.only(left: 16.0),
      );
    else {
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image:
                DecorationImage(image: NetworkImage(info['ProfilePhotoLink']), fit: BoxFit.cover)),
        margin: EdgeInsets.only(left: 16.0),
      );
    }
  }

  Widget buildProfile(dynamic info) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 130.0, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  info['LastName'] +
                                      ' ' +
                                      info['MiddleName'] +
                                      ' ' +
                                      info['FirstName'],
                                  style: TextStyle(fontSize: 25, color: kBlue),
                                ),
                                Divider(),
                                Text(info['role'], style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    profilePicture(info),
                  ],
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        SizedBox(width: 15.0),
                        Text("USER INFORMATION",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kBlue)),
                        SizedBox(width: 90.0),
                      ]),
                      SizedBox(height: 5.0),
                      Divider(),
                      Visibility(
                        visible: true,
                        child: Column(children: <Widget>[
                          ListTile(
                            title: Text(info['Email'], style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.email),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info["PhoneNumber"], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.phone),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info['Address'], style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.location_on_rounded),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info['Salary'], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.attach_money),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
