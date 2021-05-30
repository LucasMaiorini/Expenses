import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.blue,
    Colors.black,
    Colors.grey,
    Colors.orange,
    Colors.red
  ];

  Color _backgroundColor;
  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    this._backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: this._backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.tr.value}'),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y', 'pt-Br').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(Icons.delete),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor),
                label: const Text('Excluir'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  this.widget.onRemove(widget.tr.id);
                },
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
