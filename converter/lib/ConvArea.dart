import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AreaConverter extends StatefulWidget {
  const AreaConverter({Key? key}) : super(key: key);

  @override
  State<AreaConverter> createState() => _AreaConverterState();
}

class _AreaConverterState extends State<AreaConverter> {
  double inputValue = 0.0;
  String fromUnit = 'квадратные метры';
  String toUnit = 'квадратные метры';
  double result = 0.0;

  final List<String> units = [
    'квадратные метры',
    'квадратные километры',
    'квадратные миллиметры',
    'квадратные сантиметры',
    'квадратные дециметры',
    'квадратные дюймы',
    'квадратные футы',
    'квадратные ярды',
    'квадратные мили',
    'акры',
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
            'Площадь',
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
                    result = convertArea();
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

  double convertArea() {
    double result = inputValue;

    // Логика конвертации площади
    switch (fromUnit) {
      case 'квадратные метры':
        break;
      case 'квадратные километры':
        result *= 1e6;
        break;
      case 'квадратные миллиметры':
        result /= 1e6;
        break;
      case 'квадратные сантиметры':
        result /= 1e4;
        break;
      case 'квадратные дециметры':
        result /= 1e2;
        break;
      case 'квадратные дюймы':
        result *= 0.00064516;
        break;
      case 'квадратные футы':
        result *= 0.092903;
        break;
      case 'квадратные ярды':
        result *= 0.836127;
        break;
      case 'квадратные мили':
        result *= 2.58999e6;
        break;
      case 'акры':
        result *= 4046.86;
        break;
    }

    switch (toUnit) {
      case 'квадратные метры':
        break;
      case 'квадратные километры':
        result /= 1e6;
        break;
      case 'квадратные миллиметры':
        result *= 1e6;
        break;
      case 'квадратные сантиметры':
        result *= 1e4;
        break;
      case 'квадратные дециметры':
        result *= 1e2;
        break;
      case 'квадратные дюймы':
        result /= 0.00064516;
        break;
      case 'квадратные футы':
        result /= 0.092903;
        break;
      case 'квадратные ярды':
        result /= 0.836127;
        break;
      case 'квадратные мили':
        result /= 2.58999e6;
        break;
      case 'акры':
        result /= 4046.86;
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
