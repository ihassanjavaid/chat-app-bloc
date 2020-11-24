import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

const kButtonContainerColour = 0xFFc4c4c4;
const kDefaultBackgroundColour = 0xfff8f8f8;

const kNormalTextStyle = TextStyle(
  color: Color(0xffa9a9a9),
);

const kTitleTextStyle = TextStyle(
  fontSize: 33.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
  color: Color(0xff262522),
);

const kCardTitleTextStyle = TextStyle(
  fontSize: 28.8,
  color: Colors.redAccent,
);

const kSubtitleStyle = TextStyle(
  fontSize: 22,
  color: Color(0xffcfcfcf),
);

const kBottomNavTextStyle = TextStyle(
  fontSize: 16,
  //color: Color(0xffcfcfcf),
);

const kButtonTextStyle = TextStyle(
  color: Color(0xffffffff),
  fontSize: 18.0,
);

const kSettingWidgetTextStyle = TextStyle(
  color: Color(0xffa9a9a9),
  fontSize: 18.0,
);

const kSettingsTextStyle = TextStyle(
  color: Colors.redAccent,
  fontWeight: FontWeight.bold,
  fontSize: 28.0,
);

const TextStyle kOptionStyle =
TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

const Icon kAnnouceIcon = Icon(
  FontAwesomeIcons.bullhorn,
  size: 30,
  color: Colors.grey,
);

const Icon kUserMessagesIcon = Icon(
  Icons.comment,
  size: 30,
  color: Colors.grey,
);



const Icon kUserChatIcon = Icon(
  FontAwesomeIcons.comments,
  size: 30,
  color: Colors.grey,
);


const Icon kPeopleIcon = Icon(
  Icons.people,
  size: 30,
  color: Colors.grey,
);


const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const Color kRedColor = Color(0xffc0012a);
const Color kOrangeColor = Color(0xffed5f5f);
const Color kLightGreyColor = Color(0xffc9c9c9);
const Color kAshWhiteColor = Color(0xfff7f7f7);

String getCurrentTime(){
  DateTime now = DateTime.now();
  String date = DateFormat('MMMM dd').format(now);
  String time = getHourIn12(now);

  return '$date at $time';
}

String getHourIn12(DateTime now){
  if (now.hour <= 12) return '${now.hour}:${getMinute(now)} AM';
  return '${now.hour-12}:${getMinute(now)} PM';
}

String getMinute(DateTime now){
  if (now.minute < 10) return '0${now.minute}';
  return now.minute.toString();
}