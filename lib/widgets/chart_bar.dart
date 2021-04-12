import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final lable;
  double spendingAmount;
  double spendingAmountPercentage;
  ChartBar(this.lable,this.spendingAmount,this.spendingAmountPercentage);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60.0,
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
        ),
        SizedBox(
          height: 4,
        ),
        Text(lable),

      ],
    );
  }
}
