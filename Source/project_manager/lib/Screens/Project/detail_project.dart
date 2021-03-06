import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:project_manager/Screens/Admin/admin.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Home/home_page.dart';

import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/Screens/Project/contract_page.dart';
import 'package:project_manager/Screens/Project/manager_info.dart';
import 'package:project_manager/components/google_nav_bar.dart';

import 'package:project_manager/components/rounded_button.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/back_button.dart';
import 'package:http/http.dart' as http;

class DetailProjectPage extends StatefulWidget {
  final int id;
  final int projectID;
  DetailProjectPage({Key key, this.id, this.projectID}) : super(key: key);

  @override
  _DetailProjectPageState createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  String tempDes = "";
  String tempTarget = "";
  String tempStatus = "";
  String tempExpense = "";
  String tempAccess = "";
  bool edit = false;
  var info;
  int selectedIndex = 1;

  getMethod() async {
    String url = "https://phuidatabase.000webhostapp.com/getDetailProjectData.php";
    int queryID = widget.projectID;
    var requestUrl = url + '?ID=' + queryID.toString();
    var res = await http.get(Uri.encodeFull(requestUrl), headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    var info = body[0];
    return info;
  }

  editProject(String des, String target, String expense, String access) async {
    //SỬA THÔNG TIN CHỖ NÀY
    String url = "https://phuidatabase.000webhostapp.com/editProject.php";
    Map<String, String> profileInfo = {
      'ID': widget.projectID.toString(),
      'des': des,
      'target': target,
      'expense': expense,
      'access': access
    };
    String queryString = Uri(queryParameters: profileInfo).query;
    var requestUrl = url + '?' + queryString;
    http.Response response = await http.get(requestUrl);
    var data = response.body;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: MyBackButton(),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(top: 0),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: FutureBuilder(
                          future: getMethod(),
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
          ],
        ),
      ),
    );
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
                                  info['name'],
                                  style: TextStyle(fontSize: 25, color: kBlue),
                                ),
                                Divider(),
                                Text(info['status'], style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: AssetImage('assets/images/project.png'), fit: BoxFit.cover)),
                      margin: EdgeInsets.only(left: 16.0),
                    )
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
                        Text("PROJECT INFORMATION",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kBlue)),
                        SizedBox(width: 30.0),
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
                            title: Text(info['des'], style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.check_box),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info["target"], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.control_camera_outlined),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info['expense'], style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.attach_money),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info['access'], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.lock),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("From: " + info['startTime'] + " To: " + info['endTime'],
                                style: TextStyle(fontSize: 15)),
                            leading: Icon(Icons.calendar_today_rounded),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManagerPage(
                                          id: widget.id, manager: int.parse(info['manager']))));
                            },
                            child: ListTile(
                              title: Text("Manager", style: TextStyle(fontSize: 20)),
                              leading: Icon(Icons.account_circle),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContractPage(
                                          id: widget.id,
                                          contract: widget.projectID,
                                          name: info['name'])));
                            },
                            child: ListTile(
                              title: Text("Contract", style: TextStyle(fontSize: 20)),
                              leading: Icon(Icons.account_circle),
                            ),
                          ),
                        ]),
                      ),
                      Visibility(
                        visible: edit,
                        child: Column(children: <Widget>[
                          ListTile(
                            title: TextFormField(
                              initialValue: info["des"],
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                tempDes = text;
                              },
                            ),
                            leading: Icon(Icons.check_box),
                          ),
                          Divider(),
                          ListTile(
                            title: TextFormField(
                              initialValue: info["target"],
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                tempTarget = text;
                              },
                            ),
                            leading: Icon(Icons.control_camera_outlined),
                          ),
                          Divider(),
                          ListTile(
                            title: TextFormField(
                              initialValue: info['expense'],
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                tempExpense = text;
                              },
                            ),
                            leading: Icon(Icons.attach_money),
                          ),
                          Divider(),
                          ListTile(
                            title: TextFormField(
                              initialValue: info['access'],
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                tempAccess = text;
                              },
                            ),
                            leading: Icon(Icons.lock),
                          ),
                          RoundedButton(
                              text: "SAVE",
                              press: () {
                                if (tempDes == "") tempDes = info['des'];
                                if (tempTarget == "") tempTarget = info['target'];
                                if (tempExpense == "") tempExpense = info['expense'];
                                if (tempAccess == "") tempAccess = info['access'];

                                showLoadingDialog();
                                editProject(
                                    tempDes, tempTarget, tempExpense, tempAccess); // GỌI LÊN SERVER
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    hideLoadingDialog();
                                    return DetailProjectPage(
                                        id: widget.id, projectID: widget.projectID);
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
