// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

// Custom Action
Future<List?> extractItemsListFromJson(String? jsonString) async {
  if (jsonString == null || jsonString.isEmpty) {
    return [];
  }
  final data = jsonDecode(jsonString);
  if (data is Map && data['items'] is List) {
    return data['items'];
  }
  return [];
}
