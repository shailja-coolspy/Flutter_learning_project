import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
//to format date
import 'package:intl/intl.dart';

// ONLY ADDING OF NEW TRANSACTION TAKE PLACE HERE....
class NewTransaction extends StatefulWidget {
  //addtx::
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //const NewTransaction({Key? key}) : super(key: key);
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  //date storing
  DateTime? _selectedDate;

  //note on pressed function
  void _submitData() {

    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }

    //add new transaction
    //widget class help to acess "NewTransaction" class property...::NOTE::..::
    widget.addTx(enteredTitle, enteredAmount,_selectedDate);

    //it close the card after adding new transaction....automatically
    //context related to ur widget..
    Navigator.of(context).pop();
  }

  //Date Picker:::
  void _presentDatePicker() {
    //flutter provide this
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      // it says something has been updated and build should run again.....NOTE...::
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController, //or to fetch input
            // onChanged: (val) {
            //   // use this having multiple line code in function |save input
            //   titleInput = val;
            // },
            onSubmitted: (_) => _submitData(),
          ), // It takes user input
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController, //or to fetch input
            //onChanged: (val) => amountInput =val, //use this when having single line of code in function|save input
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          //ADDING datepicker....note
          Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    _selectedDate == null
                        ? 'No,Date Choosen'
                        : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}',
                  )),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              )),
          RaisedButton(
            child: Text('Add Transaction'),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).buttonColor,
            onPressed: _submitData, // () {
            // print(titleController.text);
            // print(amountController.text);

            //},
          )
        ]),
      ),
    );
  }
}
