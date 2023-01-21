import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/transaction.dart';

class Transactionlist extends StatefulWidget {
  Transactionlist(this.transactions, this.deleteTx);

  final Function deleteTx;

  late final List<Transaction> transactions;
  late final List<Transaction> items = transactions;
  // final List<Transaction> items = transactions;

  @override
  State<Transactionlist> createState() => _TransactionlistState();
}

class _TransactionlistState extends State<Transactionlist> {
  bool isreversed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.purple,
          child: TextButton.icon(
            style: const ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(
              Icons.sort,
              color: Colors.white,
              size: 40,
            ),
            // alignment: Alignment.centerRight,
            onPressed: () {
              setState(() {
                isreversed = !isreversed;
                // widget._foundtransactions.reversed;
                // .sort((a, b) => a.date.compareTo(b.date));
              });
            },
            label: Text(
              isreversed ? 'Descending ' : 'Ascending',
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        Container(
          height: 450,
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final sorted_items =
                  isreversed ? widget.items.reversed.toList() : widget.items;
              final item = sorted_items[index];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Text(
                          '\$${item.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    item.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    DateFormat('EEEE, dd-MM-yyyy').format(item.date),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.blueGrey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      widget.deleteTx(item.id);
                    },
                  ),
                ),
              );
              // return Card(
              //   elevation: 5,
              //   child: Row(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           border: Border.all(
              //             color: Colors.purple,
              //             width: 2,
              //           ),
              //         ),
              //         margin: EdgeInsets.all(8),
              //         child: Text(
              //           '\$${transactions[index].amount.toStringAsFixed(2)}',
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16,
              //               color: Colors.purple),
              //         ),
              //         padding: EdgeInsets.all(10),
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title!,
              //             style:
              //                 TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //           ),
              //           Text(
              //             DateFormat('EEEE, dd-MM-yyyy')
              //                 .format(transactions[index].date),
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.normal,
              //                 fontSize: 14,
              //                 color: Colors.blueGrey),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
            },
          ),
        ),
      ],
    );
  }
}
