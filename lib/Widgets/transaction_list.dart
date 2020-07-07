import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Container(
                        height: 200,
                        child: Image.asset('assets/images/image02.png',
                            fit: BoxFit.cover)),
                    SizedBox(height: 20),
                    Text(
                      'No Expense Added Yet !!!',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ])
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '${transactions[index].amount} Rs',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          )),
                          padding: EdgeInsets.all(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                                DateFormat.yMMMMEEEEd()
                                    .add_jm()
                                    .format(transactions[index].date),
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 15)),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
