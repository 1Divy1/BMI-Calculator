import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  late String BMI;
  late String BMIinfo = '';

  String calculateBMI(
      TextEditingController weightParam, TextEditingController heightParam) {
    if (weightParam.text.isNotEmpty && heightParam.text.isNotEmpty) {
      BMI = (double.parse(weightParam.text) /
              pow(double.parse(heightParam.text), 2))
          .toStringAsPrecision(4);
      return BMI;
    } else {
      BMI = '0';
      return BMI;
    }
  }

  void ClearAll() {
    weight.clear();
    height.clear();
    BMI = '0';
  }

  String showBMIinfo() {
    if (double.parse(BMI) == 0) {
      setState(() {
        BMIinfo = '';
      });
    } else if (double.parse(BMI) < 18.5) {
      setState(() {
        BMIinfo = 'underweight';
      });
    } else if ((double.parse(BMI) >= 18.5) && ((double.parse(BMI) <= 24.9))) {
      setState(() {
        BMIinfo = 'healthy';
      });
    } else if (double.parse(BMI) >= 25 && double.parse(BMI) <= 29.9) {
      setState(() {
        BMIinfo = 'overweight';
      });
    } else if (double.parse(BMI) >= 30) {
      setState(() {
        BMIinfo = 'obese';
      });
    } else {
      setState(() {
        BMIinfo = '';
      });
    }

    return BMIinfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              // show BMI info in a pop-up window
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Text(
                    'BMI info',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'below 18.5 -> underweight',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'between 18.5 - 24.9 -> healthy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'between 25 - 29.9 -> overweight',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'between 30 - 39.9 -> obese',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                barrierDismissible: true,
              );
            },
            icon: const Icon(
              Icons.question_mark_rounded,
              color: Colors.white,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 90),
          const Text(
            'Weight',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            keyboardType: TextInputType.number,
            controller: weight,
            cursorHeight: 50,
            style: const TextStyle(fontSize: 30),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Height',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            keyboardType: TextInputType.number,
            controller: height,
            cursorHeight: 50,
            style: const TextStyle(fontSize: 30),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Result',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            calculateBMI(weight, height).toString(),
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            showBMIinfo(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextButton(
                  onPressed: () {
                    // calculate BMI
                    setState(() {
                      calculateBMI(weight, height);
                    });
                  },
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      ClearAll();
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
