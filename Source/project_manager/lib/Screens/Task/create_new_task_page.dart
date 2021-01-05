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

Map<String, Color> priority = {
  'Low': kGreen,
  'Med': kBlue,
  'High': kDarkYellow,
  'Critical': kRed
};
Map<Color, String> revPriority = {
  kGreen: 'Low',
  kBlue: 'Med',
  kDarkYellow: 'High',
  kRed: 'Critical'
};

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

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  List _assignTo;
  int _value;
  TextEditingController _taskName = TextEditingController();
  TextEditingController _pID = TextEditingController();
  TextEditingController _storyName = TextEditingController();
  TextEditingController _epicName = TextEditingController();
  TextEditingController _startTime = TextEditingController();
  TextEditingController _endTime = TextEditingController();
  TextEditingController _description = TextEditingController();
  String get pid => _pID.text;
  String get taskName => _taskName.text;
  String get storyName => _storyName.text;
  String get epicName => _epicName.text;
  String get startTime => _startTime.text;
  String get endTime => _endTime.text;
  String get description => _description.text;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'New task',
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
                          child: TextFormField(
                        controller: _taskName,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            labelText: "Task Name",
                            labelStyle: TextStyle(color: Colors.black45),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      )),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _pID,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              labelText: "PID:",
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        controller: _epicName,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            labelText: "Epic Name",
                            labelStyle: TextStyle(color: Colors.black45),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      )),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _storyName,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              labelText: "Story Name",
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _startTime,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              labelText: "Start Time",
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _endTime,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              labelText: "End Time",
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _description,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black45),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
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
                              _assignTo = value;
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
                              _value = selected ? index : 0;
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                  FlatButton(
                    onPressed: () {
                      print("Pressed");
                      insertMethod(_assignTo[0]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: width * 0.8,
                      child: Text(
                        'Create Task',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  insertMethod(x) async {
    print("inserting");
    var data = {
      'PID': pid,
      'taskName': taskName,
      'epicName': epicName,
      'storyName': storyName,
      'Description': description,
      '_Status': "Not Start",
      'Priority': _priority[_value].name,
      'StartTime': startTime,
      'ManagerID': x,
      'EndTime': endTime,
    };
    print(data);
    String url = "https://phuidatabase.000webhostapp.com/addTask.php";
    var res = await http.post(url, body: data);
    var resBody = json.decode(res.body);
    print(resBody);
  }
}
