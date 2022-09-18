import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //const TansactionList({Key? key}) : super(key: key);

  final List<Transaction> transactions;
  //delete transaction::
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: [
                Text(
                  'No Transaction Added Yet!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                //used for spacing between text and image..NOTE..::
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView(
            //...::::>>::: Note..listview + container height(constrain for listview)..<<:::...:::
            children: transactions.map((tx) {
              return Card(
                  child: Row(
                children: [
                  Container(
                    //Margin_desg
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    //Border_desg
                    decoration: BoxDecoration(
                        border: Border.all(
                            //acess theme..note..::..acess of theme data defined globally...NOTE..::
                            color: Theme.of(context).primaryColor,
                            width: 2)),
                    //Padding_desg
                    padding: EdgeInsets.all(10),
                    //TEXT..Amount..
                    child: Text(
                      '\$${tx.amount.toStringAsFixed(2)}', //STRING INTERPOLATION::..::..::..::NOTE::..::
                      style: TextStyle(
                          //text_styling
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          //acessing global theme
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text..Title..
                      Text(
                        tx.title,
                        //using global font theme::
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      //Text..Date..
                      Text(
                        DateFormat.yMMMd().format(tx
                            .date), // date formate using "intl package"(need to install using pub.dev)..::..::NOTE..::
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  //Adding delete transaction icon:::
                  Expanded(
                    child: MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            onPressed: () => deleteTx(tx.id),
                            icon: Icon(Icons.delete),
                            textColor: Theme.of(context).errorColor, label: Text('Delete'))
                        : IconButton(
                            onPressed: () => deleteTx(tx.id),
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                ],
              )); //Mapping of transaction
            }).toList(),
          );
  }
}
