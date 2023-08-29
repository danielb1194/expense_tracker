import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');

class CreateExpense extends StatefulWidget {
  const CreateExpense({super.key, required this.onAddExpense});

  final Function onAddExpense;

  @override
  State<StatefulWidget> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'name': '',
    'amount': null,
    'date': null,
    'type': ExpenseType.other,
  };

  void presentDatePicker() {
    DateTime now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    ).then((value) => setState(() => _formData['date'] = value));
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate() == false) {
      return;
    } else {
      _formKey.currentState!.save();
    }

    widget.onAddExpense(
      Expense(
        title: _formData['name']!,
        amount: _formData['amount']!,
        date: _formData['date']!,
        category: _formData['type'],
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                maxLength: 100,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  // border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 100) {
                    return 'Must be between 2 and 100 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['name'] = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                  // icon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Must be a valid number';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) =>
                    _formData['amount'] = double.parse(newValue!),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  // border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: _formData['date'] == null
                      ? ''
                      : _dateFormatter.format(_formData['date']!),
                ),
                onTap: presentDatePicker,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      _formData['date'] == null) {
                    return 'Must pick a date';
                  } else {
                    return null;
                  }
                }, // this one has no onSaved becase saving the data is handled by the date picker
              ),
              DropdownButtonFormField(
                value: _formData['type'],
                items: ExpenseType.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (selected) => setState(
                  () => _formData['type'] = selected as ExpenseType,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _submitExpense,
                    child: const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
