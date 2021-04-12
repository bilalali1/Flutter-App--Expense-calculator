import './chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
 final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for(int i = 0; i < recentTransaction.length ; i++)
        if(recentTransaction[i].date.day == weekDay.day &&
      recentTransaction[i].date.month == weekDay.month &&
      recentTransaction[i].date.year == weekDay.year)
          totalSum += recentTransaction[i].amount;

        return{
          'day': DateFormat.E().format(weekDay).substring(0,1),
          'amount': totalSum,
        };
    }).reversed.toList();
  }
double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) => sum + item['amount']);
}



  @override
  Widget build(BuildContext context) {

    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: groupedTransactionValues.map((data) =>
          Flexible( fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'], totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending))
        ).toList(),
        ),
      ),
    );
  }
}
