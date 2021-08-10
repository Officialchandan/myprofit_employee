import 'package:flutter/material.dart';
import 'package:myprofit_employee/src/ui/drawer/drawer.dart';
import 'package:myprofit_employee/src/ui/driver_form/driver_form.dart';

class DriverList extends StatefulWidget {

  final Function onTab;
  DriverList( {Key? key, required this.onTab ,}) : super(key: key);

  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {

  var nameList = ['John Parker', 'George Smith', 'Devin Coinneach', 'Brayden Aaron'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Color.fromRGBO(102, 87, 244, 1),
          leading: Builder(
            builder: (BuildContext context){
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
                  child: Image.asset('images/@3x/w-menu.png'),
                ),
                onTap: () {
                  widget.onTab();
                },
              );
            },
          ),
          title: Text('Driver List', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            GestureDetector(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 14, 16, 0),
                    padding: EdgeInsets.fromLTRB(14, 7, 25, 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text('Add Driver ', style: TextStyle(color: Color.fromRGBO(102, 87, 244, 1), fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  Positioned(
                    top: 9,
                    right: 4,
                    child: Image.asset('images/@3x/w-plus.png', width: 40),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverForm()),
                );
              },
            )
          ],
        ),

        body: ListView(
          children: List.generate(4, (index){
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Color(0xffcdcdcd))),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(nameList[index], style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('+91 9820347326', style: TextStyle(color: Color(0xff555555), fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('images/g-pin.png', width: 13),
                        Text('2859, Timbercrest Road', style: TextStyle(color: Color(0xff555555), fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverForm()),
                );
              },
            );
          }),
        ),

      ),
    );
  }
}
