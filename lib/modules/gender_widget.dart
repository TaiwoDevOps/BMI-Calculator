// for the Column card holding the icons and text
import 'package:flutter/material.dart';
import 'constants.dart';

const iconFontSize = 80.0;
const sizeBoxHeight = 15.0;

// The Gender selection Card Widget
class CustomCardWidget extends StatelessWidget {
  CustomCardWidget({@required this.gender, @required this.genderIcon});

  final String gender;
  final IconData genderIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          genderIcon,
          size: iconFontSize,
        ),
        SizedBox(
          height: sizeBoxHeight,
        ),
        Text(
          gender,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
