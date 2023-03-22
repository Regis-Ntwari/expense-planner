import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

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
                return TransactionItem(
                    transaction: transactions[index],
                    deleteTransaction: deleteTransaction);
              },
              itemCount: transactions.length,
            ),
    );
  }
}
