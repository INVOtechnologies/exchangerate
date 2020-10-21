import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../prefs.dart';

class Calculator extends StatefulWidget {
  final dynamic currencyData;
  final int currencyCurrent;
  final int currencySecond;

  const Calculator(
      {Key key, this.currencyData, this.currencyCurrent, this.currencySecond})
      : super(key: key);
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  double currentValue = 0;
  int currencyCurrent;
  int currencySecond;
  bool isReversed = false;

  @override
  void initState() {
    currencyCurrent = widget.currencyCurrent;
    currencySecond = widget.currencySecond;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[700],
          ),
          title: Text("Calculator",
              style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          color: Color.fromRGBO(81, 81, 255, 1),
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              '${Prefs().currencySymbol[currencySecond]} ${_calcValues().toStringAsFixed(2)} = ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${Prefs().currencySymbol[currencyCurrent]}',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Container(
                                width: 130,
                                child: TextFormField(
                                    autofocus: true,
                                    onChanged: (text) {
                                      setState(() {
                                        currentValue = double.parse(text);
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.none,
                                              width: 0)),
                                    ),
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Container(color: Colors.white, height: 1, width: 150)
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 25.0, left: 20, right: 20),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              currencyCurrent = isReversed
                                  ? widget.currencyCurrent
                                  : widget.currencySecond;
                              currencySecond = isReversed
                                  ? widget.currencySecond
                                  : widget.currencyCurrent;
                              isReversed = isReversed ? false : true;
                            });
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            child: Text(
                              'Reverse currency',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(81, 81, 255, 1)),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                height: 110,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _currentCurrency(),
                              Container(
                                width: 70,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Color.fromRGBO(81, 81, 255, 1),
                                ),
                              ),
                              _secondCurrency()
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Convert ${Prefs().currencyName[currencyCurrent]} to ${Prefs().currencyName[currencySecond]}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  double _calcValues() {
    return isReversed
        ? (currentValue) /
            double.parse(
                '${widget.currencyData[Prefs().currencyName[widget.currencySecond]]}')
        : (currentValue *
            double.parse(
                '${widget.currencyData[Prefs().currencyName[widget.currencySecond]]}'));
  }

  Widget _indicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
            child: CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(81, 81, 255, .1),
        ))
      ],
    );
  }

  Widget _currentCurrency() {
    return Container(
      width: 110,
      height: 45,
      decoration: BoxDecoration(
          color: Color.fromRGBO(81, 81, 255, 1),
          border: Border.all(width: 1, color: Color.fromRGBO(81, 81, 255, 1)),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 28,
            alignment: Alignment.center,
            height: 28,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white30),
                shape: BoxShape.circle),
            child: Text(
              '${Prefs().currencySymbol[currencyCurrent]}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '${Prefs().currencyName[currencyCurrent]}',
            style: TextStyle(fontSize: 16, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _secondCurrency() {
    return Container(
      width: 110,
      height: 45,
      decoration: BoxDecoration(
          color: Color.fromRGBO(81, 81, 255, 1),
          border: Border.all(width: 1, color: Color.fromRGBO(81, 81, 255, 1)),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 28,
            alignment: Alignment.center,
            height: 28,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white30),
                shape: BoxShape.circle),
            child: Text(
              '${Prefs().currencySymbol[currencySecond]}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '${Prefs().currencyName[currencySecond]}',
            style: TextStyle(fontSize: 16, color: Colors.white),
          )
        ],
      ),
    );
  }
}
