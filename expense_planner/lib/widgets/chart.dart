import 'package:expense_planner/models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Chart extends StatelessWidget {
  //const Chart({Key? key}) : super(key: key);
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  //....NOTE....::::......NOTE......:::::...
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      //total money spend on that day of the week...NOTE..::::
      var totalSum = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      //print::
      //print(DateFormat.E().format(weekDay));
      //print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
    //ordering reversed.toList()
  }

  //calculatting spending percentage of amount...NOTE....:::
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print::
    //print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                //tight takes up available remanning space but it not makes pixel out of border......NOTE....
                //or expanded widget
                fit: FlexFit.tight,
                //calling constructor chart_bar.dart....
                child: ChartBar(
                    (data['day'] as String),
                    (data['amount'] as double),
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ));
  }
}
