import 'package:flutter/material.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/back_button.dart';
import 'package:project_manager/components/my_text_field.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Priority {
  const Priority(this.name, this.color);
  final String name;
  final Color color;
}

int _value = 1;

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
  @override
  Widget build(BuildContext context) {
    List _assignTo = [];

    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'New task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(label: 'Name'),
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        label: 'Start Time',
                        icon: downwardIcon,
                      )),
                      SizedBox(width: 20),
                      Expanded(
                        child: MyTextField(
                          label: 'End Time',
                          icon: downwardIcon,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    label: 'Description',
                  ),
                  SizedBox(height: 20),
                  MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: kPrimaryColor,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: kGreen,
                    checkBoxCheckColor: Colors.black,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Assign to",
                      style: TextStyle(fontSize: 18),
                    ),
                    //  Database
                    dataSource: [
                      {
                        "display": "Long",
                        "value": "Long",
                      },
                      {
                        "display": "Long Huynh",
                        "value": "Long Huynh",
                      },
                      {
                        "display": "Huynh Long",
                        "value": "Huynh Long",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
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
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Priority',
                    style: TextStyle(fontSize: 18),
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
                  )
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Create Task',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: kBlue,
                      borderRadius: BorderRadius.circular(30),
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
}
