//import dart package on top then third party package...
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'package:intl/intl.dart';

void main() {
  //restricting app to potrait mode::
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we will not use cupertinoApp() becz of limited capability:::
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      //Themeing....NOTE..:::..::
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          //adding custom font..Note..by making folder assets->fonts->pasting font file->making changes/adding font in pubspec.yaml file...NOTE::..
          fontFamily: 'Quicksand',
          //FOR REST OF THE APP GLOBAL THEME::
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          buttonColor: Colors.white,
          //APPBAR
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ))),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //switch boolean::
  bool _showChart = false;

  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 2000, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Pasta', amount: 200, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Burger', amount: 50, date: DateTime.now())
  ];

  //process to take recent 7 days...NOTE..and eleminate other days....::
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      //where allow us to write function in the list
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: choosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  //add sheet new tranction to floating icon and add icon....:::NOTES...:::
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  //delete transaction function:::
  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //check whether we are in landscape mode::::
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //app bar final so we will not change it::
    final PreferredSizeWidget app_bar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
              //style: Theme.of(context).,
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: const Icon(CupertinoIcons.add),
                onTap: (() => _startAddNewTransaction(context)),
              ),
            ]))
        : AppBar(
            title: const Text(
              'Personal Expenses',
              //style: Theme.of(context).,
            ),
            actions: [
              // ADDING ICON in app bar.....NOTE..::
              IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: const Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;

    // list widegt::::
    final txListWidget = Container(
        //deducting app bar height::responsive
        height: (MediaQuery.of(context).size.height -
                app_bar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));

    //Body:::SafeArea make sure that every thing is within the boundaries:::
    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //switch chart bar:::
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  //adaptive for ios switch::
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            //if not in landscape mode i.e when in potrait mode
            if (!isLandscape)
              Container(
                  //deducting app bar height::responsive
                  //calculating height of device to make it responsive....here we are taking 60% of available height::::NOTE:::
                  height: (MediaQuery.of(context).size.height -
                          app_bar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidget,

            //chart...NOTE....::checking whether to show chart or not:::in landscape mode
            if (isLandscape)
              _showChart
                  ? Container(
                      //deducting app bar height::responsive
                      //calculating height of device to make it responsive....here we are taking 60% of available height::::NOTE:::
                      height: (MediaQuery.of(context).size.height -
                              app_bar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  //display list of transaction...
                  : txListWidget,
          ]),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: app_bar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            // adding icon in body ...NOTE....::
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            // centering of icon body
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,

            appBar: app_bar,
            body: pageBody,
          );
  }
}
