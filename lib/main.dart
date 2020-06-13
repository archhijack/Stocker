import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

void main() => runApp(stocks());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: stocks(),
    );
  }
}

class stocks extends StatefulWidget {
  @override
  _stocksState createState() => _stocksState();
}

class _stocksState extends State<stocks> {
  @override
  Widget build(BuildContext context) {

    final queryTextController = TextEditingController();
    final resultTextController = TextEditingController();
    String query;

    const witURL = 'https://api.wit.ai/message?v=20200613&q=';
    const witHeader = 'Bearer UW3JCZIFHB2KUNJMMQYD4XUEKPMS3LOO';
    const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate/';
    const coinAPIKey = '3FD48454-A792-4B54-847E-67CEB07C3487';
    var rateString = '';


    changeText(crypto, fiat, currentRate) async{
      rateString = 'The current rate of $crypto in $fiat is $currentRate.';
      resultTextController.text = rateString;
      print(rateString);
      return rateString;
    }

    Future getValue(fiatCurrency, cryptoCurrency) async{
      var completeURL = '$coinAPIURL$cryptoCurrency/$fiatCurrency?apikey=$coinAPIKey';
      http.Response coinAPIResponse = await http.get(completeURL);

      if(coinAPIResponse.statusCode == 200)
        {
          String coinData = coinAPIResponse.body;

          var fiat = jsonDecode(coinData)['asset_id_quote'];
          var crypto = jsonDecode(coinData)['asset_id_base'];
          var currentRate = jsonDecode(coinData)['rate'];
          changeText(crypto, fiat, currentRate);
        }
      else
        {
          print(coinAPIResponse.statusCode);
        }
    }

    Future getIntents(query) async{
      query = query.replaceAll(new RegExp(r' '), '%20');
      http.Response witResponse = await http.get(
        '$witURL$query',
        headers: {HttpHeaders.authorizationHeader: '$witHeader'},
      );

      if(witResponse.statusCode == 200) {
        //print(witResponse.body);
        String intentData = witResponse.body;

        var cryptoCurrency = jsonDecode(intentData)['entities']['quotes:crypto'][0]['value'];
        var fiatCurrency = jsonDecode(intentData)['entities']['quotes:currency'][0]['value'];
        //print('$fiatCurrency, $cryptoCurrency');
        return getValue(fiatCurrency, cryptoCurrency);

      }
      else
      {
        print(witResponse.statusCode);
      }
    }

    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    Text('Stocker',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SF Compact Display',
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    )
                    ),
                    Text('Convert Crypto to Fiat!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Compact Display',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        )
                    ),
                  ],
                ),

                Column(
                  children: <Widget>[
                    Text('Enter Your Query:',
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(

                        controller: queryTextController,
                        onChanged: (value) {
                          query = value;
                        },

                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Query Here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                      splashColor: Colors.blue,

                      onPressed: () {
                            queryTextController.clear();
                            getIntents(query);
                      },

                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        enabled: false,

                        controller: resultTextController,

                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Result Here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: <Widget>[
                    Text("NOTE: Enter only crypto or currency code."),
                    Text("Eg.- BTC for Bitcoin; INR for Indian Rupee."),
                    Text("NOTE: DO NOT ENTER SPECIAL CHARACTERS Eg.- ?"),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )

              ],
            ),
          ),
        )
      ),
    );
  }
}
