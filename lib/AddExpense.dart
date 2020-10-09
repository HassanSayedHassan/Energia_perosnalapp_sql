import 'dart:developer';

import 'package:energia_perosnalapp_sql/Model/MyExpences.dart';
import 'package:energia_perosnalapp_sql/ShowList.dart';
import 'package:energia_perosnalapp_sql/Utlis/database_helper.dart';
import 'package:flutter/material.dart';

import 'package:energia_perosnalapp_sql/AddExpense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String title;
  int amount;
  DateTime _selectedDate;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('add New Expenses'),

      ),

      body: Card(
        elevation: 5,
        borderOnForeground: true,
        color: Colors.white70,

        child: Padding(
          padding: const EdgeInsets.only(top: 12,right: 12,left: 12,bottom: 12),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter title'
                    ),
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter amount'
                    ),
                    onChanged: (value) {
                      setState(() {
                        amount = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : ' ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                      FlatButton(
                        child: Text('click to  add data'),
                        textColor: Colors.purple,
                        onPressed: () {
                          _presentDatePicker();
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () async {
                      var db = new database_helper();
                      if (title != null && _selectedDate!= null &&
                          amount != null) {
                        int expSaved = await db.saveExpense(
                            new MyExpences(title, _selectedDate.toString(),
                                amount));

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (c) {
                              return ShowList();
                            })
                            , (route) => false);
                      }
                      else {
                        _displaySnackBar(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please Insert All Fields'),
      backgroundColor:Colors.red,);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
