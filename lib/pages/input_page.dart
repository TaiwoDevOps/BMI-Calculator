import 'package:bmi_app/pages/result_page.dart';

import '../modules/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../modules/constants.dart';
import '../modules/bottom_buttom.dart';
import '../modules/rounded_bottom.dart';
import '../bmi_calculator.dart';
import '../modules/gender_widget.dart';

enum GenderChoice { male, female }

class InputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputpageState();
  }
}

class _InputpageState extends State<InputPage> {
  // This will help evaluate the gender selected by user but initial value is false (NONE)
  GenderChoice selectedGender;
  int height = 180;
  int weight = 60;
  int age = 23;
  String _text =
      'Your name'; // input a name field that you can hold later and return it
  TextEditingController _c;

  Future<String> createAlertDialog(BuildContext context) {
    _c = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            body: AlertDialog(
              title: Text('Enter Your name'),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
              content: TextField(
                controller: _c,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(_c.text.toString());
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // The Gender container
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReuseableCard(
                    genderTapped: () {
                      createAlertDialog(context).then((onValue) {
                        onValue = _c.text.toString();
                        setState(() {
                          selectedGender = GenderChoice.male;
                          _text = onValue;
                        });
                      });
                    },
                    widgetChild: CustomCardWidget(
                      genderIcon: FontAwesomeIcons.mars,
                      gender: selectedGender == GenderChoice.male
                          ? 'Mr $_text'
                          : 'Your name',
                    ),
                    colour: selectedGender == GenderChoice.male
                        ? kActiveCardColor
                        : kInActiveCardColor,
                  ),
                ),
                Expanded(
                  child: ReuseableCard(
                    genderTapped: () {
                      createAlertDialog(context).then((onValue) {
                        onValue = _c.text.toString();
                        setState(() {
                          selectedGender = GenderChoice.female;
                          _text = onValue;
                        });
                      });
                    },
                    widgetChild: CustomCardWidget(
                      genderIcon: FontAwesomeIcons.venus,
                      gender: selectedGender == GenderChoice.female
                          ? 'Miss/Mrs $_text'
                          : 'Your name',
                    ),
                    colour: selectedGender == GenderChoice.female
                        ? kActiveCardColor
                        : kInActiveCardColor,
                  ),
                ),
              ],
            ),
          ),
          // The Slider container
          Expanded(
            child: ReuseableCard(
              colour: kActiveCardColor,
              widgetChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text('cm')
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15.0,
                      ),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 55.0,
                      max: 270.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The Weigth and Age Row Widget
          Expanded(
            child: Row(
              children: <Widget>[
                // WEIGHT CARD
                Expanded(
                  child: ReuseableCard(
                    colour: kActiveCardColor,
                    widgetChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              weight.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              'kg',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(width: 10.0),
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // AGE EXPANDED CARD
                Expanded(
                  child: ReuseableCard(
                    colour: kActiveCardColor,
                    widgetChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(width: 10.0),
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttontext: 'CALCULATE',
            ontap: () {
              //
              BmiCalculator bmiCalculator =
                  BmiCalculator(height: height, weight: weight);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmiResult: bmiCalculator.calculateBmi(),
                    interpretation: bmiCalculator.beAdvice(),
                    resultText: bmiCalculator.getResultText(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
