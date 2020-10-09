
import 'package:energia_perosnalapp_sql/AddExpense.dart';
import 'package:energia_perosnalapp_sql/Model/MyExpences.dart';
import 'package:energia_perosnalapp_sql/Utlis/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  String title, content;
  int hours;
  List myExplist= new List();
  DateTime _selectedDate;
  var db = new database_helper();
  @override
  Future<void> initState()  {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddExpense())),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: myExplist.length,
              itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              // padding: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.pink,
                              ),
                              width: 60,
                              height: 60,
                              child: Text(
                                '\$ ${myExplist[index]['amount']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myExplist[index]['title'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        getdata(myExplist[index]['data']),
                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  IconButton(icon: Icon(Icons.delete, color: Colors.red,),onPressed: (){
                                    database_helper().deleteUser(myExplist[index]['id']);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                                      return ShowList();
                                    })
                                    );
                                  },),



                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

              },

            ),
          )
        ],

      ),
    );
  }
  String getdata(String data){
    DateTime todayDate = DateTime.parse(data);
    return DateFormat("yyyy/MM/dd").format(todayDate);
  }

  Future<void> loadData() async {
      database_helper().getAllExpences().then((result){
        setState(() {
          myExplist.addAll(result);
        });
      });


  }
}
