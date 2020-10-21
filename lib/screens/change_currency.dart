import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../prefs.dart';

class DefaultCurrency extends StatefulWidget {
  final dynamic currencyData;
  final int currencyCurrent;

  const DefaultCurrency({Key key, this.currencyData, this.currencyCurrent})
      : super(key: key);
  @override
  DefaultCurrencyState createState() => DefaultCurrencyState();
}

class DefaultCurrencyState extends State<DefaultCurrency> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Default Currency",
              style:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5))),
          backgroundColor: Color.fromRGBO(81, 81, 255, 1),
          elevation: 0,
        ),
        body: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Prefs().currencyName.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _itemCurrencyList(index);
                    }),
              ),
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
                          color: Color.fromRGBO(81, 81, 255, 1)),
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
                                  color: Colors.white,
                                ),
                              ),
                              _newCurrency()
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Choose Currency:',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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

  Widget _itemCurrencyList(int index) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context, index),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 38,
                          height: 38,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(81, 81, 255, .1),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              Prefs().currencyFlag[index],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        Text(
                          Prefs().currencyName[index],
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            widget.currencyData[Prefs().currencyName[index]] ==
                                    null
                                ? '1.00'
                                : '${double.parse("${widget.currencyData[Prefs().currencyName[index]]}").toStringAsFixed(2)}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]))),
        ),
        Divider(height: 1)
      ],
    );
  }

  Widget _currentCurrency() {
    return Container(
      width: 110,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 28,
            alignment: Alignment.center,
            height: 28,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300]),
                shape: BoxShape.circle),
            child: Text(
              '${Prefs().currencySymbol[widget.currencyCurrent]}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '${Prefs().currencyName[widget.currencyCurrent]}',
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _newCurrency() {
    return Container(
      width: 110,
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
