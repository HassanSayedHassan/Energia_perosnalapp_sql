
class MyExpences{
  String  title ;
  String  data ;
  int  amount ;
  int id;


  MyExpences(this.title, this.data, this.amount);

  MyExpences.map(dynamic obj){
    this.title = obj['title'];
    this.data = obj['data'];
    this.amount = obj['amount'];
    this.id = obj['id'];
  }

  String get _title => title;
  String get _data => data;
  int get _amount => amount;
  int get _id => id;

  Map<String , dynamic> toMap(){
    var map = new Map<String , dynamic>();
    map['title'] = _title;
    map['data'] = _data;
    map['amount'] = _amount;
    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  MyExpences.fromMap(Map<String , dynamic>map){
    this.title = map['title'];
    this.data = map['data'];
    this.amount = map['amount'];
    this.id = map['id'];
  }



}