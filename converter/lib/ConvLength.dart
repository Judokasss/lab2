import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class LengthConverter extends StatefulWidget {
  const LengthConverter({Key? key}) : super(key: key);

  @override
  State<LengthConverter> createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  double inputValue = 0.0;
  String fromUnit = 'метры';
  String toUnit = 'метры';
  double result = 0.0;

  final List<String> units = [
    'метры',
    'километры',
    'миллиметры',
    'сантиметры',
    'дециметры',
    'мили',
    'дюймы',
    'футы',
    'ярды',
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
            'Длина',
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
                    result = convertLength();
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

  double convertLength() {
    double result = inputValue;

    // Логика конвертации длины
    switch (fromUnit) {
      case 'метры':
        break;
      case 'километры':
        result *= 1000;
        break;
      case 'миллиметры':
        result /= 1000;
        break;
      case 'сантиметры':
        result /= 100;
        break;
      case 'дециметры':
        result /= 10;
        break;
      case 'мили':
        result *= 1609.34;
        break;
      case 'дюймы':
        result *= 0.0254;
        break;
      case 'футы':
        result *= 0.3048;
        break;
      case 'ярды':
        result *= 0.9144;
        break;
    }

    switch (toUnit) {
      case 'метры':
        break;
      case 'километры':
        result /= 1000;
        break;
      case 'миллиметры':
        result *= 1000;
        break;
      case 'сантиметры':
        result *= 100;
        break;
      case 'дециметры':
        result *= 10;
        break;
      case 'мили':
        result /= 1609.34;
        break;
      case 'дюймы':
        result /= 0.0254;
        break;
      case 'футы':
        result /= 0.3048;
        break;
      case 'ярды':
        result /= 0.9144;
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
