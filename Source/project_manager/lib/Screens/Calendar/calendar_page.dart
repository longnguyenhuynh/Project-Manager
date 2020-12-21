import 'package:flutter/material.dart';
import 'package:project_manager/constants.dart';
import 'package:project_manager/components/calendar_dates.dart';
import 'package:project_manager/components/task_container.dart';
import 'package:project_manager/components/back_button.dart';
import 'package:calendar_time/calendar_time.dart';

class CalendarPage extends StatelessWidget {
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              MyBackButton(),
              SizedBox(height: 30.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  CalendarTime(DateTime.now()).format("MMMM, dd"),
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 58.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CalendarDates(
                      day: days[index],
                      date: dates[index],
                      dayColor: index == 0 ? kRed : Colors.black54,
                      dateColor: index == 0 ? kRed : kDarkBlue,
                    );
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: time.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${time[index]} ${time[index] > 8 ? 'PM' : 'AM'}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              _dashedText(),
                              TaskContainer(
                                title: 'Project Research',
                                subtitle:
                                    'Discuss with the colleagues about the future plan',
                                boxColor: kLightYellow2,
                              ),
                              _dashedText(),
                              TaskContainer(
                                title: 'Work on Medical App',
                                subtitle: 'Add medicine tab',
                                boxColor: kLavender,
                              ),
                              TaskContainer(
                                title: 'Call',
                                subtitle: 'Call to david',
                                boxColor: kPalePink,
                              ),
                              TaskContainer(
                                title: 'Design Meeting',
                                subtitle:
                                    'Discuss with designers for new task for the medical app',
                                boxColor: kLightGreen,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
