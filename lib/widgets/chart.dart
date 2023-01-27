import 'package:expense_planner/widgets/Chart_bar.dart';
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
      return {
        'date': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalAmount
      };
    });
  }

  double get totalSpent {
    return groupedTxns.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTxns.map((txn) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      label: txn['date'].toString(),
                      spendingAmount: double.parse(txn['amount'].toString()),
                      spendingPct: totalSpent == 0.0
                          ? 0.0
                          : (txn['amount'] as double) / totalSpent),
                );
              }).toList()),
        ));
  }
}
