import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? formatIsoToSlashDate(String isoString) {
  if (isoString == null || isoString.isEmpty) {
    return null; // 引数がnullや空文字ならnullを返す
  }
  try {
    // 1) ISO8601文字列をDateTimeにパース
    final dateTime = DateTime.parse(isoString);
    // 2) "yyyy/MM/dd" 形式にフォーマット
    final formatted = DateFormat('yyyy/MM/dd').format(dateTime);
    return formatted;
  } catch (e) {
    // パース失敗時は元の文字列を返す or nullを返す
    return isoString;
  }
}
