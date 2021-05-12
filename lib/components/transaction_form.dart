import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_date_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
                label: 'Título',
              ),
              AdaptativeTextField(
                onSubmitted: (_) => _submitForm(),
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                selectedDate: this._selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
