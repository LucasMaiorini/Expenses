import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = this._titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty ||
        value <= 0 ||
        value.isNaN ||
        this._selectedDate == null) {
      return;
    }
    //This property is inherited from the StatefulWidget and allows to get
    // parent's method.
    widget.onSubmit(title, value, this._selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        this._selectedDate = value;
      });
    });
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
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(this._selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : DateFormat('dd/MM/y', 'pt-Br')
                            .format(this._selectedDate)),
                  ),
                  TextButton(
                    onPressed: () {
                      this._showDatePicker();
                    },
                    child: Text(
                      'Alterar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text(
                    'Nova Transação',
                    // style: TextStyle(color: Colors.purple[600]),
                  ),
                  style: TextButton.styleFrom(
                    elevation: 4,
                    primary: Theme.of(context).textTheme.button.color,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
