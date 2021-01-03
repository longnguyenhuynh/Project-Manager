import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:http/http.dart' as http;
import 'package:project_manager/Screens/Admin/admin.dart';

class ProjectPage extends StatefulWidget {
  @override
  ProjectPage({Key key}) : super(key: key);
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  int selectedIndex = 1;
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  List projectList;

  getMethod() async {
    String url = "https://phuidatabase.000webhostapp.com/project.php";
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
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextField(
                          // controller: TextEditingController(text: locations[0]),
                          cursorColor: Theme.of(context).primaryColor,
                          style: dropdownMenuItem,
                          decoration: InputDecoration(
                              hintText: "Search Project",
                              hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: FutureBuilder(
                        future: getMethod(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (projectList != null) {
                            return ListView.builder(
                              itemCount: projectList.length,
                              itemBuilder: (context, index) {
                                return buildList(context, index, projectList);
                              },
                            );
                          }
                          projectList = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: projectList.length,
                            itemBuilder: (context, index) {
                              return buildList(context, index, projectList);
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
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalendarPage()),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      } else if (index == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminPage()),
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

  Widget buildList(BuildContext context, int index, List projectList) {
    return Container(
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
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(50),
            //   border: Border.all(width: 3, color: secondary),
            //   image: DecorationImage(
            //       //image: NetworkImage(schoolLists[index]['logoText']),
            //       fit: BoxFit.fill),
            // ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Project Name:  " + projectList[index]['name'],
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(projectList[index]['id'],
                        style: TextStyle(color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
