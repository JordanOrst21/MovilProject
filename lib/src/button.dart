// import 'package:flutter/material.dart';

// class MyButton extends StatefulWidget {
//   @override
//   _MyButtonState createState() => _MyButtonState();
// }

// class _MyButtonState extends State<MyButton> {
//   String flutterText = "";
//   int index = 0;
//   List<String> collection = ["Flutter", "Es", "Genial"];

//   void onPresseButton() {
//     setState(() {
//       flutterText = collection[index];
//       index = index < 2 ? index + 1 : 0;
//     });
//   }

//   @override
//   Widget build(BuildContext) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("App con Stateful Widget"),
//         backgroundColor: Colors.orange,
//       ),
//       body: Container(
//           child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               flutterText,
//               style: TextStyle(fontSize: 40.0),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10.0),
//             ),
//             ElevatedButton(
//               child: Text(
//                 "Actualizar",
//                 style: TextStyle(color: Colors.purple),
//               ),
//               style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
//               onPressed: () {
//                 onPresseButton();
//               },
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  TextEditingController input1Controller = TextEditingController();
  TextEditingController input2Controller = TextEditingController();
  double result = 0;

  void onButtonPressed(String value) {
    setState(() {
      double input1 = double.tryParse(input1Controller.text) ?? 0;
      double input2 = double.tryParse(input2Controller.text) ?? 0;

      if (value == "Suma") {
        result = input1 + input2;
      } else if (value == "Resta") {
        result = input1 - input2;
      } else if (value == "Multiplicacion") {
        result = input1 * input2;
      } else if (value == "Division") {
        if (input2 != 0) {
          result = input1 / input2;
        } else {
          result = 0;
        }
      }
      input1Controller.text = input1.toStringAsFixed(2);
      input2Controller.text = input2.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      bottom: 130.0), // Añade un margen de 2.0 px hacia abajo
                  child: Text(
                    "Bienvenido a mi calculadora\nJordan Avila Gomez",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: input1Controller,
                  ),
                ),
                SizedBox(width: 16.0),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: input2Controller,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => onButtonPressed("Suma"),
                  child: Text("Suma"),
                ),
                ElevatedButton(
                  onPressed: () => onButtonPressed("Resta"),
                  child: Text("Resta"),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => onButtonPressed("Multiplicacion"),
                  child: Text("Multiplicacion"),
                ),
                ElevatedButton(
                  onPressed: () => onButtonPressed("Division"),
                  child: Text("Division"),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              " ${result.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
