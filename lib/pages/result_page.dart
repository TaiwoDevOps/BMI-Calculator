import 'dart:io';

import 'package:bmi_app/modules/bottom_buttom.dart';
import 'package:bmi_app/modules/reusable_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../modules/constants.dart';

class ResultPage extends StatefulWidget {
  // everything i want to recieve from other pages can be constructed here and initialize from whereever
  //  this class constructor is been called by passing the values there
  // So name received in the input page and age can be recieved here and initailized from the contructor
  // By just creating the variable that will hold and sdisplay them here

  ResultPage(
      {@required this.bmiResult,
      @required this.resultText,
      @required this.interpretation});
  final String bmiResult, resultText, interpretation;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  File _fileImage;

  void showBtmSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: kActiveCardColor,
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: OutlineButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.camera),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Use Camera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    getimage(context, ImageSource.camera);
                  },
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.photoVideo,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'Use Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  getimage(context, ImageSource.gallery);
                },
              ),
              Container(
                height: 50.0,
                child: FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  void getimage(BuildContext context, ImageSource imageSource) {
    ImagePicker.pickImage(
            source: imageSource, imageQuality: 50, maxWidth: 400.0)
        .then((File image) {
      // I need to set the state here
      setState(() {
        _fileImage = image;
      });
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Result',
                style: kResultTitleTextStyle,
              ),
            ),
          ), //Your Result title
          Expanded(
            flex: 5, //take much space than the usual
            child: ReuseableCard(
              colour: kActiveCardColor,
              widgetChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    widget.bmiResult,
                    style: kBmiResultTextStyle,
                  ),
                  Text(
                    widget.interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _fileImage == null
                      ? Text(' You can add an Image to remember this day')
                      : Image.file(
                          _fileImage,
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                        ),
                  // For the save and photo things
                  ReuseableCard(
                    colour: kInActiveCardColor,
                    widgetChild: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Save Data',
                              style: kLargeButtonTextStyle,
                            ),
                            onPressed: () {
                              // Save the data now or after the picture is received
                              print('Save clicked');
                            },
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          FlatButton(
                            child: Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.camera),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Take Photo',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              showBtmSheet(context);
                              print('Camera tapped');
                              // Lunch the bottomModal Sheet for Gallery service
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttontext: 'RE-CALCULATE',
            ontap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
