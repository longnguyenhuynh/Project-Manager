import 'package:flutter/material.dart';

class ActiveProjectsCard extends StatelessWidget {
  var data;
  final Color cardColor;
  final String title;
  final String subtitle;

  ActiveProjectsCard({
    this.data,
    this.cardColor,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(15.0),
        height: 80,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: Colors.black54,
                    width: 15.0,
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
