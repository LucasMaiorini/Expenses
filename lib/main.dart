import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}

class MyHomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.80,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            // width: double.infinity,
            child: Card(
              child: Text('Gráfico'),
            ),
          ),
          Column(
            children: _transactions.map((tr) {
              return Card(
                  child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.purple[300], width: 2)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'R\$ ${tr.value.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple[800]),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tr.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                            .format(tr.date),
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ],
              ));
            }).toList(),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  TextButton(
                    onPressed: () {
                      print(titleController.text);
                    },
                    child: Text(
                      'Nova Transação',
                      // style: TextStyle(color: Colors.purple[600]),
                    ),
                    style: TextButton.styleFrom(
                        elevation: 4,
                        primary: Colors.purple,
                        backgroundColor: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
