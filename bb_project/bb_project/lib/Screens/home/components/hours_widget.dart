import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HoursWidget extends StatelessWidget {
  const HoursWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      buildButton(context, 'Total Hours', '40 hrs 0 min')
    ]);
  }

  Widget buildButton(BuildContext context, String hours, String values) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            hours,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 2),
          Text(values, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
