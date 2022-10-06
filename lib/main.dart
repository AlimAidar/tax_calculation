import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Расчет заработной платы'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVisible = false;
  double result = 0;
  double opv = 0;
  double osms = 0;
  double mrp = 0;
  double ipn = 0;
  TextEditingController controller = TextEditingController();

  void calculate() {
    setState(
      () {
        double zp = double.parse(controller.text);
        opv = zp * 0.1;
        osms = zp * 0.02;
        mrp = 14 * 3063;
        // result = number -
        //     ((0.1 * number) +
        //         (0.017 * number) +
        //         (42882 * 0.02) +
        //         (number * 0.06));
        ipn = (zp - (opv + osms + mrp)) * 0.1;
        result = (zp - opv - osms - ipn);
        isVisible = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15.0),
                const Icon(Icons.calculate, size: 128.0),
                const SizedBox(height: 15.0),
                isVisible
                    ? Text('Результат — ${result.round()}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold))
                    : const SizedBox(),
                const SizedBox(height: 20.0),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    label: Text('Заработная плата без учета налогов'),
                  ),
                ),
                const SizedBox(height: 20.0),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: CupertinoButton(
                    color: Colors.indigo,
                    onPressed: () {
                      calculate();
                    },
                    child: Text(
                      'Вычислить'.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                isVisible
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('ОПВ равен: ${opv.round()}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          Text('ОСМС равен: ${osms.round()}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          Text('ИПН равен: ${ipn.round()}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
