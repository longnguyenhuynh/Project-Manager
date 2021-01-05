import 'package:flutter/material.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/Screens/Task/task_page.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:project_manager/Screens/Admin/admin.dart';

class HomePage extends StatefulWidget {
  final int id;
  HomePage({Key key, this.id}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
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
              child: TaskPage(),
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
                      if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProjectPage(id: widget.id)),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage(
                                    id: widget.id,
                                  )),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    id: widget.id,
                                  )),
                        );
                      } else if (index == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminPage(
                                    id: widget.id,
                                  )),
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
