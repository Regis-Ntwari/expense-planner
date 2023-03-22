import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  //setting only portrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
      home: ExpensePlanner(),
    );
  }
}

class ExpensePlanner extends StatefulWidget {
  @override
  State<ExpensePlanner> createState() => _ExpensePlannerState();
}

class _ExpensePlannerState extends State<ExpensePlanner> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> _transactions = [
    // Transaction(id: 'S1', title: 'Shoes', price: 20.99, date: DateTime.now()),
    // Transaction(id: 'S2', title: 'Shirts', price: 14.99, date: DateTime.now()),
  ];

  bool _showChart = false;

  //transactions in the past 7 days
  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //function to add a new transaction in the list of transations
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    Transaction newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        price: txAmount,
        date: chosenDate);

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  // method to show the bottom sheet when adding a transaction
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  // method to delete a transaction
  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget listWidget) {
    return [
      Row(
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: Chart(_recentTransactions))
          : listWidget
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget listWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      listWidget
    ];
  }

  PreferredSizeWidget _buildCupertinoNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => startAddNewTransaction(context),
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Expense Planner'),
      backgroundColor: Theme.of(context).primaryColorDark,
      actions: [
        IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar =
        Platform.isIOS ? _buildCupertinoNavigationBar() : _buildAppBar();

    final listWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactions, deleteTransaction));
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final bodyContent = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, listWidget),
            // ignore: sized_box_for_whitespace
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, listWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyContent,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyContent,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    onPressed: () => startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
