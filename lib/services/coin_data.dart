import 'package:bitcoin_ticker_app/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'NGN',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  final String assetIDBase;
  final String assetIDQuote;

  CoinData({required this.assetIDBase, required this.assetIDQuote});


  Future<dynamic> coinData() async {

    NetworkHelper networkHelper = NetworkHelper(
      assetIDBase: assetIDBase,
      assetIDQuote: assetIDQuote,
    );

    var coinData = await networkHelper.getData();
    return coinData;
  }
}
