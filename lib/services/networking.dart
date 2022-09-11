import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  
  final String assetIDBase;
  final String assetIDQuote;

  NetworkHelper({required this.assetIDBase, required this.assetIDQuote});

  getData() async {

    Uri baseUrl = Uri(
      scheme: 'https',
      host: 'rest.coinapi.io',
      path: '/v1/exchangerate/$assetIDBase/$assetIDQuote',
      queryParameters: {
        'apikey': 'ADD YOUR API KEY HERE',
      },
    );

    http.Response response = await http.get(baseUrl);
    if (response.statusCode == 200) {
      var coinData = jsonDecode(response.body);
      return coinData;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }
}
