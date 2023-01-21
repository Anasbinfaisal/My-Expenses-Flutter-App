import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/chart.dart';
import 'package:my_expenses/widgets/add_new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/transactions_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyExpenses',
      theme:
          ThemeData(primarySwatch: Colors.purple, accentColor: Colors.yellow),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<Transaction> transactions = [
    Transaction('27-09-2022', 29.999, 'New Car',
        DateFormat('dd-MM-yyyy').parse('27-09-2022')),
    Transaction('26-09-2022', 29.999, 'New Car', DateTime.now()),
    Transaction('25-09-2022', 29.999, 'New Car',
        DateFormat('dd-MM-yyyy').parse('26-09-2022')),
    Transaction('24-09-2022', 29.999, 'New Car',
        DateFormat('dd-MM-yyyy').parse('25-09-2022')),
    Transaction('23-09-2022', 29.999, 'New Car',
        DateFormat('dd-MM-yyyy').parse('24-09-2022')),
    Transaction('23-09-2022', 29.999, 'New Car',
        DateFormat('dd-MM-yyyy').parse('23-09-2022')),
    Transaction('22-09-2022', 29.999, 'New Car',
        DateFormat('dd-MM-yyyy').parse('22-09-2022')),

    // Transaction('t1', 69.99, 'New Shoes', DateTime.now()),
    // Transaction('t2', 99.99, 'New Hat', DateTime.now()),
  ];

  List<Transaction> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(Transaction tx) => setState(() {
        transactions.add(tx);
      });

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyExpenses'),
        actions: [
          IconButton(
              onPressed: () {
                _startAddTransaction(context);
              },
              icon: Icon(Icons.add))
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions),
            // Card(
            //   color: Colors.blue,
            //   child: Container(width: 100, child: Text('Chart')),
            //   elevation: 5,
            // ),
            // UserTransactions(),
            transactions.length == 0
                ? Column(
                    children: [
                      Container(
                        height: 450,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('No Transactions Added!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25)),
                        ),
                      ),
                      Icon(
                        Icons.add_box,
                        size: 100,
                      ),
                    ],
                  )
                : Transactionlist(transactions, _deleteTransaction),
            //Input Card
          ],
        ),
      ), //List of Transactions Card
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.black45,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
