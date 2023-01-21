import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingpercent;

  ChartBar(this.label, this.spendingamount, this.spendingpercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 30,
            child: FittedBox(
                child: Text("\$${spendingamount.toStringAsFixed(0)}"))),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20),
              )),
              FractionallySizedBox(
                heightFactor: spendingpercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
