import 'package:flutter/material.dart';


enum TimeFragmentType {
  minite,
  hours
}

// ignore: must_be_immutable
class TimeFragment extends StatefulWidget {
  TimeFragmentType timeFragmentType;
  String time;
  TimeFragment({Key? key, required this.timeFragmentType,required this.time}) : super(key: key);

  @override
  State<TimeFragment> createState() => _TimeFragmentState();
}

class _TimeFragmentState extends State<TimeFragment> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context , BoxConstraints constraints) {
      const lineHoriHeight = 4.0;


      final lineVertiHeight = (constraints.maxHeight - lineHoriHeight) / 2;
      const lineVertiWidth = 4.0;
      final timeHeight = lineVertiHeight;

      return SizedBox(
        width: widget.timeFragmentType == TimeFragmentType.minite ? 50 : 75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: lineVertiHeight,
              width: lineVertiWidth,
              color: Colors.blue,
            ),
            Container(
              height: lineHoriHeight,
              color: Colors.blue,
            ),
            SizedBox(height: timeHeight, child: Text(widget.time),)
          ],
        ),
      );
    }
    );
  }
}




