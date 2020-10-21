import 'package:exchangerate/api/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../prefs.dart';
import 'calculator.dart';
import 'change_currency.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  dynamic currencyData;
  int currencyCurrent = 0;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Currency",
              style:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5))),
          backgroundColor: Color.fromRGBO(81, 81, 255, 1),
          elevation: 0,
        ),
        body: Container(
          color: Color.fromRGBO(242, 242, 250, 1),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 165),
                child: currencyData == null
                    ? _indicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: Prefs().currencyName.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _itemCurrencyList(index);
                        }),
              ),
              Container(
                height: 165,
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
                          Text(
                            Prefs().currencySymbol[currencyCurrent],
                            style: TextStyle(
                                fontSize: 39,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _refreshButton(),
                              _changeCurrencyButton()
                            ],
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

  Future<void> _fetchData() async {
    await CurrencyService()
        .fetchData(Prefs().currencyName[currencyCurrent])
        .then((value) {
      currencyData = value;
      setState(() {});
    });
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Calculator(
                    currencyData: currencyData,
                    currencyCurrent: currencyCurrent,
                    currencySecond: index))),
        child: Container(
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
                          currencyData[Prefs().currencyName[index]] == null
                              ? '1.00'
                              : '${double.parse("${currencyData[Prefs().currencyName[index]]}").toStringAsFixed(2)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]))),
      ),
    );
  }

  Widget _refreshButton() {
    return Column(children: <Widget>[
      ClipOval(
        child: Container(
          color: Color.fromRGBO(255, 255, 255, .1), // ink
          child: InkWell(
            child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.sync,
                  color: Colors.white,
                )),
            onTap: () => _refreshAction(),
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Refresh',
        style: TextStyle(fontSize: 14, color: Colors.white),
      )
    ]);
  }

  Future<void> _refreshAction() async {
    currencyData = null;
    await _fetchData();
  }

  Widget _changeCurrencyButton() {
    return Column(children: <Widget>[
      ClipOval(
        child: Container(
          color: Color.fromRGBO(255, 255, 255, .1), // ink
          child: InkWell(
            child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )),
            onTap: () async {
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DefaultCurrency(
                          currencyData: currencyData,
                          currencyCurrent: currencyCurrent)));

              if (result != null) {
                setState(() {
                  currencyCurrent = result;
                });
                await _refreshAction();
              }
            },
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Change Currency',
        style: TextStyle(fontSize: 14, color: Colors.white),
      )
    ]);
  }
}
