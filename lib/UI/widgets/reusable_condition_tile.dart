import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReusableConditionTile extends StatelessWidget {
  bool isvalid;
  String txt;
  ReusableConditionTile({super.key,required this.isvalid,required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(
        isvalid? Icons.check_circle : Icons.cancel,
        color: isvalid? Colors.blue : Colors.white54,  
        ),
        SizedBox(width: 10,),
        Text(
          txt,
          style: TextStyle(
            fontFamily: "button",
            fontSize: 14,
            color: Colors.white
          ),
        )
      ],
    ),
    );
  }
}
