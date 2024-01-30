import 'breeding_data_loader.dart';

class BreedingCalculator {
  static Future<String> calculateBreedingResult(String creature1, String creature2) async {
    var breedingData = await BreedingDataLoader.loadBreedingData();
    String result = "結果が見つかりません";

    for (var combo in breedingData) {
      if (combo['name'] == creature1) {
        for (var combination in combo['combinations']) {
          if (combination['partner'] == creature2) {
            result = combination['result'];
            break;
          }
        }
      }
    }

    return result;
  }
  static Future<List<Map<String, String>>> calculateReverseBreeding(String desiredCreature) async {
    var breedingData = await BreedingDataLoader.loadBreedingData();
    List<Map<String, String>> possibleCombinations = [];

    for (var combo in breedingData) {
      for (var combination in combo['combinations']) {
        if (combination['result'] == desiredCreature) {
          possibleCombinations.add({
            'creature1': combo['name'],
            'creature2': combination['partner']
          });
        }
      }
    }

    return possibleCombinations;
  }
}
