import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_manager/Screens/Calendar/calendar_page.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Profile/profile.dart';
import 'package:project_manager/components/back_button.dart';
import 'package:project_manager/components/google_nav_bar.dart';
import 'package:project_manager/components/rounded_button.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/Screens/Admin/admin.dart';
import 'package:http/http.dart' as http;

class ContractPage extends StatefulWidget {
  final int id;
  final int contract;
  final String name;
  ContractPage({Key key, this.id, this.contract, this.name}) : super(key: key);

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  var info;
  int selectedIndex = 1;

  getContract() async {
    String url = "https://phuidatabase.000webhostapp.com/getContractData.php";
    int queryID = widget.contract;
    var requestUrl = url + '?ID=' + queryID.toString();
    var res = await http.get(Uri.encodeFull(requestUrl), headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    print(body);
    if (body.length == 0) return 0;
    print("Still running");
    var info = body[0];
    return info;
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
                          future: getContract(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            //if (info != null) return buildProfile(info);
                            info = snapshot.data;
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (info == 0) return RoundedButton(text: "ADD Contract", press: () {});
                            return buildProfile(info);
                          }))),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 60,
                      color: Colors.black.withOpacity(.20),
                      offset: Offset(0, 15))
                ],
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
                                  widget.name,
                                  style: TextStyle(fontSize: 25, color: kBlue),
                                ),
                                Divider(),
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
                              image: AssetImage('assets/images/contract.png'), fit: BoxFit.cover)),
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
                        Text("CONTRACT INFORMATION",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kBlue)),
                        SizedBox(width: 30.0),
                      ]),
                      SizedBox(height: 5.0),
                      Divider(),
                      Visibility(
                        visible: true,
                        child: Column(children: <Widget>[
                          ListTile(
                            title: Text(info['des'], style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.check_box),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(info['value'], style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.attach_money),
                          ),
                          Divider(),
                          ListTile(
                            title:
                                Text("SignedTime: " + info['sign'], style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.calendar_today_rounded),
                          ),
                          ListTile(
                            title: Text("ExpiredTime: " + info['expired'],
                                style: TextStyle(fontSize: 20)),
                            leading: Icon(Icons.calendar_today_rounded),
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
