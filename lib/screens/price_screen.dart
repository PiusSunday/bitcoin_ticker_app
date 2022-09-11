import 'dart:io' show Platform;

import 'package:bitcoin_ticker_app/services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/crypto_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({
    super.key,
  });

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  
  // INITIAL VALUE OF SELECTED CURRENCY
  String selectedCurrency = '?';

  // FOR IOS DEVICES
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      final Text item = Text(currency);
      pickerItems.add(item);
    }

    return CupertinoPicker(
      itemExtent: 40.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getCoinRate();
        });
      },
      children: pickerItems,
    );
  }

  // FOR ANDROID DEVICES
  Widget androidPicker() {
    List<DropdownMenuItem> currencies = [];

    currencies = currenciesList
        .map((dropDownMenuItem) => DropdownMenuItem(
              value: dropDownMenuItem,
              child: Text(dropDownMenuItem),
            ))
        .toList();

    return DropdownButton(
      value: selectedCurrency,
      items: currencies,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getCoinRate();
        });
      },
    );

    // getDropdownItems() {
    //   for(String curency in currenciesList) {
    //     DropdownMenuItem item = DropdownMenuItem(
    //       value: curency,
    //       child: Text(curency),
    //     );
    //     currencies.add(item);
    //   }

    //   return currencies;
    // }
  }

  List<String> cryptoList = [
    'BTC',
    'ETH',
    'LTC',
  ];

  Map<String, String> coinRate = {
    'BTC': '?',
    'ETH': '?',
    'LTC': '?',
  };

  getCoinRate() async {
    try {
      for (String crypto in cryptoList) {
        CoinData coinData = CoinData(
          assetIDBase: crypto,
          assetIDQuote: selectedCurrency,
        );

        var coinDataResponse = await coinData.coinData();

        setState(() {
          coinRate[crypto] = coinDataResponse['rate'].toStringAsFixed(0);
        });
      }
    } catch (e) {
      print(e);
    }

    // CoinData coinData = CoinData(
    //   assetIDBase: ,
    //   assetIDQuote: selectedCurrency,
    // );

    // var data = await coinData.coinData();

    // setState(() {
    //   coinRate = data['rate'].toStringAsFixed(0);
    // });
  }

  @override
  void initState() {
    super.initState();
    getCoinRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          '🤑 Coin Ticker',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                ReusablePriceCard(
                    crypto: cryptoList[0],
                    rate: coinRate[cryptoList[0]]!,
                    currency: selectedCurrency),
                const SizedBox(height: 20.0),
                ReusablePriceCard(
                    crypto: cryptoList[1],
                    rate: coinRate[cryptoList[1]]!,
                    currency: selectedCurrency),
                const SizedBox(height: 20.0),
                ReusablePriceCard(
                    crypto: cryptoList[2],
                    rate: coinRate[cryptoList[2]]!,
                    currency: selectedCurrency),
              ],
            ),
          ),

          // SELECT A CURRENCY
          Column(
            children: [
              const Text(
                "PICK A CURRENCY ⬇️",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              // BOTTOM CONTAINER
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30.0),
                color: Colors.teal,
                child: Platform.isIOS ? iOSPicker() : androidPicker(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
