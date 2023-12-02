import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class WeightConverter extends StatefulWidget {
  const WeightConverter({Key? key}) : super(key: key);

  @override
  State<WeightConverter> createState() => _WeightConverterState();
}

class _WeightConverterState extends State<WeightConverter> {
  double inputValue = 0.0;
  String fromUnit = 'граммы';
  String toUnit = 'граммы';
  double result = 0.0;

  final List<String> units = [
    'граммы',
    'килограммы',
    'тонны',
    'унции',
    'миллиграммы',
    'фунты',
    'килотонны',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 228, 160),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Веса и масса',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 86, 178, 253),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWrapper(
                text: 'Из:',
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: fromUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          fromUnit = newValue!;
                        });
                      },
                      items:
                          units.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              const TextWrapper(text: 'В:'),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: toUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          toUnit = newValue!;
                        });
                      },
                      items:
                          units.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Введите значение'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                onChanged: (value) {
                  setState(() {
                    inputValue = double.tryParse(value) ?? 0.0;
                    result = convertWeight();
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Результат: ${inputValue != 0 ? '${NumberFormat.decimalPattern().format(result)} $toUnit' : ''}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double convertWeight() {
    double result = inputValue;

    // Логика конвертации веса
    switch (fromUnit) {
      case 'граммы':
        break;
      case 'килограммы':
        result *= 1000;
        break;
      case 'тонны':
        result *= 1000000;
        break;
      case 'унции':
        result *= 28.3495;
        break;
      case 'миллиграммы':
        result /= 1000;
        break;
      case 'фунты':
        result *= 453.592;
        break;
      case 'килотонны':
        result *= 1e9;
        break;
    }

    switch (toUnit) {
      case 'граммы':
        break;
      case 'килограммы':
        result /= 1000;
        break;
      case 'тонны':
        result /= 1000000;
        break;
      case 'унции':
        result /= 28.3495;
        break;
      case 'миллиграммы':
        result *= 1000;
        break;
      case 'фунты':
        result /= 453.592;
        break;
      case 'килотонны':
        result /= 1e9;
        break;
    }

    return result;
  }

  void closeKeyboard() {
    // метод закрывания клавиатуры по клику на пустое место
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

// виджет для Text, чтобы можно было использовать текст с одинаковым стилем
class TextWrapper extends StatelessWidget {
  final String text;

  const TextWrapper({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
