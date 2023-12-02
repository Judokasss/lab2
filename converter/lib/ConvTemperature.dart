import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  TextEditingController celsiusController = TextEditingController();
  TextEditingController fahrenheitController = TextEditingController();
  TextEditingController kelvinController = TextEditingController();
  TextEditingController rankineController = TextEditingController();

  String appBarTitle =
      'Температура'; // Переменная для хранения текущего заголовка AppBar
  Color appBarColor = Color.fromARGB(255, 86, 178, 253); // Исходный цвет AppBar

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard();
        setState(() {
          appBarTitle = 'Температура';
          appBarColor = Color.fromARGB(255, 86, 178, 253);
        });
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 228, 160),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.thermostat),
                    SizedBox(width: 8),
                    Text(
                      appBarTitle,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: appBarColor,
        ),
        body: Center(
          child: Container(
            // задаем цвет для внутри конта
            //color: Color.fromARGB(22, 22, 22, 22),
            height: 420,
            width: 370, //600 Установка ограничения ширины
            padding: EdgeInsets.all(20),

            child: Form(
              child: Column(
                // выравнивание по центру экрана
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTemperatureField(
                      controller: celsiusController,
                      label: 'Цельсий',
                      suffix: '°C',
                      appCol: Color.fromARGB(255, 239, 146, 255),
                      suffixColor: Color.fromARGB(255, 217, 5, 255)),
                  buildTemperatureField(
                      controller: fahrenheitController,
                      label: 'Фаренгейт',
                      suffix: '°F',
                      appCol: Color.fromARGB(248, 128, 157, 255),
                      suffixColor: Color.fromARGB(255, 1, 60, 252)),
                  buildTemperatureField(
                      controller: kelvinController,
                      label: 'Кельвин',
                      suffix: 'K',
                      appCol: Color.fromARGB(255, 248, 163, 163),
                      suffixColor: Color.fromARGB(255, 249, 122, 122)),
                  buildTemperatureField(
                      controller: rankineController,
                      label: 'Ренкин',
                      suffix: '°Ra',
                      appCol: Color.fromARGB(255, 49, 214, 255),
                      suffixColor: Color.fromARGB(255, 0, 204, 255)),
                  ElevatedButton(
                    onPressed: () {
                      clearAllFields();
                    },
                    child: Text('Очистить все поля'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTemperatureField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required Color appCol,
    required Color suffixColor,
  }) {
    // Регулярное выражение, которое разрешает ввод только цифр и точек
    String regex = r'^-?\d*\.?\d*$';
    //regex = r'^\d*\.?\d*$';
    // Если текущая шкала - Кельвины или Ренкины, не разрешаем ввод минуса
    // Если текущая шкала - Кельвины или Ренкины, не разрешаем ввод минуса
    // if (label != 'Цельсий' && label != 'Фаренгейт') {
    //   regex = r'^\d*\.?\d*$'; // Запретить минус
    // } else {
    //   regex = r'^-?\d*\.?\d*$'; // Разрешить минус
    // }

    return Column(
      children: [
        TextFormField(
          cursorColor: appCol,
          controller: controller,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Введите температуру в $label  $suffix',
            suffixText: suffix,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 69, 65, 65),
                fontSize: 15),
            suffixStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: suffixColor,
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(regex)),
          ],
          onTap: () {
            setState(() {
              appBarTitle = label; // Обновляем заголовок AppBar
              appBarColor = appCol;
            });
          },
          onChanged: (text) {
            if (text.isEmpty) {
              clearAllFields();
            } else {
              convertTemperatures(label);
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void convertTemperatures(String fromScale) {
    double celsius = double.tryParse(celsiusController.text) ?? 0.0;
    double fahrenheit = double.tryParse(fahrenheitController.text) ?? 0.0;
    double kelvin = double.tryParse(kelvinController.text) ?? 0.0;
    double rankine = double.tryParse(rankineController.text) ?? 0.0;

    switch (fromScale) {
      case 'Цельсий':
        fahrenheitController.text = ((celsius * 9 / 5) + 32).toStringAsFixed(2);
        kelvinController.text = (celsius + 273.15).toStringAsFixed(2);
        rankineController.text =
            ((celsius + 273.15) * 9 / 5).toStringAsFixed(2);
        break;
      case 'Фаренгейт':
        celsiusController.text = ((fahrenheit - 32) * 5 / 9).toStringAsFixed(2);
        kelvinController.text =
            (((fahrenheit - 32) * 5 / 9) + 273.15).toStringAsFixed(2);
        rankineController.text = ((fahrenheit + 459.67)).toStringAsFixed(2);
        break;
      case 'Кельвин':
        celsiusController.text = (kelvin - 273.15).toStringAsFixed(2);
        fahrenheitController.text =
            (((kelvin - 273.15) * 9 / 5) + 32).toStringAsFixed(2);
        rankineController.text = ((kelvin * 9 / 5)).toStringAsFixed(2);
        break;
      case 'Ренкин':
        celsiusController.text =
            (((rankine - 491.67) * 5 / 9)).toStringAsFixed(2);
        fahrenheitController.text = (rankine - 459.67).toStringAsFixed(2);
        kelvinController.text = (rankine * 5 / 9).toStringAsFixed(2);
        break;
      default:
        // Do nothing
        break;
    }
  }

  void clearAllFields() {
    // метод стирания инпутов если один инпут пустой
    setState(() {
      celsiusController.clear();
      fahrenheitController.clear();
      kelvinController.clear();
      rankineController.clear();
    });
  }

  void closeKeyboard() {
    // метод закрывания клавиатуры по клику на пустое место
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
