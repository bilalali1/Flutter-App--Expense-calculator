
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 400.0,
      child: transactions.isEmpty ? Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Text('No Transactions has been added yet'),
          SizedBox(
            height: 20.0,
          ),
      Container(height: 200.0,child: Image.asset('assets/img.png',fit: BoxFit.cover,)),
        ],
      ) : ListView.builder(
        itemBuilder: (context, index){
       return Card(
         elevation: 5,
         margin: EdgeInsets.symmetric(
           vertical: 8.0,
           horizontal: 4.0,
         ),
         child: ListTile(
           leading: CircleAvatar(
             backgroundColor: Colors.purple,
             radius: 30.0,
             child: Padding(
               padding: EdgeInsets.all(6),
               child: FittedBox(
                 child: Text('\$${transactions[index].amount}'),
               ),
             ),
           ),
           title: Text(transactions[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
           subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: (){ deleteTx(transactions[index].id);},
            ),
         ),
       );
        },
        itemCount: transactions.length,
    ),
    );
  }
}
