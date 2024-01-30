import 'package:flutter/material.dart';
import 'breeding_calculator.dart';
import 'breeding_data_loader.dart';
import 'reverse_breeding_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedCreature1 = '';
  String selectedCreature2 = '';
  String breedingResult = '';
  List<String> creatures = [];

  @override
  void initState() {
    super.initState();
    loadCreatures();
  }

  Future<void> loadCreatures() async {
    var breedingData = await BreedingDataLoader.loadBreedingData();
    var loadedCreatures = breedingData.map<String>((combo) => combo['name'].toString()).toList();
    setState(() {
      creatures = loadedCreatures;
      selectedCreature1 = creatures.isNotEmpty ? creatures[0] : '';
      selectedCreature2 = creatures.length > 1 ? creatures[1] : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Breeding Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return creatures.where((String option) {
                          return option.contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          selectedCreature1 = selection;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.close),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return creatures.where((String option) {
                          return option.contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          selectedCreature2 = selection;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        String result = await BreedingCalculator.calculateBreedingResult(selectedCreature1, selectedCreature2);
                        setState(() {
                          breedingResult = result;
                        });
                      },
                      child: Text('計算する'),
                    ),
                  ),
                  SizedBox(width: 10), // ボタン間のスペース
                  Expanded(
                    child: Builder(
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReverseBreedingScreen()),
                          );
                        },
                        child: Text('逆算'),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    breedingResult,
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
