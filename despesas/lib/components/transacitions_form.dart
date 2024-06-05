import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm(this.onSubmit);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime? _selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Titulo',
                  labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                  labelStyle: TextStyle(color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectDate == null
                        ? 'Nenhuma data selecionada'
                        : DateFormat('dd/MM/yyyy').format(_selectDate!),
                  ),
                  TextButton(
                    onPressed: _showdatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: _submitForm,
                  child:
                      Text('Adicionar', style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectDate!);
  }

  _showdatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }

      setState(() {
        _selectDate = pickDate;
      });
    });
  }
}
