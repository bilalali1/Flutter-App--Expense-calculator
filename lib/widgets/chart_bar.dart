import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final lable;
  double spendingAmount;
  double spendingAmountPercentage;
  ChartBar(this.lable,this.spendingAmount,this.spendingAmountPercentage);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10.0,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                FractionallySizedBox(heightFactor: spendingAmountPercentage,
                  child: Container(decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0)
                  ),),),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(lable),),),

        ],
      );
    }
    );
  }
}
