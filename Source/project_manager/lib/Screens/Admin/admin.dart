import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_manager/Screens/Admin/viewProfile.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
//import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  final int id;
  AdminPage({Key key, this.id}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int selectedIndex = 4;
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  List employees;

  getMethod() async {
    String url = "https://phuidatabase.000webhostapp.com/getEmployee.php";
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    return body;
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  ImageProvider getProfilePicture(dynamic info) {
    if (info['ProfilePhotoLink'] == "" || info['ProfilePhotoLink'] == null)
      return AssetImage('assets/images/avatar.png');
    else
      return NetworkImage(info['ProfilePhotoLink']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.blueGrey[300],
                      padding: EdgeInsets.only(top: 0),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: FutureBuilder(
                        future: getMethod(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (employees != null) {
                            return ListView.builder(
                              itemCount: employees.length,
                              itemBuilder: (context, index) {
                                return buildList(context, index, employees);
                              },
                            );
                          }
                          employees = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              return buildList(context, index, employees);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProjectPage(id: widget.id)),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage(id: widget.id)),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index, List employees) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewProfilePage(id: widget.id, info: employees[index])),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          width: double.infinity,
          height: 110,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 3, color: Colors.blueGrey),
                  image:
                      DecorationImage(image: getProfilePicture(employees[index]), fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name:  " +
                          employees[index]['FirstName'] +
                          ' ' +
                          employees[index]['LastName'],
                      style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text("Role:  " + employees[index]['role'],
                        style: TextStyle(color: primary, fontSize: 17)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Salary:  " + employees[index]['Salary'],
                        style: TextStyle(color: primary, fontSize: 17)),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ));
  }
}
