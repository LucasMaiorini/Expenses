import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || value.isNaN) {
      return;
    }
    //This property is inherited from the StatefulWidget and allows to get
    // parent's method.
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            TextButton(
              onPressed: () {
                _submitForm();
              },
              child: Text(
                'Nova Transação',
                // style: TextStyle(color: Colors.purple[600]),
              ),
              style: TextButton.styleFrom(
                  elevation: 4,
                  primary: Colors.purple,
                  backgroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
