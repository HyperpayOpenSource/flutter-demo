import 'dart:convert';
import 'dart:io';
import 'package:flutter_demo/payment_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Ready_UI extends StatefulWidget {


  @override
  _Ready_UIState createState() => _Ready_UIState();
}

String _checkoutid = '';
String _resultText = '';

class _Ready_UIState extends State<Ready_UI> {

  static const platform = const MethodChannel('Hyperpay.demo.fultter/channel');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('READY UI'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text('Credit Card'),
                    onPressed: () {
                      _checkoutpage("credit");
                    },
                    padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  ),
                  SizedBox(height: 15),
                  RaisedButton(
                    child: Text('Mada'),
                    onPressed: () {
                      _checkoutpage("mada");
                    },
                    padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  ),
                  SizedBox(height: 15,),
                  if (Platform.isIOS)
                    RaisedButton(
                      child: Text('APPLEPAY'),
                      onPressed: () {
                        _checkoutpage("APPLEPAY");
                      },                      padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                      color: Colors.black,
                      textColor: Colors.white,
                    ),
                  SizedBox(height: 35),
                  Text(
                    _resultText,
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkoutpage(String type) async {
    //  requestCheckoutId();

    var status;

    String myUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php";
    final response = await http.post(
      myUrl,
      headers: {'Accept': 'application/json'},
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["id"]}');
      _checkoutid = '${data["id"]}';

      String transactionStatus;
      try {
        final String result = await platform.invokeMethod('gethyperpayresponse',
            {"type": "ReadyUI", "mode": "TEST", "checkoutid": _checkoutid,"brand": type,
            });
        transactionStatus = '$result';
      } on PlatformException catch (e) {
        transactionStatus = "${e.message}";
      }

      if (transactionStatus != null ||
          transactionStatus == "success" ||
          transactionStatus == "SYNC") {
        print(transactionStatus);
        getpaymentstatus();
      } else {
        setState(() {
          _resultText = transactionStatus;
        });
      }
    }
  }

  Future<void> getpaymentstatus() async {
    var status;

    String myUrl = "http://dev.hyperpay.com/hyperpay-demo/getpaymentstatus.php?id=$_checkoutid";
    final response = await http.post(
      myUrl,
      headers: {'Accept': 'application/json'},
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);


    print("payment_status: ${data["result"].toString()}");

    setState(() {
      _resultText = data["result"].toString();
    });


  }
}
