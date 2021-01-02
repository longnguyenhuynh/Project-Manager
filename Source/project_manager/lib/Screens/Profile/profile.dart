import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/my_text_field.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Text("Email"),
                  SizedBox(
                    height: 4,
                  ),
                  MyTextField(initValue: "ABC", label: 'Name'),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Address"),
                  SizedBox(
                    height: 4,
                  ),
                  MyTextField(label: 'Name'),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Phone number"),
                  SizedBox(
                    height: 4,
                  ),
                  MyTextField(label: 'Name'),
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
                  duration: Duration(milliseconds: 800),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.lightbulb,
                      text: 'Project',
                    ),
                    GButton(
                      icon: Icons.calendar_today,
                      text: 'Calendar',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
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
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProjectPage()),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarPage()),
                      );
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

final String url =
    "http://chuteirafc.cartacapital.com.br/wp-content/uploads/2018/12/15347041965884.jpg";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 220);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: kPrimaryColor, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Milan Short",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Role",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "Employee",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Department",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "IT",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Salary",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "4",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Projects Count",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "20",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                SizedBox(
                  width: 32,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Tasks Count",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("50",
                        style: TextStyle(color: Colors.white, fontSize: 24))
                  ],
                ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  print("//TODO: button clicked");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Container(
                    width: 110,
                    height: 32,
                    child: Center(
                      child: Text("Save Profile"),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 20)
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
