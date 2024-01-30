import 'package:flutter/material.dart';
import 'breeding_calculator.dart';

class ReverseBreedingScreen extends StatefulWidget {
  @override
  _ReverseBreedingScreenState createState() => _ReverseBreedingScreenState();
}

class _ReverseBreedingScreenState extends State<ReverseBreedingScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _combinations = [];

  void _calculateCombinations() async {
    var combinations = await BreedingCalculator.calculateReverseBreeding(_controller.text);
    setState(() {
      _combinations = combinations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('逆算ブリーディング'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '生まれさせたいパル',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _calculateCombinations,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _combinations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('パル1: ${_combinations[index]['creature1']}, パル2: ${_combinations[index]['creature2']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
