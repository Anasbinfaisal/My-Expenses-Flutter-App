import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/transaction.dart';
import 'package:my_expenses/widgets/transactions_list.dart';

class NewTransaction extends StatefulWidget {
  late final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController title_controller = TextEditingController();

  TextEditingController amount_controller = TextEditingController();

  late Transactionlist tx_list;
  DateTime? _id;

  Future<DateTime?> _datePicker() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
  }

  void _submitData() {
    double amount = double.parse(amount_controller.text);
    String title = title_controller.text;

    amount_controller.clear();
    title_controller.clear();

    if (title.isEmpty || amount < 0 || _id == null) {
      return;
    }

    widget.addtx(Transaction(_id.toString(), amount, title, _id!));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: title_controller,
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   title = value;
              // },
            ),
            TextField(
              controller: amount_controller,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                _submitData();
              },
            ),
            Expanded(
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_id == null
                          ? 'No Date Chosen!'
                          : "Picked Date: ${DateFormat('dd-MM-yyyy').format(_id!)}"),
                    ),

                    // style: const TextStyle(
                    //     fontWeight: FontWeight.normal,
                    //     fontSize: 14,
                    //     color: Colors.blueGrey),

                    TextButton(
                        onPressed: () async {
                          _id = await _datePicker();
                          setState(() {
                            _id = _id;
                          });
                        },
                        child: const Text(
                          "Choose Date",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  _submitData();
                },
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
