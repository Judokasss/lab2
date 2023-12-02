import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class SpeedConverter extends StatefulWidget {
  const SpeedConverter({Key? key}) : super(key: key);

  @override
  State<SpeedConverter> createState() => _SpeedConverterState();
}

class _SpeedConverterState extends State<SpeedConverter> {
  double inputValue = 0.0;
  String fromUnit = 'метры в секунду';
  String toUnit = 'метры в секунду';
  double result = 0.0;

  final List<String> units = [
    'метры в секунду',
    'километры в час',
    'мили в час',
    'узлы',
    'футы в секунду',
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
            'Скорость',
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
                    result = convertSpeed();
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

  double convertSpeed() {
    double result = inputValue;

    // Логика конвертации скорости
     switch (fromUnit) {
    case 'метры в секунду':
      break;
    case 'километры в час':
      result /= 3.6;
      break;
    case 'мили в час':
      result /= 2.23694;
      break;
    case 'узлы':
      result /= 1.94384;
      break;
    case 'футы в секунду':
      result /= 3.28084;
      break;
  }

  switch (toUnit) {
    case 'метры в секунду':
      break;
    case 'километры в час':
      result *= 3.6;
      break;
    case 'мили в час':
      result *= 2.23694;
      break;
    case 'узлы':
      result *= 1.94384;
      break;
    case 'футы в секунду':
      result *= 3.28084;
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
