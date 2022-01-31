import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora decimal',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculadora'),
    );
  }
}

String strInput = "";
final txtEntrada = TextEditingController();
final txtResultado = TextEditingController();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    txtEntrada.addListener(() {});
    txtResultado.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 40,
                      fontFamily: 'RobotoMono',
                    )),
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
                controller: txtEntrada,
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
              )),
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "",
                    fillColor: Colors.deepPurpleAccent,
                    hintStyle: TextStyle(
                        fontFamily: 'RobotoMono', color: Colors.white)),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
                controller: txtResultado,
              )),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton(
                '%',
                Colors.deepOrangeAccent,
              ),
              boton(
                '/',
                Colors.deepOrangeAccent,
              ),
              btnBorrar(),
              btnAC('AC', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('7', Colors.blueGrey),
              boton('8', Colors.blueGrey),
              boton('9', Colors.blueGrey),
              boton(
                '*',
                Colors.deepOrangeAccent,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('4', Colors.blueGrey),
              boton('5', Colors.blueGrey),
              boton('6', Colors.blueGrey),
              boton(
                '-',
                Colors.deepOrangeAccent,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('1', Colors.blueGrey),
              boton('2', Colors.blueGrey),
              boton('3', Colors.blueGrey),
              boton('+', Colors.deepOrangeAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('0', Colors.blueGrey),
              boton('.', Colors.deepOrangeAccent),
              boton('^', Colors.deepOrangeAccent),
              btnIgual()
            ],
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  Widget boton(btntxt, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntxt,
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = txtEntrada.text + btntxt;
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = "";
            txtResultado.text = "";
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnBorrar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.backspace, size: 35, color: Colors.white),
        onPressed: () {
          txtEntrada.text = (txtEntrada.text.length > 0)
              ? (txtEntrada.text.substring(0, txtEntrada.text.length - 1))
              : "";
        },
        color: Colors.orange,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnIgual() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          '=',
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          Parser p = new Parser();
          ContextModel cm = new ContextModel();
          Expression exp;
          try {
            exp = p.parse(txtEntrada.text);
            setState(() {
              txtResultado.text =
                  exp.evaluate(EvaluationType.REAL, cm).toString();
            });
          } catch (e) {
            txtResultado.text = "Error";
            txtEntrada.text = "";
          }
        },
        color: Colors.orange,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }
}
