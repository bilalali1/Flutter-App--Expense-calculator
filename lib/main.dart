import 'package:expense_flutter_app/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
main(){
  runApp(MaterialApp(
    home: ExpensePlanner(),
  ));
}


class ExpensePlanner extends StatefulWidget {

  @override
  _ExpensePlannerState createState() => _ExpensePlannerState();
}

class _ExpensePlannerState extends State<ExpensePlanner> {
   List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
}


  final List<Transaction> _userTransactions = [
    // Transaction(title: 'New Shoes',id: '1', date: DateTime.now(),amount:22.0),
    // Transaction(title: 'Clothes',id: '2', date: DateTime.now(),amount:44.0),

  ];
  _addUserTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final newTransaction = Transaction(title: txTitle, id: DateTime.now().toString(), amount: txAmount, date: chosenDate);

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return GestureDetector(
          onTap: (){},
          child: NewTransactions(_addUserTransaction),
          behavior: HitTestBehavior.opaque,
      );
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),)
        ],
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            Container(
              width: double.infinity,
              child: Card(
                child: Chart(_recentTransaction),
              ),
            ),

            TransactionList(_userTransactions,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
