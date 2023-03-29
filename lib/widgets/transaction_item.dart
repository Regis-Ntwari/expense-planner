import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color color = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    const colors = [Colors.black, Colors.blue, Colors.grey, Colors.green];

    color = colors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FittedBox(child: Text('\$${widget.transaction.price}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? OutlinedButton.icon(
                onPressed: (() =>
                    widget.deleteTransaction(widget.transaction.id)),
                icon: Icon(Icons.delete),
                label: Text('Delete'))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: (() =>
                    widget.deleteTransaction(widget.transaction.id)),
              ),
      ),
    );
  }
}
