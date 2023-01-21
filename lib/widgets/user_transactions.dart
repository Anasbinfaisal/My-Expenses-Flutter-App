import 'package:flutter/cupertino.dart';
import 'package:my_expenses/widgets/transactions_list.dart';

import '../models/transaction.dart';
import 'add_new_transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // NewTransaction(_addTransaction),
      ],
    );
  }
}
