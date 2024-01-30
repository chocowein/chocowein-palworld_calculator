import 'dart:convert';
import 'package:flutter/services.dart';

class BreedingDataLoader {
  static Future<List<dynamic>> loadBreedingData() async {
    String jsonData = await rootBundle.loadString('assets/data/all_combos_data.json');
    return json.decode(jsonData);
  }
}
