// the card containers
import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  ReuseableCard({@required this.colour, this.widgetChild, this.genderTapped});

  final Color colour;
  final Widget widgetChild;
  final Function genderTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: genderTapped,
      child: Container(
        child: widgetChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
