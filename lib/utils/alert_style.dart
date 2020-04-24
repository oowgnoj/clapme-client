import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var alertSuccessStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(fontSize: 20),
);

var alertFailedStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: true,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(fontSize: 20),
);
