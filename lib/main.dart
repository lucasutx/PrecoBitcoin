import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String preco = '0';
  Map<String, dynamic> retorno = Map();
  void recuperaPreco() async {
    String url = 'https://blockchain.info/ticker';

    http.Response ret = await http.get(Uri.parse(url));

    retorno = jsonDecode(ret.body);
    

    setState(() {
      preco = retorno['BRL']['buy'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange, // Define a cor laranja
            title: Center(
              child: Text(
                'Atualização de Preços do Bitcoin',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Sedan', color: Colors.white),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/bitcoin.png',
                    width: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    
                    child: Text('R\$ ${preco}'),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                        onPressed: recuperaPreco,
                        child: Text(
                          'Atualizar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orangeAccent),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ))),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
