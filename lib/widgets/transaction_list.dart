import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (builder, constarints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Transactions added",
                    style: ThemeData.light().textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: constarints.maxHeight * 0.1,
                  ),
                  SizedBox(
                      width: constarints.maxHeight * 0.7,
                      child: Image.asset('assets/images/nothing.jpeg'))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].price}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? OutlinedButton.icon(
                            onPressed: (() =>
                                deleteTransaction(transactions[index].id)),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'))
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: (() =>
                                deleteTransaction(transactions[index].id)),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
