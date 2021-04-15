import 'package:expense_flutter_app/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'dart:io';
import 'package:flutter/services.dart';
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

  bool _showChart = false;

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
  Widget build(BuildContext context){
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Expense Planner'),
      trailing: GestureDetector(
        child: Icon(CupertinoIcons.add),
        onTap: (){_startAddNewTransaction(context);},
      ),
    ) : AppBar(
      title: Text('Expense Planner'),
      actions: [
        IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),)
      ],
      backgroundColor: Colors.purple,
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
        child: TransactionList(_userTransactions,_deleteTransaction));
    final bodyPage = SafeArea(
        child:SingleChildScrollView(
        child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Visibility(
            visible: isLandScape == true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart',style: TextStyle(fontSize: 12.0),),
                    Switch.adaptive(activeColor: Colors.purple,
                        value: _showChart, onChanged: (val){
                          setState(() {
                            _showChart = val;
                          });
                        }),
                  ],
                ),
                (isLandScape && _showChart) ?
                Container(
                    height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                    child: Chart(_recentTransaction))
                    : txListWidget,
              ],
            ),
          ),

          Visibility(
            visible: isLandScape == false,
            child: Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransaction)),
          ),
          Visibility(
              visible: isLandScape == false,
              child: txListWidget
          ),
        ],
      ),
    ),);
    return  Platform.isIOS ? CupertinoPageScaffold(child: bodyPage) : Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
