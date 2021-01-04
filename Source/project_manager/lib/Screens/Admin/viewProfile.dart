import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:project_manager/Screens/Admin/admin.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:project_manager/components/rounded_button.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
//import 'package:project_manager/Screens/Project/project_page.dart';
import 'package:http/http.dart' as http;

class ViewProfilePage extends StatefulWidget {
  final int id;
  final dynamic info;
  ViewProfilePage({Key key, this.id, this.info}) : super(key: key);

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  int selectedIndex = 4;
  bool edit = false;
  String tempUserName = "";
  String tempPassWord = "";
  String tempRole = "";
  String tempSalary = "";

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
                    child: buildProfile(widget.info))),
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

  deleteUser(String id) async {
    String url = "https://phuidatabase.000webhostapp.com/deleteEmployee.php";
    var requestUrl = url + '?' + "ID=" + id;
    http.Response response = await http.get(requestUrl);
    print(requestUrl);
    var data = response.body;
    print(data);
    return data;
  }

  updateEmployee(
      String nationalID, String userName, String password, String role, String salary) async {
    String url = "https://phuidatabase.000webhostapp.com/updateEmploy.php";
    Map<String, String> profileInfo = {
      'ID': nationalID,
      'userName': userName,
      'password': password,
      'role': role,
      'Salary': salary
    };
    String queryString = Uri(queryParameters: profileInfo).query;
    var requestUrl = url + '?' + queryString;
    http.Response response = await http.get(requestUrl);
    var data = response.body;
    return data;
  }

  postMethod(String email, String phone, String address) async {
    String url = "https://phuidatabase.000webhostapp.com/editProfile.php";
    Map<String, String> profileInfo = {
      'ID': widget.id.toString(),
      'Email': email,
      'PhoneNumber': phone,
      'Address': address
    };
    String queryString = Uri(queryParameters: profileInfo).query;
    var requestUrl = url + '?' + queryString;

    http.Response response = await http.get(requestUrl);
    var data = response.body;
    return data;
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
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                        ),
                        Text("Edit"),
                      ]),
                      SizedBox(height: 5.0),
                      Divider(),
                      Visibility(
                        visible: !edit,
                        child: Column(children: <Widget>[
                          ListTile(
                            title: Text(info["userName"], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.account_circle_rounded),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info["password"], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.lock),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info["role"], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.assignment_ind_rounded),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info['Salary'], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.attach_money),
                          ),
                          RoundedButton(
                              text: "DELETE",
                              press: () {
                                showLoadingDialog();
                                deleteUser(info['NationalID']);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    hideLoadingDialog();
                                    return AdminPage(id: widget.id);
                                  },
                                ));
                              })
                        ]),
                      ),
                      Visibility(
                        visible: edit,
                        child: Column(children: <Widget>[
                          ListTile(
                            title: TextFormField(
                              initialValue: info['userName'],
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                tempUserName = text;
                              },
                            ),
                            leading: Icon(Icons.account_circle_rounded),
                          ),
                          Divider(),
                          ListTile(
                            title: TextFormField(
                              initialValue: info['password'],
                              onChanged: (text) {
                                tempPassWord = text;
                              },
                              style: TextStyle(fontSize: 20),
                            ),
                            leading: Icon(Icons.lock),
                          ),
                          Divider(),
                          ListTile(
                            title: TextFormField(
                              initialValue: info['role'],
                              onChanged: (text) {
                                tempRole = text;
                              },
                              style: TextStyle(fontSize: 18),
                            ),
                            leading: Icon(Icons.assignment_ind_rounded),
                          ),
                          Divider(),
                          ListTile(
                            title: TextFormField(
                              initialValue: info['Salary'],
                              onChanged: (text) {
                                tempSalary = text;
                              },
                              style: TextStyle(fontSize: 18),
                            ),
                            leading: Icon(Icons.attach_money),
                          ),
                          RoundedButton(
                              text: "SAVE",
                              press: () {
                                if (tempUserName == "") tempUserName = info['userName'];
                                if (tempPassWord == "") tempPassWord = info['password'];
                                if (tempRole == "") tempRole = info['role'];
                                if (tempSalary == "") tempSalary = info['Salary'];

                                showLoadingDialog();
                                updateEmployee(info['NationalID'], tempUserName, tempPassWord,
                                    tempRole, tempSalary);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    hideLoadingDialog();
                                    return AdminPage(id: widget.id);
                                  },
                                ));
                              })
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
