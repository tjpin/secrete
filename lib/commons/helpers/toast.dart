import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successToast(String message) => Fluttertoast.showToast(
    msg: message, backgroundColor: Colors.green, textColor: Colors.white);

void errorToast(String message) => Fluttertoast.showToast(
    msg: message, backgroundColor: Colors.red, textColor: Colors.white);
