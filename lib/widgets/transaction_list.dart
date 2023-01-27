import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No Transactions added",
                  style: ThemeData.light().textTheme.titleMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 200,
                    child: Image.asset('assets/images/nothing.jpeg'))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColorDark,
                                width: 2)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          transactions[index].price.toStringAsFixed(2),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat().format(transactions[index].date),
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
