import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReusableConditionTile extends StatelessWidget {
  bool isvalid;
  String txt;
  ReusableConditionTile({super.key,required this.isvalid,required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(bottom: context.rs(10)),
    child: Row(
      children: [
        Icon(
        isvalid? Icons.check_circle : Icons.cancel,
        color: isvalid? Colors.blue : Colors.white54,
        size: context.rs(24),
        ),
        SizedBox(width: context.rs(10),),
        Expanded(
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "button",
              fontSize: context.rf(14),
              color: Colors.white
            ),
          ),
        )
      ],
    ),
    );
  }
}
