import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets\\images\\empty.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.3,
                    child: Text(
                      'Nenhuma transação cadastrada.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              );
            },
          )
        :
        // This manner to handle ListView is used once you need to control its
        // states in a Stateless Widget (List). In this case we'll use key
        //  to attach an element with its corresponding widget.
        ListView(
            children: transactions.map((transaction) {
              return TransactionItem(
                //Sets a fix value to a key to help it keeps its state even when
                //the widget changes
                key: ValueKey(transaction.id),
                tr: transaction,
                onRemove: onRemove,
              );
            }).toList(),
          );
    //  ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       final tr = transactions[index];
    //GlobalObjectKey is more expensive in terms of performance than ValueKey
    //       return TransactionItem(key: GlobalObjectKey(tr), tr: tr, onRemove: onRemove,);
    //     },
    //   );
  }
}
