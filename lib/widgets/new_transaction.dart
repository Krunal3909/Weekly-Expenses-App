import '../widgets/Adaptive_flat_button.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _priceController = TextEditingController();

  DateTime _selectedDate;

  void _submitdata() {
    if (_priceController.text.isEmpty) {
      return;
    }
    final enteredtitle = _titleController.text;
    final enteredprice = double.parse(_priceController.text);

    if (enteredtitle.isEmpty || enteredprice <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredtitle,
      enteredprice,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitdata(),

                //onChanged:(String value) {
                //titleInput = value;
                //} ,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: _priceController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitdata(),
                //onChanged: (String value) {
                //priceInput = value;
                //},
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen !'
                          : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    AdaptiveFlatButton(' Choose Date !', _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitdata,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
