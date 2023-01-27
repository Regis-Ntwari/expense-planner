import 'package:flutter/material.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTxns {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].price;
        }
      }
      return {'date': DateFormat.E().format(weekDay), 'amount': totalAmount};
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(15),
        child: Row(
          children: [],
        ));
  }
}
