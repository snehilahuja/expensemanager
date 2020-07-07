import './Widgets/chart.dart';

import './Widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './Widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'FrancoisOne',
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'Acme',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'Acme',
                    fontSize: 27,
                  )))
          // accentColor: Colors.purple,
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransations = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 2500, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Weekly Groceries', amount: 1500, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransations.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: chosenDate.toString());

    setState(() {
      _userTransations.add(newTx);
    });
  }

  void _startNewAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.green,
          title: Text('Expense Manager'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.playlist_add,
                //  color: Colors.black,
                size: 35,
              ),
              onPressed: () => _startNewAddTransaction(context),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransations),
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 30,
              onPressed: () => _startNewAddTransaction(context)),
          onPressed: () => _startNewAddTransaction(context),
          // backgroundColor: Theme.of(context).accentColor,
        ));
  }
}
