import 'package:flutter/material.dart';
import 'package:lab2/ConvWeight.dart';
import 'package:lab2/ConvTemperature.dart';
import 'package:lab2/ConvArea.dart';
import 'package:lab2/ConvLength.dart';
import 'package:lab2/ConvSpeed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 178, 253),
        centerTitle: true,
        title: const Text(
          'Converter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 228, 160),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount:
              2, // Измените это значение на 3, если вы хотите 3 кнопки в строке
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: [
            CurrencyButton(
              buttonText: 'Вес-масса',
              imagePath: 'assets/images/weight.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WeightConverter()),
                );
              },
            ),
            CurrencyButton(
              buttonText: 'Температура',
              imagePath: 'assets/images/temp.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TemperatureConverter()),
                );
              },
            ),
            CurrencyButton(
              buttonText: 'Длина',
              imagePath: 'assets/images/lang.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LengthConverter()),
                );
              },
            ),
            CurrencyButton(
              buttonText: 'Площадь',
              imagePath: 'assets/images/area.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AreaConverter()),
                );
              },
            ),
            CurrencyButton(
              buttonText: 'Скорость',
              imagePath: 'assets/images/speed.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SpeedConverter()),
                );
              },
            ),
            CurrencyButton(
              buttonText: 'Копатыч',
              imagePath: 'assets/images/copa.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TemperatureConverter()),
                );
              },
            ),
            // Добавьте остальные кнопки аналогичным образом
          ],
        ),
      ),
    );
  }
}

class CurrencyButton extends StatelessWidget {
  const CurrencyButton({
    Key? key,
    required this.buttonText,
    required this.imagePath, // Добавляем параметр для пути к изображению
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color.fromARGB(183, 252, 143, 27),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50,
          ),
          const SizedBox(height: 8),
          Text(
            buttonText,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
