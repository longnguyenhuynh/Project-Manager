import 'package:flutter/material.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/active_project_card.dart';
import 'package:project_manager/Screens/Task/create_new_task_page.dart';
import 'package:project_manager/Screens/Task/task_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Map<String, Color> priority = {
  'Low': kGreen,
  'Med': kBlue,
  'High': kDarkYellow,
  'Critical': kRed
};

Widget taskTemplate(data, context) {
  return FlatButton(
      onPressed: () {
        _openTaskInfo(context, data);
        TaskPage.setState();
      },
      child: ActiveProjectsCard(
        data: data,
        cardColor: priority[data['Priority']],
        title: data['TaskName'],
        subtitle: data['_Status'],
      ));
}

void _openTaskInfo(BuildContext context, data) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TaskInfo(
                data: data,
              )));
}

getData() async {
  var url = 'https://phuidatabase.000webhostapp.com/getTaskData.php';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

class TaskPage extends StatefulWidget {
  static void setState() {
    setState();
  }

  @override
  _CreateTaskPage createState() => _CreateTaskPage();
}

class _CreateTaskPage extends State<TaskPage> {
  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
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

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                                builder: (context) => CreateNewTaskPage(),
                              ),
                            );
                            TaskPage.setState();
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
            child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List snap = snapshot.data;
                  print(snap);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching data'),
                    );
                  }
                  return Column(
                    children:
                        snap.map((x) => taskTemplate(x, context)).toList(),
                  );
                }),
          ),
          Container(
              child: IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.adjust_rounded),
          ))
        ],
      ),
    );
  }
}
