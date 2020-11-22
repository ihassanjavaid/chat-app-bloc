import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kButtonContainerColour = 0xFFc4c4c4;
const kDefaultBackgroundColour = 0xfff8f8f8;

const kAnnounceTextStyle = TextStyle(
  fontSize: 38.0,
  fontWeight: FontWeight.bold,
  color: Colors.brown,
);

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

const Icon kAnnouceIconActive = Icon(
  FontAwesomeIcons.bullhorn,
  size: 30,
  color: Colors.brown ,
);

const Icon kUserMessagesIcon = Icon(
  Icons.comment,
  size: 30,
  color: Colors.grey,
);

const Icon kUserMessagesIconActive = Icon(
  Icons.comment,
  size: 30,
  color: Colors.brown ,
);

const Icon kUserChatIcon = Icon(
  FontAwesomeIcons.comments,
  size: 30,
  color: Colors.grey,
);

const Icon kUserChatIconActive = Icon(
  FontAwesomeIcons.comments,
  size: 30,
  color: Colors.brown ,
);

const Icon kPeopleIcon = Icon(
  Icons.people,
  size: 30,
  color: Colors.grey,
);

const Icon kPeopleIconActive = Icon(
  Icons.people,
  size: 30,
  color: Colors.brown,
);

const TextStyle kAppBarTextStyle = TextStyle(
  fontSize: 30,
  fontStyle: FontStyle.normal,
  color: Colors.brown,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.brown, width: 2.0),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.brown,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const Color kRedColor = Color(0xffc0012a);
const Color kOrangeColor = Color(0xffed5f5f);
const Color kLightGreyColor = Color(0xffc9c9c9);