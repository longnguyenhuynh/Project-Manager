import 'package:flutter/material.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/active_project_card.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/Screens/Task/create_new_task_page.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:project_manager/Screens/Admin/admin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Task'),
                              Row(children: <Widget>[
                                Container(
                                  height: 40.0,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: kGreen,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateNewTaskPage(),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Add task',
                                        style: TextStyle(
                                            color: kPrimaryLightColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          // Database
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: kDarkYellow,
                                title: 'Medical App',
                                subtitle: '9 hours left',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: kGreen,
                                title: 'Making History Notes',
                                subtitle: '20 hours left',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: kRed,
                                title: 'Sports App',
                                subtitle: '5 hours left',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: kBlue,
                                title: 'Online Flutter Course',
                                subtitle: '23 hours left',
                              ),
                            ],
                          ),
                        ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                      if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectPage()),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage()),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
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
}
