import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/my_text_field.dart';
import 'package:project_manager/Screens/Admin/admin.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final int id;
  ProfilePage({Key key, this.id}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 3;

  getMethod() async {
    String url = "https://phuidatabase.000webhostapp.com/getUserData.php";
    int queryID = widget.id;
    var requestUrl = url + '?id=' + queryID.toString();
    var res = await http.get(Uri.encodeFull(requestUrl), headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    var info = body[0];
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 0),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: getMethod(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var info = snapshot.data;
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return buildProfile(info);
                      }))),
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
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProjectPage(id: widget.id)),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarPage(id: widget.id)),
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
    if (info['ProfilePhotoLink'] == "")
      return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image:
                DecorationImage(image: AssetImage('assets/images/avatar.png'), fit: BoxFit.cover)),
        margin: EdgeInsets.only(left: 16.0),
      );
    else {
      return Container(
        height: 80,
        width: 80,
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
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(top: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 96.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  info['LastName'] +
                                      ' ' +
                                      info['MiddleName'] +
                                      ' ' +
                                      info['FirstName'],
                                  style: Theme.of(context).textTheme.title,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(info['role']),
                                ),
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
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("User information"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Email"),
                        subtitle: Text(info['Email']),
                        leading: Icon(Icons.email),
                      ),
                      ListTile(
                        title: Text("Phone"),
                        subtitle: Text(info["PhoneNumber"]),
                        leading: Icon(Icons.phone),
                      ),
                      ListTile(
                        title: Text("Address"),
                        subtitle: Text(info['Address']),
                        leading: Icon(Icons.location_on_rounded),
                      ),
                      ListTile(
                        title: Text("Salary"),
                        subtitle: Text(info['Salary']),
                        leading: Icon(Icons.attach_money),
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
