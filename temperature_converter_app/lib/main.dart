import 'package:flutter/material.dart';

void main() => runApp(TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double inputTemperature = 0.0;
  double outputTemperature = 0.0;

  String selectedInputUnit = 'Celsius';
  String selectedOutputUnit = 'Fahrenheit';

  final Map<String, Map<String, double>> conversionRates = {
    'Celsius': {
      'Fahrenheit': 9 / 5,
      'Kelvin': 1,
      'Rankine': 9 / 5,
    },
    'Fahrenheit': {
      'Celsius': 5 / 9,
      'Kelvin': 5 / 9 + 273.15,
      'Rankine': 459.67,
    },
    'Kelvin': {
      'Celsius': 1 - 273.15,
      'Fahrenheit': (5 / 9 + 273.15) * 9 / 5,
      'Rankine': 9 / 5 * 1,
    },
    'Rankine': {
      'Celsius': 5 / 9 - 273.15,
      'Fahrenheit': 5 / 9 * 9 / 5,
      'Kelvin': 5 / 9,
    },
  };

  void convert() {
    if (selectedInputUnit != selectedOutputUnit) {
      setState(() {
        outputTemperature = inputTemperature *
            conversionRates[selectedInputUnit]![selectedOutputUnit]!;
      });
    } else {
      // Handle the case when both input and output units are the same
      setState(() {
        outputTemperature = inputTemperature;
      });
    }
  }

  void swapUnits() {
    setState(() {
      final temp = selectedInputUnit;
      selectedInputUnit = selectedOutputUnit;
      selectedOutputUnit = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  inputTemperature = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(labelText: 'Enter Temperature'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedInputUnit,
              onChanged: (value) {
                setState(() {
                  selectedInputUnit = value!;
                });
              },
              items: conversionRates.keys.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedOutputUnit,
              onChanged: (value) {
                setState(() {
                  selectedOutputUnit = value!;
                });
              },
              items: conversionRates[selectedInputUnit]!.keys
                  .map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                convert();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                swapUnits();
              },
              child: Text('Swap Units'),
            ),
            SizedBox(height: 20),
            Text('Result: $outputTemperature $selectedOutputUnit'),
          ],
        ),
      ),
    );
  }
}
