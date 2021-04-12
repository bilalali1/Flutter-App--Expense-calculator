import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;
  void _submitData(){
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <=0 || _pickedDate == null)
      {return;}

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _pickedDate,
    );
    Navigator.of(context).pop();

  }
  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2020), lastDate: DateTime.now(),
    ).then((selectedDate) {
      if(selectedDate == null)
        return;
      setState(() {
        _pickedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_pickedDate == null ? 'No date chosen' : 'Picked Date: ${DateFormat.yMd().format(_pickedDate)}'),
                  FlatButton(onPressed: (){_presentDatePicker();}, child: Text('Choose Date',),textColor: Colors.purple,)
                ],
              ),
            ),
            FlatButton(onPressed: _submitData, child: Text('Add Transactions'),textColor: Colors.purple,),
          ],
        ),
      ),
    );
  }
}
