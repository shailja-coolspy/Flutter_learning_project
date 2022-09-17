import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              ),),
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

  void _addNewTransaction(String txTitle, double txAmount,DateTime choosenDate) {
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
  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id==id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // adding icon in body ...NOTE....::
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      // centering of icon body
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          //style: Theme.of(context).,
        ),
        actions: [
          // ADDING ICON in app bar.....NOTE..::
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //chart...NOTE....::
              Chart(_recentTransactions),
              //display list of transaction...
              TransactionList(_userTransaction,_deleteTransaction),
            ]),
      ),
    );
  }
}
