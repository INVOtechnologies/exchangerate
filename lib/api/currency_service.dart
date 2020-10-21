import 'dart:convert';

import 'package:http/http.dart';

class CurrencyService {
  Future fetchData(String currentCurrency) async {
    var params = {'base': currentCurrency};
    final url = Uri.https('api.exchangeratesapi.io', '/latest', params);
    final response = await Client().get(url);
    print(response.body);
    final json = jsonDecode(response.body);
    return json['rates'];
  }
}
