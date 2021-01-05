import 'package:flutter/material.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/back_button.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Priority {
  const Priority(this.name, this.color);
  final String name;
  final Color color;
}

Map<String, int> priority = {'Low': 0, 'Med': 1, 'High': 2, 'Critical': 3};
Map<int, String> revPriority = {0: 'Low', 1: 'Med', 2: 'High', 3: 'Critical'};

getData() async {
  var url = 'https://phuidatabase.000webhostapp.com/getManagerList.php';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

List<Priority> _priority = <Priority>[
  const Priority('Low', kGreen),
  const Priority('Med', kBlue),
  const Priority('High', kDarkYellow),
  const Priority('Critical', kRed),
];

class TaskInfo extends StatefulWidget {
  var data;
  TaskInfo({Key key, @required this.data}) : super(key: key);
  @override
  _TaskInfo createState() => _TaskInfo(data: data);
}

class _TaskInfo extends State<TaskInfo> {
  _TaskInfo({@required this.data});
  var data;
  List _assignTo;
  int _value;

  @override
  Widget build(BuildContext context) {
    _value = priority[data["Priority"]];
    _assignTo = [data["ManagerID"]];
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TASK INFORMATION',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 4,
                          child: Column(children: <Widget>[
                            Text(data["TaskName"],
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 25.0)),
                          ])),
                      Expanded(
                        flex: 4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "PID: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                data["PID"].toString(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20.0),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Epic Name: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                data["EpicName"],
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20.0),
                              ),
                            ]),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "StoryName: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                data["StoryName"],
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20.0),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: data["StartTime"],
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              labelText: "Start Time",
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                          onChanged: (text) {
                            data["StartTime"] = text;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          initialValue: data["EndTime"],
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              labelText: "End Time",
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                          onChanged: (text) {
                            data["EndTime"] = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: data["Description"],
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black45),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    onChanged: (text) {
                      data["Description"] = text;
                    },
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        List snap = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error fetching data'),
                          );
                        }
                        return MultiSelectFormField(
                          autovalidate: false,
                          chipBackGroundColor: kPrimaryColor,
                          chipLabelStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: kGreen,
                          checkBoxCheckColor: Colors.black,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: Text(
                            "Assign to",
                            style: TextStyle(fontSize: 18),
                          ),
                          //  Database
                          dataSource: snap,
                          textField: 'ManagerName',
                          valueField: 'ManagerID',
                          okButtonLabel: 'Confirm',
                          cancelButtonLabel: 'Cancel',
                          hintWidget: Text('Please choose one or more'),
                          initialValue: _assignTo,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              data["ManagerID"] = value[0];
                            });
                          },
                        );
                      }),
                  SizedBox(height: 10),
                  Text(
                    'Priority',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List<Widget>.generate(
                      4,
                      (int index) {
                        return ChoiceChip(
                          labelPadding: EdgeInsets.all(5.0),
                          avatar: CircleAvatar(
                            backgroundColor: Colors.grey.shade700,
                            child: Text(_priority[index].name[0].toUpperCase()),
                          ),
                          label: Text(
                            _priority[index].name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          elevation: 6.0,
                          backgroundColor: Colors.black38,
                          shadowColor: Colors.grey[60],
                          padding: EdgeInsets.all(6.0),
                          selected: _value == index,
                          selectedColor: _priority[index].color,
                          onSelected: (bool selected) {
                            setState(() {
                              data["Priority"] =
                                  revPriority[selected ? index : 0];
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                  Row(children: [
                    FlatButton(
                      onPressed: () {
                        removeMethod();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: width * 0.3,
                        child: Text(
                          'Remove Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        decoration: BoxDecoration(
                          color: kRed,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        updateMethod();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: width * 0.3,
                        child: Text(
                          'Update Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        decoration: BoxDecoration(
                          color: kBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  removeMethod() async {
    data["PID"] = data["PID"].toString();
    data["ManagerID"] = data["ManagerID"].toString();
    print(data);
    String url = "https://phuidatabase.000webhostapp.com/removeTask.php";
    var res = await http.post(url, body: data);
    var resBody = json.decode(res.body);
    print(resBody);
  }

  updateMethod() async {
    data["PID"] = data["PID"].toString();
    data["ManagerID"] = data["ManagerID"].toString();
    print(data);
    String url = "https://phuidatabase.000webhostapp.com/editTask.php";
    var res = await http.post(url, body: data);
    var resBody = json.decode(res.body);
    print(resBody);
  }
}
